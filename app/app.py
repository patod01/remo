import os, json, time
from flask import (
     Flask, request, render_template,
     url_for, redirect, jsonify,
)
from flask_socketio import SocketIO, emit
from sys import argv
import sqlite3

con = sqlite3.connect('remo.db')

app = Flask(
     __name__,
     static_url_path='',
     static_folder='a',
     template_folder='a'
)

app.config['SECRET_KEY'] = 'nigga'

if argv[1] == 'dev':
     socketio = SocketIO(
          app,
          logger=True,
          async_mode=None,
          ping_interval=50,
          engineio_logger=True
     )
else:
     socketio = SocketIO(app, ping_interval=50)


@app.errorhandler(404)
def go_default(error):
     return 'notmyproblem .!.', 404


@app.route('/servise-worker.js')
def sw():
     return app.send_static_file('servise-worker.js')


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
     return render_template('index.html', lista=lista, busy=c_busy, total=c_total, remotos=remotos)


@app.route('/api/', methods=['POST', 'GET'])#, 'PUT', 'DELETE'])
def api():
     if request.method == 'POST':
          if request.is_json:
               if request.json['action'] == 'try':
                    os.system('start')
                    hora = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime())
                    respuesta = {'lol': 'sop', 'hora': hora}
                    return jsonify(respuesta)
               else:
                    return jsonify('Not implemented.')
     elif request.method == 'GET':
          ...
     elif request.method == 'PUT':
          ...
     elif request.method == 'DELETE':
          ...
     return jsonify('op')


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
     print(msg, type(msg))
     with con:
          persona = []
          query = con.execute(
               "SELECT * FROM v_list where nombre = ?",
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
               (persona[0][0], round(time.time()))
          )

     with con:
          counters = []
          query = con.execute("SELECT * FROM v_counter")
          counters = [row[1] for row in query]
          c_total = counters[1]
          c_busy = c_total - counters[0]

     answer += [c_busy] + [c_total]

     print('enviando:', answer)

     emit('change_item', answer, broadcast=True)
     return answer


if __name__ == '__main__':
     if argv[1] == 'dev':
          print('running on', argv[1])
          socketio.run(
               app,
               host='0.0.0.0',
               port=10123,
               debug=True
          )
     else:
          print('running on', argv[1])
          socketio.run(app, host='0.0.0.0', port=10123)

#ned
