import os, json, time
from flask import (
     Flask, request, render_template,
     url_for, redirect, jsonify,
)
from waitress import serve

app = Flask(
     __name__,
     static_url_path='',
     static_folder='a',
     template_folder='a'
)


@app.errorhandler(404)
def go_default(error):
     return 'notmyproblem .!.', 404


@app.route('/')
def home(): return render_template('index.html')


@app.route('/servise-worker.js')
def sw():
     return app.send_static_file('servise-worker.js')


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


if __name__ == '__main__':
     # host = '192.168.100.2'
     host = 'localhost'
     # host = '127.0.0.1'
     # app.run(debug=True, port=7896, host=host)
     serve(app, host='*', port=7896)

#ned
