import os, json, time, sqlite3, sys
from flask import (
     Flask, request, render_template,
     url_for, redirect, jsonify,
)
from flask_socketio import SocketIO, emit


### Basic setup ###

# Database initialization / creation #
data_base = 'data/remo.db'

if not os.path.isfile(data_base):
     data_base = 'data/test.db'

if not os.path.isfile(data_base):
     # Setup #
     with open('query/schema.sql') as schema:
          schema = ''.join(schema.readlines())
     with open('query/list_view.sql') as v_list:
          v_list = ''.join(v_list.readlines())
     with open('query/remotes_view.sql') as v_remotes:
          v_remotes = ''.join(v_remotes.readlines())
     with open('query/count_view.sql') as v_count:
          v_count = ''.join(v_count.readlines())

     setup_query = 'BEGIN TRANSACTION;\n' \
                 + schema + '\n' \
                 + v_list + '\n' \
                 + v_remotes + '\n' \
                 + v_count \
                 + 'COMMIT;'
     print(setup_query)

     with sqlite3.connect(data_base) as con:
          con.executescript(setup_query)

     # Mock #
     with open('query/moco.sql') as mock:
          mock = ''.join(mock.readlines())
          print(mock)

     with sqlite3.connect(data_base) as con:
          con.executescript(mock)

con = sqlite3.connect(data_base)


# App information #
app_info_path = 'info.json'

with open(app_info_path) as app_info_conn:
     app_info = json.load(app_info_conn)
del app_info_conn

# Posts #
posts_path = 'data/post.json'

with open(posts_path) as posts_conn:
     app_info["posts"] = json.load(posts_conn)
del posts_conn

if len(sys.argv) == 3:
     app_info["posts"]["developer"] = sys.argv[2]
elif not app_info["posts"]["developer"]:
     app_info["posts"]["developer"] = 'el desarrollador'


# Flask setup #
app = Flask(
     __name__,
     static_url_path='',
     static_folder='a',
     template_folder='a'
)

app.config['SECRET_KEY'] = 'nigga'

if sys.argv[1] == 'dev':
     socketio = SocketIO(
          app,
          logger=True,
          async_mode=None,
          ping_interval=50,
          engineio_logger=True
     )
else:
     socketio = SocketIO(app, ping_interval=50)


# Default settings #
@app.errorhandler(404)
def go_default(error):
     return 'notmyproblem .!.', 404


@app.route('/servise-worker.js')
def sw():
     return app.send_static_file('servise-worker.js')


### Real sh1t ###
@app.route('/')
def home():
     with con:
          lista = []
          query = con.execute("SELECT nombre FROM v_list")
          lista = [row[0] for row in query]

          counters = []
          query = con.execute("SELECT * FROM v_counter")
          counters = [row[1] for row in query]
          c_total = counters[1]
          c_busy = c_total - counters[0]

          remotos = []
          query = con.execute("SELECT * FROM v_remotos")
          remotos = [row for row in query]
     return render_template(
          'index.html',
          lista=lista,
          busy=c_busy,
          total=c_total,
          remotos=remotos,
          app_info=app_info
     )


@socketio.event
def testeo(msg):
     print(type(msg), msg, type(msg[1]))
     response = [
          msg[0], msg[1] + 1 if msg[1] != 69 else 'amo a angeles <3'
     ]
     print(response)
     emit('testeo', response, broadcast=True)


@socketio.event
def change_item(msg):
     hora_solicitud = time.time()
     with con:
          persona = []
          query = con.execute(
               "SELECT * FROM v_list WHERE nombre = ?",
               (msg[1],)
          )

     persona = [row for row in query]

     if persona:
          query = con.execute(
               "UPDATE remotos SET list_view_id = ? WHERE [index] = ?",
               (persona[0][0], int(msg[0].split('-')[-1]))
          )
          answer = [msg[0].split('-')[-1]] + list(persona[0][1:])
     else:
          query = con.execute(
               "UPDATE remotos SET list_view_id = 'u00' WHERE [index] = ?",
               (int(msg[0].split('-')[-1]),)
          )
          answer = [msg[0].split('-')[-1], '', 'libre']

     with con:
          query = con.execute(
               "INSERT INTO historial (list_view_ID, time) VALUES (?, ?)",
               (persona[0][0], round(hora_solicitud))
          )

     with con:
          counters = []
          query = con.execute("SELECT * FROM v_counter")
          counters = [row[1] for row in query]
          c_total = counters[1]
          c_busy = c_total - counters[0]

     answer += [c_busy] + [c_total]

     with open('data/log.txt', 'a') as log:
          print(msg, '-', time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(hora_solicitud)), file=log)
          print('enviando:', answer, file=log)

     emit('change_item', answer, broadcast=True)
     return answer


if __name__ == '__main__':
     if sys.argv[1] == 'dev':
          print('running on', sys.argv[1])
          socketio.run(app, host='0.0.0.0', port=10011, debug=True)
     elif sys.argv[1] == 'Gevent0':
          print('running on', sys.argv[1])
          socketio.run(app, host='0.0.0.0', port=int(os.getenv('PORT', 10001)))

#ned
