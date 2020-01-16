class PostsController < ApplicationController

  def create
    owner = current_user
    post_params = params.require(:post).permit(:text)
    new_post = owner.posts.build(post_params)
    if new_post.save
      flash[:notice] = 'Post successfully created'
    else
      flash[:alert] = 'Post was not created'
    end
    redirect_to root_url
  end

  def index 
    # TODO: Should show posts for (current users + friends)
    @posts = Post.includes(comments: [:commentor])
      .where('user_id = ?', current_user.id)
      .order('created_at desc')
  end
end
