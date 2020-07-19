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

let channel = socket.channel('twig:lobby', {});

channel.on('shout', function (payload) {
    let li = document.createElement("li");
    let squirrel = payload.squirrel || 'guest';
    li.innerHTML = '<b>' + squirrel + '</b>: ' + payload.leaf;
    ul.appendChild(li);
});

channel.join();

let ul = document.getElementById('leaf-log');
let squirrel = document.getElementById('squirrel');
let leaf = document.getElementById('leaf');

leaf.addEventListener('keypress', function (event) {
    if (event.keyCode == 13 && leaf.value.length > 0) {
        channel.push('shout', {
            squirrel_id: squirrel.value,
            content: leaf.value
        });
        leaf.value = '';
    }
});
