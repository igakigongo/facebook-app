class ProfileController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.where('user_id = ?', current_user.id).order('created_at desc')
    @new_post = Post.new
  end
end
