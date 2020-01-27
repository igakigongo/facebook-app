class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[destroy update]

  # POST /friendships
  def create
    @friendship = Friendship.new(friendship_params)
    flash[:notice] = @friendship.save ? 'Friendship was successfully created' : 'Failed to send friend request'
    redirect_back fallback_location: root_url
  end

  # PATCH/PUT /friendships/1
  def update
    begin
      @friendship.confirm
    rescue StandardError
      flash[:notice] = 'Friendship confirmation failed'
    end
    redirect_back fallback_location: root_url
  end

  # DELETE /friendships/1
  def destroy
    begin
      @friendship.terminate
    rescue StandardError
      flash[:notice] = 'Friendship termination failed'
    end
    redirect_back fallback_location: root_url
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.fetch(:friendship, {}).permit(:friend_id, :user_id)
  end
end
