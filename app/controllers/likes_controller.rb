class LikesController < ApplicationController
  before_action :find_resource_type

  # POST /likes
  # POST /likes.json
  def create
    like = Like.like(current_user, @resource)
    p 'the like was not saved' unless like
    redirect_to root_url
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    destroyed = Like.dislike(current_user, @resource)
    p 'the like was not destroyed' unless destroyed
    redirect_to root_url
  end

  private

  def find_resource_type
    likeable = like_params
    @resource = if likeable[:likeable_type].eql?('Comment')
                  Comment.find_by(id: likeable[:likeable_id])
                else
                  Post.find_by(id: likeable[:likeable_id])
                end
    @resource
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_like
    @like = Like.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def like_params
    params.fetch(:like, {}).permit(:likeable_id, :likeable_type)
  end
end
