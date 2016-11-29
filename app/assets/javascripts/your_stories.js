var allStories = [];
var storyIds = [];
var storyCount = 0;

function getStories() {
  $.get("/stories.json", function(data) {
    for (var i=0; i<data.length; i++) {
      allStories.push([data[i].full_story]);
      storyIds.push([data[i].id])
      }
    })
    allStories = allStories.reverse().filter(function (e, i, arr) {
      return allStories.indexOf(e, i+1) === -1;}).reverse();

  }

function updateCount() {
  storyCount += 1;
   console.log(storyCount);
}

function nextStory() {
  $('#user-story-full').text(allStories[storyCount]);
  $('#next-user-story').attr('href', '/stories/' + storyIds[storyCount]);
  $('#delete-your-story').attr('href', '/stories/' + storyIds[storyCount]);
  updateCount();
} //reset storyCount to 0 once it hits the length of the array

function thisWasClicked() {
$(document).on('click', '#your-stories-button', function(e) {
    e.stopImmediatePropagation();
    nextStory();
    });
}


getStories();
thisWasClicked();
