import sqlite3, os, sys

print(sqlite3.sqlite_version)
data_base = 'remo.db'

if not os.path.isfile(data_base):
     ### Setup ###
     with open('query/schema.sql') as schema:
          schema = ''.join(schema.readlines())
          # print(schema)
     with open('query/list_view.sql') as v_list:
          v_list = ''.join(v_list.readlines())
          # print(v_list)
     with open('query/remotes_view.sql') as v_remotes:
          v_remotes = ''.join(v_remotes.readlines())
          # print(v_remotes)
     with open('query/count_view.sql') as v_count:
          v_count = ''.join(v_count.readlines())
          # print(v_count)

     setup_query = 'BEGIN TRANSACTION;' + '\n' + schema + '\n' + v_list + '\n' + v_remotes + '\n' + v_count + 'COMMIT;'
     print(setup_query)
     
     with sqlite3.connect(data_base) as con:
          con.executescript(setup_query)

     ### Mock ###
     with open('query/moco.sql') as mock:
          mock = ''.join(mock.readlines())
          print(mock)

     with sqlite3.connect(data_base) as con:
          con.executescript(mock)
