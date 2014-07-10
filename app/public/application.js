window.onload = function() {
  Mousetrap.bind('?',      function() { location.href = '#help'; });
  Mousetrap.bind('esc',    function() { location.href = '#' });
  Mousetrap.bind('space',  function() { location.href = '#twiend' });
  Mousetrap.bind('enter',  function() { banana() });

  Mousetrap.bind('a',      function() { console.log('left'); });
  Mousetrap.bind('h',      function() { console.log('left'); });
  Mousetrap.bind('left',   function(e) { e.preventDefault(); console.log('left'); });
  Mousetrap.bind('d',      function() { console.log('right'); });
  Mousetrap.bind('l',      function() { console.log('right'); });
  Mousetrap.bind('right',  function(e) { e.preventDefault(); console.log('right'); });
  Mousetrap.bind('w',      function() { console.log('up'); });
  Mousetrap.bind('j',      function() { console.log('up'); });
  Mousetrap.bind('up',     function(e) { e.preventDefault(); console.log('up'); });
  Mousetrap.bind('s',      function() { console.log('down'); });
  Mousetrap.bind('k',      function() { console.log('down'); });
  Mousetrap.bind('down',   function(e) { e.preventDefault(); console.log('down'); });
};

function banana() {
  var response;
  var request = new XMLHttpRequest();
  var friendId = Math.floor(Math.random() * 289) + 1
  request.open('GET', '/twiends/' + friendId + ".html", true);

  request.onload = function() {
    if (request.status >= 200 && request.status < 400){
      document.getElementById("friend").innerHTML = this.responseText;
    } else {
      console.log("request error");
    }
  };

  request.onerror = function() {
    console.log("connection error");
  };
  request.send();
}