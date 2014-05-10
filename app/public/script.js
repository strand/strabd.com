var updateCounter = function() {
  var messageLength = document.getElementById("message").textLength;
  var counter = document.getElementById("counter");
  counter.textContent = messageLength;
  if(messageLength > 100) {
    counter.className = "red";
  }
};

window.onkeyup = updateCounter;