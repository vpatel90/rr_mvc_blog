class PostsAPIController < ApplicationController
  def index
    render get_all_posts.to_json
  end

  def show
    render get_post_at_id.to_json
  end

  def create
    user = User.new(params["author_fn"], params["author_ln"])
    new_post = Post.new(params["title"], user, params["body"])
    get_all_posts << new_post
    render({message:"Successfully Created", post:new_post}.to_json)
  end

  def update
    post = get_post_at_id
    post.title, post.body = params["title"], params["body"]
    render({message:"Successfully Updated", post:post}.to_json)
  end

  def destroy

  end
  private
  def get_all_posts
    AllPosts.posts
  end

  def get_post_at_id
    get_all_posts.find {|post| post.id == params[:id].to_i}
  end
end
