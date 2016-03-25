class PostsController < ApplicationController
  def index
    @all_posts = get_all_posts
    @total = (@all_posts.size / 10) + 1
    if params[:limit].nil? || params[:limit] == 0
      @rendered_posts = @all_posts[0,10]
    else
      @rendered_posts = @all_posts[params[:limit],10]
    end
    binding.pry
    render_template 'blog/index.html.erb'

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
    render_template "blog/new.html.erb"
  end

  def create
    new_post = Post.new(params[:title], params[:author], params[:body])
    get_all_posts << new_post
    redirect_to "/posts/#{new_post.id}"
  end

  def update

  end

  def destroy

  end

  def published

  end

  def unpublished

  end

  private
  def get_all_posts
    AllPosts.posts
  end

  def get_post_at_id
    get_all_posts.find {|post| post.id == params[:id].to_i}
  end

  def get_published_posts

  end

  def get_unpublished_posts

  end

end
