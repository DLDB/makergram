$(document).ready(function(){
  $(".like_button").on("click",function(event){
    event.preventDefault();
    $(this).closest('.post').removeClass('unliked').addClass('liked');
    $.post(this.href);
  });

  $(".unlike_button").on("click",function(event){
    event.preventDefault();
    $(this).closest('.post').removeClass('liked').addClass('unliked');
    $.ajax({url: this.href, type: 'delete'});
  })

  var connection = new WebSocketRails(window.location.host + '/websocket');
  channel = connection.subscribe('likes');
  channel.bind('new', function(resp) {
    $('.post[data-id=' + resp.id + '] .like_button').html('♥ ' + resp.new_like_count);
    $('.post[data-id=' + resp.id + '] .unlike_button').html('♥ ' + resp.new_like_count);
  });
})