$(document).ready(function(){
  $(".like_button").on("click",function(event){
    event.preventDefault();
    $.post(this.href);
  });
  var connection = new WebSocketRails(window.location.host + '/websocket');
  channel = connection.subscribe('likes');
  channel.bind('new', function(resp) {
    $('.post[data-id=' + resp.id + '] .like_button').html('♥ ' + resp.new_like_count);
  });
})