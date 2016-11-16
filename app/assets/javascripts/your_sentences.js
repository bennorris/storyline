var allSentences = [];
var count = 0;

function getSentences() {
  $.get("/sentences.json", function(data) {
    for (var i=0; i<data.length; i++) {
      allSentences.push([data[i].content]);
      }
    })
  }

function nextSentence() {
  $('#your-sentence-content').text(allSentences[count]);
  if (count < (allSentences.length - 1) ){
    count += 1;
  } else {
    count = 0;
  }
}

function bind() {
$(document).on('click', '#your-sentences-button', function(e) {
    e.stopImmediatePropagation();
    nextSentence();
    });
}


getSentences();
bind();
