import consumer from "./consumer"

consumer.subscriptions.create("PostCommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const html = `<p>${data.user.user_name}: ${data.post_comment.text}</p>`;
    const comments = document.getElementById('post_comments');
    const newComment = document.getElementById('post_comment_text');
    comments.insertAdjacentHTML('afterbegin', html);
    newComment.value = '';
  }
});
