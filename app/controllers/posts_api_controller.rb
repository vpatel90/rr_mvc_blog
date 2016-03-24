class PostsAPIController < ApplicationController
  def index
    render get_all_posts.to_json
  end

  def show

  end

  def create

  end

  def update

  end

  def destroy

  end
  private
  def get_all_posts
    AllPosts.posts
  end

end
