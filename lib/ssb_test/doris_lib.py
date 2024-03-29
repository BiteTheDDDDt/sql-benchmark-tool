#!/usr/bin/env python
# -- coding: utf-8 --
###########################################################################
#
# Copyright (c) 2020 Copyright (c) 2020, Dingshi Inc.  All rights reserved.
#
###########################################################################
"""
 api lib in this module
"""
import os
import logging
import re
import json
import subprocess
import time
import sys
import hashlib
import hmac
import datetime
import random
#import httplib

import pymysql as _mysql

sys.path.append(".")
import conf_parser

root_path = os.path.dirname(os.path.abspath(__file__)) + "/../.."


class DorisException(Exception):
    def __init__(self, value):
        self.value = value
    def __str__(self):
        return repr(self.value)


"""
class HttpLib(object):
    def __init__(self):
        self.conn = None

    def create_http_connection(self, ip, port):
        self.conn = httplib.HTTPConnection(ip, port)

    def get_http_response(self, url):
        self.conn.request("GET", url)
        return self.conn.getresponse()

    def get_post_response(self, url):
        self.conn.request("POST", url)
        return self.conn.getresponse()
"""


class MysqlLib(object):
    """ mysqllib class """
    def __init__(self):
        self.connector = ""

    def connect(self, query_dict):
        if "database" not in query_dict:
            self.connector = _mysql.connect(
                                   host = query_dict["host"],\
                                   user = query_dict["user"],\
                                   port = int(query_dict["port"]),
                                   passwd = query_dict["password"]
                                   )
        else:
            self.connector = _mysql.connect(
                                   host = query_dict["host"],\
                                   user = query_dict["user"],\
                                   passwd = query_dict["password"],\
                                   db = query_dict["database"]
                                   )

    def execute(self, sql, sql_type):
        """ execute query """
        try:
            with self.connector.cursor() as cursor:
                cursor.execute(sql)
                if sql_type == "ddl":
                    self.connector.commit()
                    return {"status" : True, "msg": cursor._result.message}
                elif sql_type == "dml":
                    result = cursor.fetchall()
                    return {"status" : True, "result" : result, "msg": cursor._result.message}
                else:
                    return {"status" : False, "msg": "it's not ddl or dml type, exit."}
        except _mysql.Error as e:
            return {"status" : False, "msg": e.args}
        except Exception as e:
            print ("unknown error", e)
            raise

    def close(self):
        if self.connector != "":
            self.connector.close()


class HdfsLib(object):
    """hdfs operation"""
    def __init__(self):
        self.hadoop_client = "%s/bin/hdfs" % (conf_parser.hadoop_home)

    def ls(self, hdfs_path):
        file_list = []
        cmd = "HADOOP_USER_NAME=%s %s dfs -ls %s" % (conf_parser.broker_username, self.hadoop_client, hdfs_path)
        res, output = subprocess.getstatusoutput(cmd)
        if res != 0:
            print("execute cmd: %s error, msg: %s" % (cmd, output))
            return file_list

        files = output.split("\n")
        for file_info in files:
            infos = file_info.split()
            if len(infos) != 8:
                continue
            # skip dir
            if infos[0].startswith("d"):
                continue
            file_list.append((infos[4], infos[7]))
        return file_list


class CommonLib(object):
    """ api lib """
    def __init__(self):
        self.mysql_lib = MysqlLib()
        #self.http_lib = HttpLib()
        self.hdfs_lib = HdfsLib()
        self.mysql_host = ""
        self.mysql_port = ""
        self.http_address = ""
        self.http_port = ""
        self.base_sql_file_dir = "%s/share/ssb_test/sql" % (root_path)
        self.query_sql_dir = "%s/query" % (self.base_sql_file_dir)
        self.create_db_table_sql_dir = "%s/ddl" % (self.base_sql_file_dir)
        self.flat_insert_sql_dir = "%s/insert" % (self.base_sql_file_dir)
        self.result_file_dir = "%s/share/ssb_test/result" % (root_path)

        self.database = ""
        self.data_path = ""
        self.read_conf()

    def __del__(self):
        pass

    def setUp(self):
        """ set up:read cluster conf """
        pass

    def tearDown(self):
        """ tear down """
        pass

    def read_conf(self):
        """ read conf """
        self.mysql_host = conf_parser.doris_mysql_host
        self.mysql_port = conf_parser.doris_mysql_port
        self.mysql_user = conf_parser.doris_mysql_user
        self.mysql_password = conf_parser.doris_mysql_password
        self.database = conf_parser.doris_db
        #self.http_address = conf_parser.doris_http_address
        self.http_port = conf_parser.doris_http_port

    def get_http_response(self, url):
        """  get http response  """
        #self.http_lib.create_http_connection(self.http_address, self.http_port)
        #return self.http_lib.get_http_response(url)
        pass

    def connect_doris(self):
        mysql_dict = {
                "host": self.mysql_host,\
                "port": self.mysql_port,\
                "user": self.mysql_user,\
                "password": self.mysql_password
        }
        self.mysql_lib.connect(mysql_dict);

    def close_doris(self):
        self.mysql_lib.close();

    def execute_sql(self, sql, sql_type):
        """
        execute ddl sql
        """
        return self.mysql_lib.execute(sql, sql_type)

    def get_sqls_from_file(self, sql_file):
        """
        get sql from file
        """
        sql_list = []
        with open(sql_file, 'r') as f:
            for line in f.readlines():
                sql_list.append(line)
        return sql_list

    def set_parallel(self, parallel_num):
        """ """
        sql = "set global parallel_fragment_exec_instance_num = %s" % parallel_num
        sql = "set global parallel_pipeline_task_num = %s" % parallel_num
        return self.execute_sql(sql, "ddl")

    def get_parallel_cmd(self, query_dict):
        """ """
        cmd = "mysqlslap -h%s -P%s -u%s --concurrency=%s \
               --number-of-queries=%d \
               --pre-query=\"set global parallel_fragment_exec_instance_num = %s;\" \
               --post-query=\"set global parallel_fragment_exec_instance_num = 1;\" \
               --create-schema=%s --query=\"%s\""\
               % (self.mysql_host, self.mysql_port,self.mysql_user,
                  query_dict["concurrency"], query_dict["num_of_queries"],
                  query_dict["parallel_num"], query_dict["database"],
                  query_dict["sql"])
        if self.mysql_password:
            cmd = "%s -p%s" % (cmd, self.mysql_password)
        return cmd

    def create_database(self, database_name):
        """
        create doris database
        """
        sql = "create database if not exists `%s`" % database_name
        return self.execute_sql(sql, "ddl")

    def use_database(self, db_name):
        return self.execute_sql("use %s" % db_name, "ddl")

    def create_and_use_database(self):
        self.create_database(self.database)
        return self.use_database(self.database)

    def show_databases(self):
        """show databases"""
        sql = "show databases"
        return self.execute_sql(sql, "dml")

    def exists_database(self, database_name):
        """ check database exists """
        res = self.show_databases()["result"]
        return database_name in [x for y in res for x in y]

    def get_sql_from_file(self, sql_path):
        """
        get sql from file
        """
        with open(sql_path, 'r') as f:
            sql = ""
            for line in f.readlines():
                line = line.strip()
                if not line.startswith("--"):
                    sql += " " + line
        return sql

    def get_sqls_from_dir(self, dir_path):
        """
        get sql list from dir
        """
        sql_list = []
        files = os.listdir(dir_path)
        for create_file in files:
            if not create_file.startswith("."):
                file_path = "%s/%s" % (dir_path, create_file)
                sql = self.get_sql_from_file(file_path)
                sql_dict = {}
                sql_dict["file_name"] = create_file.split(".")[0]
                sql_dict["sql"] = sql
                sql_list.append(sql_dict)
        return sql_list

    def get_query_table_sqls(self, sql_dir):
        return self.get_sqls_from_dir("%s/%s" % (self.query_sql_dir, sql_dir))

    def get_create_db_table_sqls(self, sql_dir):
        self.create_db_table_sql_dir = "%s/%s" % (self.base_sql_file_dir, sql_dir)
        return self.get_sqls_from_dir(self.create_db_table_sql_dir)

    def get_flat_insert_sqls(self):
        return self.get_sqls_from_dir(self.flat_insert_sql_dir)

    def get_query_sql_dirs(self):
        sql_dirs = os.listdir(self.query_sql_dir)
        return [sql_dir for sql_dir in sql_dirs
                if os.path.isdir("%s/%s" % (self.query_sql_dir, sql_dir))]

    def get_query_base_result(self, sql_dir, scale, file_name):
        result_file_name = "%s.sql.res" % (file_name)
        result_file_path = "%s/%d/%s/%s" % (self.result_file_dir, scale, sql_dir, result_file_name)
        if not os.path.isfile(result_file_path):
            return None
        base_result = []
        with open(result_file_path, "r") as f:
            for line in f:
                base_result.append(line.strip("\n"))
        return base_result

    def get_load_data_paths(self, data_dir_path):
        load_data_paths = {}
        files = os.listdir(data_dir_path)
        for data_file in files:
            if not data_file.startswith("."):
                file_path = "%s/%s" % (data_dir_path, data_file)
                file_name = data_file.split(".")[0]
                if file_name not in load_data_paths:
                    load_data_paths[file_name] = []
                load_data_paths[file_name].append(file_path)
        return load_data_paths

    def get_stream_load_cmd(self, file_path, table_name):
        cmd = "curl --location-trusted -u %s:%s -T %s -H \"column_separator:|\" http://%s:%s/api/%s/%s/_stream_load" \
            % (self.mysql_user, self.mysql_password, file_path, self.mysql_host, self.http_port, self.database, table_name)
        return cmd

    def get_broker_load_sql(self, db_name, table_name, job_file_list, file_columns,
                            columns_from_path):
        """
        LOAD LABEL db_name.label
	(DATA INFILE("file1", "file2")
         INTO TABLE table_name
         COLUMNS TERMINATED BY ","
         FORMAT AS "orc"
         (k1, k2, k3)
         COLUMNS FROM PATH AS (k4,k5)
        )
        WITH BROKER "broker0"
        PROPERTIES ("username"="user", "password"="passwd")
        """
        label = "%s_%d_%d" % (table_name, int(time.time()*1000), int(random.random()*100))
        job_file_list = ["\"%s\"" % (job_file) for job_file in job_file_list]
        cmd = "LOAD LABEL %s.%s (DATA INFILE (%s) INTO TABLE %s"\
            % (db_name, label, ",".join(job_file_list), table_name)
        if conf_parser.column_separator:
            cmd = cmd + " COLUMNS TERMINATED BY \"%s\"" % (conf_parser.column_separator)
        if conf_parser.file_format:
            cmd = cmd + " FORMAT AS \"%s\"" % (conf_parser.file_format)
        if file_columns:
            cmd = cmd + " (%s)" % (",".join(file_columns))
        if columns_from_path:
            cmd = cmd + " COLUMNS FROM PATH AS (%s)" % (",".join(columns_from_path))
        cmd = cmd + ") WITH BROKER \"%s\"" % (conf_parser.broker_name)
        if conf_parser.broker_username:
            cmd = cmd + " (\"username\"=\"%s\"" % (conf_parser.broker_username)
            if conf_parser.broker_password:
                cmd = cmd + ", \"password\"=\"%s\"" % (conf_parser.broker_password)
            cmd = cmd + ")"
        cmd = cmd + " PROPERTIES(\"max_filter_ratio\"=\"%s\", \"timeout\"=\"%s\");"\
            % (conf_parser.max_filter_ratio, conf_parser.timeout)
        return cmd

    def get_hdfs_file_infos(self, hdfs_path):
        return self.hdfs_lib.ls(hdfs_path)

