////Grab User Id /////
var currentUser;

var getUserId = function() {
  $.get('/get_id.json', function(res) {
     currentUser = res;
  })
}

///// All stories section //////
var clicked = false;

var addStory = function() {
  $.get('/stories.json', function(data) {
    var stories = Object.keys(data)
    var selected = data[stories[stories.length * Math.random() << 0]];
    $('#story-beginning').html(selected.beginning);
    $('#contributors-and-more').attr('href', `/stories/${selected.id}`);
    $('#full-story-button').attr('val', selected.id);
    var recentSentence = selected.sentences[selected.sentences.length-1]
     if (recentSentence && recentSentence.user_id == currentUser ) {
       $('#sentence-adder').html('<p style="color: #EF9A9A">You were the most recent to contribute. You can add a new sentence after someone else has.</p>')
     } else {
       $('#sentence-adder').html("<a href='/stories/"+ selected.id + "'>Add a sentence</a>");
     }
   })
   clicked = false;
   $('#full-story-button').text('see full story');
}

var displayFullStory = function() {
  var id = $('#full-story-button').attr('val');
  $.get(`/stories/${id}.json`, function(data) {
    if (clicked === false ) {
    $('#story-beginning').html(data.full_story);
    $('#full-story-button').text('back to beginning');
    return clicked = !clicked;
  }
    $('#story-beginning').html(data.beginning);
    $('#full-story-button').text('see full story');
    clicked = !clicked;
 })
}

////// Your Stories Section   ///////

 var idCount = 0;

 function getUserStory() {
   $.get('/users/' + currentUser + '.json', function(data) {
     $('#user-story-full').text(data[idCount].beginning);
     $('a#next-user-story').attr('href', '/stories/' + data[idCount].id);
     $('#delete-your-story').attr('href', '/stories/' + data[idCount].id);
     if (idCount < data.length - 1) {
       idCount+=1;
   } else {
       idCount = 0;
    }
   })
 }

 var open = false;

 var displayAllStories = function() {
   if (open === false) {
     return $.get('/users/' + currentUser + '/stories.json', function(data) {
               for (var i = 0; i < data.length; i++) {
                 var story = new Story(data[i]);
                 story.appendToDom();
               };
               return open = !open;
             });
   }
     $('#story-list').html('');
     open = !open;
   }

 var Story = function(story) {
   this.full_story = story.full_story;
   this.id = story.id;
   this.upvotes = story.upvotes.length;
 }

 Story.prototype.appendToDom = function() {
   $('#story-list').append(
     this.full_story + '<br>' + "<a href='/stories/" + this.id + "'>details</a>" + "&nbsp;&nbsp;|&nbsp;&nbsp<a href='/stories/" + this.id + "' data-method='delete' data-confirm='Are you sure you want to delete this?'>delete</a>&nbsp&nbsp<p style='font-size:20px;color:#0D47A1'><button id='thumbs' class='" + this.id + "'><i class='fa fa-thumbs-up' aria-hidden='true'></i></button>&nbsp;&nbsp|&nbsp;&nbsp;upvotes: <span class='" + this.id + "'>" + this.upvotes + '</span></p><br><br>'
   );
 }

///// Your Contributions Section //////

var sentenceCount = 0;

var displayContribution = function() {
  $.get('/users/' + currentUser + '/sentences.json', function(res) {
    $('#your-sentence-content').text(res[sentenceCount].content);
    $('#full-story-link').attr('href', `/stories/${res[sentenceCount].story_id}`);
    $('#delete-sentence').attr('href', `/stories/${res[sentenceCount].story_id}/sentences/${res[sentenceCount].id}`)
    if (sentenceCount < res.length - 1 ) {
      return sentenceCount += 1
    }
    sentenceCount = 0;
  })
}

/////////  UPVOTES /////////

var addUpvote = function(btn) {
    var storyId = $(btn).attr('class');
    var values = {user_id: currentUser};
    $(`button#thumbs.${storyId}`).prop('disabled', true);
    $(`button#thumbs.${storyId}`).addClass('thumb-clicked');
    var posting = $.post(`/stories/${storyId}/upvotes`, values);
    posting.done(function(data) {
      $.get(`/stories/${storyId}.json`, function(res) {
          var upvoteCount = res.upvotes.length;
          $(`span.${storyId}`).text(upvoteCount);
      })
    })
  }



/////// RUN !! //////
$(function() {
  getUserId();
  addStory();
  getUserStory();
  displayContribution();


  $('#next-button').unbind('click').on('click', function() {
    addStory();
  });

  $('#view-all-button').unbind('click').on('click', function() {
    displayAllStories();
  });

  $('#full-story-button').unbind('click').on('click', function() {
    displayFullStory();
  });

  $('#your-stories-button').unbind('click').on('click' , function(e) {
      e.stopImmediatePropagation();
      getUserStory();
    });

  $('#your-sentences-button').unbind('click').on('click', function(e) {
    e.stopImmediatePropagation();
    displayContribution();
    });

    $(document).on('click', '#thumbs', function(e)  {
      e.stopImmediatePropagation();
      e.preventDefault();
      addUpvote($(this));
    })

})
