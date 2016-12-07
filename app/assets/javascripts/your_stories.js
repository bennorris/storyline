var allStories = [];
var storyIds = [];
var storyCount = 0;
var userIds;

// function getStories() {
//   $.get("/stories.json", function(data) {
//     for (var i=0; i<data.length; i++) {
//       allStories.push([data[i].full_story]);
//       storyIds.push([data[i].id])
//       }
//     })
//     allStories = allStories.reverse().filter(function (e, i, arr) {
//       return allStories.indexOf(e, i+1) === -1;}).reverse();
//
//   }
//
// function updateCount() {
//   storyCount += 1;
// }
//
// function nextStory() {
//   if (storyCount < allStories.length) {
//     $('#user-story-full').text(allStories[storyCount]);
//     $('#next-user-story').attr('href', '/stories/' + storyIds[storyCount]);
//     $('#delete-your-story').attr('href', '/stories/' + storyIds[storyCount]);
//     updateCount();
//   } else {
//     storyCount = 0;
//     $('#user-story-full').text(allStories[storyCount]);
//     $('#next-user-story').attr('href', '/stories/' + storyIds[storyCount]);
//     $('#delete-your-story').attr('href', '/stories/' + storyIds[storyCount]);
//     updateCount();
//   }
// }

function thisWasClicked() {
$(document).on('click', '#your-stories-button', function(e) {
    e.stopImmediatePropagation();
    getNextStory();
    });
}


  var idCount = 1;

function getNextStory() {

  $.get('/stories/' + userIds[idCount] + '.json', function(data) {
    console.log(userIds.length);
    console.log(idCount);
    $('#user-story-full').text(data.beginning);
    $('#next-user-story').attr('href', '/stories' + userIds[idCount]);
    $('#delete-your-story').attr('href', '/stories/' + userIds[idCount]);
    if (idCount < userIds.length - 1) {
      idCount+=1;
  } else {
      idCount = 0;
  }

  })
}



thisWasClicked();
