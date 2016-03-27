class CommentsAPIController < ApplicationController
  def index
    render get_all_comments.to_json
  end

  def show
    render get_comment_at_id.to_json
  end

  def create

  end

  def update

  end

  def destroy

  end

  private
  def get_all_comments
    all_posts = AllPosts.posts
    all_comments = []

    all_posts.each do |post|
      all_comments << post.comments
    end
    return all_comments.flatten
  end

  def get_comment_at_id
    get_all_comments.find{|comment| comment.id == params[:id].to_i}
  end

end
