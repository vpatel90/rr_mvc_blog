$id_c = 1
class Comment
  attr_accessor :id, :author, :body# :comments
  def initialize(title, author, body, post)
    @id = $id_c
    $id_c += 1
    @author = author
    @body = body
    @post_id = post.id
    post.comments << self
  end

  def to_json
    {
      id: id,
      author: author,
      body: body,
    }.to_json
  end

end
