class HomeController < ApplicationController
  def index
    @all_posts = get_all_posts
    @total = (@all_posts.size / 10) + 1
    if params["limit"].nil? || params["limit"] == 0
      @rendered_posts = @all_posts[0,10]
    else
      @rendered_posts = @all_posts[params["limit"],10]
    end

    render_template 'blog/index.html.erb'
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
