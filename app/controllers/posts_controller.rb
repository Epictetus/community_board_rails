class PostsController < ApplicationController
  before_filter :authenticate_user!, except: :index
  before_filter :load_community

  def index
    @posts = @community.posts.new_to_old
  end

  def create
    @post = @community.posts.new(post_params)
    @post.user = current_user
    @post.save
  end

  private

  def load_community
    @community = Community.find(params[:community_id])
  end

  def post_params
    params.require(:post).permit(:text)
  end
end
