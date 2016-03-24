$id_c = 1
class Comment
  attr_accessor :id, :time, :author, :body# :comments
  def initialize(author, body, post)
    @id = $id_c
    $id_c += 1
    @time = Time.now
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
