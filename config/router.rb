class Router
  def initialize(request)
    @request = request
  end

  def route
    # Routes are parsed from top down, so make sure they follow this style
    # /resource/:id/action
    # /resouce/:id
    # /resource
    # If you don't use that order, it will be like the if statements in fizzbuzz
    # syntax:
    # get(<route_string>, <controller_name_constant>, <action_name_symbol)
    # put('/tweets/:id/edit', TweetsController, :edit)
    #This route would be for putting an update for the tweet where :id is the number in the URL
    #
    # Put your routes in this array using the get, post, put, delete methods below. (remember order matters)
    [

      get('/', HomeController, :index),
      api_resource('api/posts', PostsAPIController),
      get('/posts/published', PostsController, :published),
      get('/posts/unpublished', PostsController, :unpublished),
      resource('posts', PostsController),
      get('/posts/:id/complete', PostsController, :mark_published),
      post('/tweets', TweetsController, :create),
      get('/tweets/new', TweetsController, :new),
      get('/tweets/:id', TweetsController, :show),
      get('/tweets', TweetsController, :index),
      get('/not_here', TweetsController, :not_here), # This is to demo the new redirect_to method

      get('/assets/:type/:name', AssetsController, :handle),
      root(TweetsController, :index)
    ].flatten.find(&:itself)
  end

  private # No need to edit these, but feel free to read them to see how they work

  def root(controller, action)
    [
      get('/', controller, action)
    ]
  end

  def api_resource(name, controller)
    [
      post("/#{name}",       controller, :create),
      delete("/#{name}/:id", controller, :destroy),
      put("/#{name}/:id",    controller, :update),
      get("/#{name}/:id",    controller, :show),
      get("/#{name}",        controller, :index),
    ]
  end

  def resource(name, controller)
    [
      get("/#{name}/new",         controller, :new),

      post("/#{name}",            controller, :create),
      post("/#{name}/:id/delete", controller, :destroy), #will be DELETE in rails
      post("/#{name}/:id",        controller, :update), #will be PUT in Rails

      get("/#{name}/:id/edit",    controller, :edit),
      get("/#{name}/:id",         controller, :show),
      get("/#{name}",             controller, :index),
    ]
  end

  def get(url_str, resource, action)
    if get? && route_match?(url_str)
      fill_params(url_str)
      send_to_controller(resource, action)
    end
  end

  def post(url_str, resource, action)
    if post? && route_match?(url_str)
      fill_params(url_str)
      send_to_controller(resource, action)
    end
  end

  def put(url_str, resource, action)
    if put? && route_match?(url_str)
      fill_params(url_str)
      send_to_controller(resource, action)
    end
  end

  def delete(url_str, resource, action)
    if delete? && route_match?(url_str)
      fill_params(url_str)
      send_to_controller(resource, action)
    end
  end

  def get?
    @request[:method] == "GET"
  end

  def put?
    @request[:method] == "PUT"
  end

  def post?
    @request[:method] == "POST"
  end

  def delete?
    @request[:method] == "DELETE"
  end

  def fill_params(url)
    params = Hash[url[1..-1]
              .split('/')
              .zip(@request[:paths])
              .select { |key, value| key[0] == ":" }
              .map { |key, value| [key[1..-1].to_sym, value] }]
    @request[:params].merge!(params)
  end

  def send_to_controller(resource, action)
    @request[:params].merge!({
      controller_name: resource.to_s,
      action_name: action
    })
    resource.new(@request).send(action)
  end

  def route_match?(url)
    @request[:route] =~ Regexp.new("^#{con(url)}$")
  end

  def con(str)
    return str unless str.include?(':')
    updated_str = str.gsub(/(?:(?::.+[\/]([^:]+))|(:.+(.+)$))/) do
      first_match = Regexp.last_match[1]
      if first_match.nil?
        "(.+)"
      else
        "(.+)/#{first_match}"
      end
    end
    con(updated_str)
  end
end
