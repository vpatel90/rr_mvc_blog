class PostsController < ApplicationController
  def index
    all_posts = get_all_posts
    render_by_pagination(all_posts)
  end

  def show
    @post = get_post_at_id
    if @post
      render_template 'blog/show.html.erb'
    else
      render "No Post!", as: 'text/html'
    end
  end

  def new
    @error = false
    render_template "blog/new.html.erb"
  end

  def create
    check_input ## Parser throws an error before getting here
    new_post = Post.new(params[:title], params[:author], params[:body])
    get_all_posts << new_post
    redirect_to "/posts/#{new_post.id}"
  end

  def check_input
    if params[:title].empty? || params[:author].empty? || params[:body].empty?
      @error = true
      render_template "blog/new.html.erb"
    else
    end
  end

  def update

  end

  def destroy

  end

  def mark_published
    post = get_post_at_id
    post.published = true
    redirect_to(request[:referer])
  end

  def published
    all_posts = get_published_posts
    render_by_pagination(all_posts)
  end

  def unpublished
    all_posts = get_unpublished_posts
    render_by_pagination(all_posts)
  end

  private
  def get_all_posts
    AllPosts.posts
  end

  def get_post_at_id
    get_all_posts.find {|post| post.id == params[:id].to_i}
  end

  def get_published_posts
    get_all_posts.select {|post| post.published == true}
  end

  def get_unpublished_posts
    get_all_posts.select {|post| post.published == false}
  end

  def render_by_pagination(all_posts)
    @total = (all_posts.size / 10) + 1
    if params["limit"].nil? || params["limit"].to_i == 0
      @plimit, @nlimit = 0, 10
      @rendered_posts = all_posts[0,10]
    else
      @plimit, @nlimit = params["limit"].to_i - 10, params["limit"].to_i + 10
      @nlimit = (@total - 1) * 10 if @nlimit > (@total - 1) * 10

      @rendered_posts = all_posts[params["limit"].to_i,10]
    end
    render_template 'blog/index.html.erb'
  end

end
