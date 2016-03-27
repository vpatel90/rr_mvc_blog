$id_p = 1
class Post
  attr_accessor :id, :time, :title, :user, :author_fn, :author_ln, :body, :published, :comments
  def initialize(title, user, body)
    @id = $id_p
    $id_p += 1
    @time = Time.now
    @title = title
    @user = user
    @author_fn = user.first_name
    @author_ln = user.last_name
    @body = body
    @published = false
    @comments = []
  end

  def to_json(_ = nil)
    {
      id: id,
      title: title,
      author_fn: author_fn,
      author_ln: author_ln,
      body: body,
      published: published,
    }.to_json
  end

end
