$id_c = 1
class Comment
  attr_accessor :id, :time, :author_fn, :author_ln, :user, :body
  def initialize(user, body, post)
    @id = $id_c
    $id_c += 1
    @time = GetTime.now
    @user = user
    @author_fn = user.first_name
    @author_ln = user.last_name
    @body = body
    @post_id = post.id
    post.comments.unshift(self)
  end

  def to_json(_ = nil)
    {
      id: id,
      author_fn: author_fn,
      author_ln: author_ln,
      body: body,
    }.to_json
  end

end
