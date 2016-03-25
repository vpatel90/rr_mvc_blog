class HomeController < ApplicationController
  def index
    @all_posts = get_all_posts
    @total = (@all_posts.size / 10) + 1
    if params["limit"].nil? || params["limit"].to_i == 0
      @plimit, @nlimit = 0, 10
      @rendered_posts = @all_posts[0,10]
    else
      @plimit, @nlimit = params["limit"].to_i - 10, params["limit"].to_i + 10
      @nlimit = (@total - 1) * 10 if @nlimit > (@total - 1) * 10

      @rendered_posts = @all_posts[params["limit"].to_i,10]
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
