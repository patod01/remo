import os, json, time
from flask import (
     Flask, request, render_template,
     url_for, redirect, jsonify,
)
from flask_socketio import SocketIO, send
from sys import argv


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
          ping_interval=45,
          engineio_logger=True
     )
else:
     socketio = SocketIO(app)


@app.errorhandler(404)
def go_default(error):
     return 'notmyproblem .!.', 404


@app.route('/servise-worker.js')
def sw():
     return app.send_static_file('servise-worker.js')


@app.route('/')
def home(): return render_template('index.html')


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


pepa = 0

@socketio.event
def jamon(mensaje):
     print(f'\n\n{mensaje} AAAAAAAAAAA\n\n')
     global pepa
     pepa += 1
     print(pepa)
     return ('amo a angeles <3' if pepa == 33 else pepa)


if __name__ == '__main__':
     if argv[1] == 'dev':
          print('running on', argv[1])
          socketio.run(
               app,
               host='0.0.0.0',
               port=7777,
               debug=True
          )
     else:
          print('running on', argv[1])
          socketio.run(app, host='0.0.0.0', port=7777)

#ned
