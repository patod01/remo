import sqlite3, os, sys

print(sqlite3.sqlite_version)
# sys.exit()

data_base = 'remo.db'

if not os.path.isfile(data_base):
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

     setup_query = schema + '\n' + v_list + '\n' + v_remotes + '\n' + v_count
     print(setup_query)
     
     with sqlite3.connect(data_base) as con:
          con.executescript(setup_query)
