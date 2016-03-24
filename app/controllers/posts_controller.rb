class PostsController < ApplicationController
  def index
    @all_posts = get_all_posts
    render_template 'index.html.erb'
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
