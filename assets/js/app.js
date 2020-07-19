// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
    import socket from "./socket"
//
import "phoenix_html"

let channel = socket.channel('twig:nest', {});

channel.on('shout', function (payload) {
    console.log(payload)
    let li = document.createElement("li");
    let squirrel_id = payload.squirrel_id || 'guest';
    li.innerHTML = '<b>' + squirrel_id + '</b>: ' + payload.content;
    ul.appendChild(li);
});

channel.join();

let ul = document.getElementById('leaf-log');
let squirrel_id = document.getElementById('squirrel_id');
let leaf = document.getElementById('leaf');

leaf.addEventListener('keypress', function (event) {
    if (event.keyCode == 13 && leaf.value.length > 0) {
        channel.push('shout', {
            squirrel_id: squirrel_id.value,
            content: leaf.value
        });
        leaf.value = '';
    }
});
