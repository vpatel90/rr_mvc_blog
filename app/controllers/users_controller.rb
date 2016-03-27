class UsersController < ApplicationController
  def index
    render get_all_users.to_json
  end

  def new
    @error = params["error"]
    render_template "blog/create_account.html.erb"

  end

  def update

  end

  def create
    unless find_user?
      user = User.new(params[:author_fn], params[:author_ln])
      get_all_users << user
      $main_user = user
      redirect_to "/users/#{user.id}"
    else
      redirect_to "/users/new?error=true"
    end
  end

  def show
    @user = get_user_by_id
    if @user
      render_template "blog/profile.html.erb"
    else
      ""
    end
  end

  def login
    @error = params["error"]
    @page = params["page"]
    render_template "blog/login.html.erb"
  end

  def set_user

    @user = find_user?
    if @user.nil?
      redirect_to "/users/login?error=true"
    else
      $main_user = @user
      redirect_to "/#{params[:page]}"
    end
  end

  def logout
    $main_user = nil
    redirect_to "/"
  end

  private
  def get_all_users
    AllUsers.users
  end

  def get_user_by_id
    get_all_users.find{ |u| u.id == params[:id].to_i}
  end

  def find_user?
    similar = AllUsers.users.select {|u| u.first_name == params[:author_fn]}
    other = similar.select {|u| u.last_name == params[:author_ln]}
    return nil if other.empty?
    return other[0]
  end
end
