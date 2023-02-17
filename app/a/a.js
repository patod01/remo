const d = document;

let div = d.querySelector('#div');
let nani = d.querySelector('#not');
const boton = d.querySelector('#boton1');

nani.onclick = () => {
     div = d.querySelector('#div');
     div.innerHTML += ' cierto?';
     nani = d.querySelector('#not');
     nani.onclick = () => {
          div = d.querySelector('#div');
          div.innerHTML += ' cierto?';
          nani = d.querySelector('#not');
     }
}

boton.onclick = () => prompt();

const local_IP = 'teikat.site';
const PORT = '7896';

function api_shortcut(method, action) {
     const options = {
          method: `${method}`,
          headers: {'Content-Type': 'application/json'},
          body: `{"action":"${action}"}`
     };
     // fetch(`https://${local_IP}:${PORT}/api/`, options)
     fetch(`https://${local_IP}/api/`, options)
          .then(response => response.json())
          .then(response => {
               console.log(response);
               d.querySelector('#log').innerHTML = `processed by server at ${response.hora}.`;
          })
          .catch(err => console.error(err));
}

// cables go here

const b_buy = document.querySelector('#boton');
b_buy.onclick = () => api_shortcut('POST', 'try');
