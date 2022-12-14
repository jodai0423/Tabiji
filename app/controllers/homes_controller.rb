class HomesController < ApplicationController


  def top
  end

  def about
  end

  def ranking
    @post_like_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
    @post_comment_ranks = Post.find(PostComment.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
  end

end
