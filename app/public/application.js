window.onload = function() {
  Mousetrap.bind('?', function() {
    var helpMessage = "Use the following keys to navigate\n\
    a, h, or ← mean go back\n\
    d, l, or → mean go forward\n\
    w, j, or ↑ mean rate up\n\
    s, k, or ↓ mean rate up"
    alert(helpMessage);
  });

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