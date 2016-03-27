class CommentsController < ApplicationController
  def index

  end

  def show

  end

  def create
    post = get_post_at_id
    if invalid_input?
      redirect_to "/posts/#{post.id}?error=true"
    else
      Comment.new($main_user, params[:body], post)
      redirect_to "/posts/#{post.id}"
    end
  end

  def invalid_input?
    params[:author].empty? || params[:body].empty?
  end

  def update

  end

  def destroy

  end

  private
  def get_all_posts
    AllPosts.posts
  end

  def get_post_at_id
    get_all_posts.find {|post| post.id == params["pid"].to_i}
  end

end
