class PostsController < ApplicationController
  def index
    @home = true
    @url = "/posts"
    all_posts = get_all_posts
    render_by_pagination(all_posts)
  end

  def show
    @post = get_post_at_id
    @error = params["error"]
    @paragraphs = get_paragraphs unless @post.nil?

    if @post
      render_template 'blog/show.html.erb'
    else
      render "No Post!", as: 'text/html'
    end

  end

  def new
    @error = params["error"]
    render_template "blog/new.html.erb"
  end

  def create
    if invalid_input?
      redirect_to "/posts/new?error=true"
    else
      new_post = Post.new(params[:title], $main_user, params[:body])
      get_all_posts << new_post
      redirect_to "/posts/#{new_post.id}"
    end
  end

  def invalid_input?
    params[:title].empty? || params[:body].empty?
  end

  def edit
    @error = params["error"]
    @post = get_post_at_id
    render_template "blog/new.html.erb"
  end

  def update
    unless params[:commit] == "No" || params[:commit] == "Yes"
      if invalid_input?
        redirect_to "/posts/#{params[:id]}/edit?error=true"
      else
        post = get_post_at_id
        post.title, post.body = params[:title], params[:body]
        redirect_to "/posts/#{post.id}"
      end
    else
      ""
    end

  end

  def delete
    @delete = params["delete"]
    @post = get_post_at_id
    @paragraphs = get_paragraphs unless @post.nil?
    render_template "blog/show.html.erb"
  end

  def destroy
    @post = get_post_at_id
    if params[:commit] == "Yes"
      delete_post_at_id
      redirect_to "/posts/unpublished"
    else
      redirect_to "/posts/#{@post.id}"
    end
  end

  def mark_published
    post = get_post_at_id
    post.published = true
    redirect_to(request[:referer])
  end

  def published
    all_posts = get_published_posts
    @url = "/posts/published"
    render_by_pagination(all_posts)
  end

  def unpublished
    all_posts = get_unpublished_posts
    @url = "/posts/unpublished"
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

  def get_paragraphs
    @post.body.split("\n")
  end

  def delete_post_at_id
    get_all_posts.delete(get_post_at_id)
  end

  def render_by_pagination(all_posts)
    @total = (all_posts.size / 10) + 1
    @start = 0
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
