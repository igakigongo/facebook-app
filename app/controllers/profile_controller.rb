class ProfileController < ApplicationController
  before_action :authenticate_user!

  # TODO: Should take a user id: not the current_user_id
  def index
    id = params[:id]
    @posts = Post.includes(comments: [:commentor])
      .where('user_id = ?', id)
      .order('created_at desc')
    @profile_owner = User.find_by(id: id)
  end
end
