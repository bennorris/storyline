var allStories = [];
var count = 0;

function getStories() {
  $.get("/stories.json", function(data) {
    for (var i=0; i<data.length; i++) {
      allStories.push([data[i].full_story]);
      }
    })
  }

function nextStory() {
  $('#user-story-full').text(allStories[count]);
  if (count < (allStories.length - 1) ){
    count += 1;
  } else {
    count = 0;
  }
}

function bind() {
$(document).on('click', '#your-stories-button', function() {
    nextStory();
    });
}


getStories();
bind();
