$(document).on('click', '#next-button', function() {
    $('#story-preview').empty();
    var storiesArray = <%=raw @stories_for_js%>
    var rand = storiesArray[Math.floor(Math.random() * storiesArray.length)];
    if (rand[2] == false) {
      $('#story-preview').append(
        '<p>'+rand[0]+'</p><br><a href="/stories/'+rand[1]+'/sentences/new">Add a Sentence</a><br></br>'+
        '<a href="/stories/'+rand[1]+'">see contributors & more</a>');
    } else {
      $('#story-preview').append(
        '<p>'+rand[0]+'</p><br>'+
        '<p style="color: #EF9A9A">You were the most recent to contribute. You can add a new sentence after someone else has.</p><br>' +
        '<a href="/stories/'+rand[1]+'">see contributors & more</a>');
    }
})
