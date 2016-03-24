$id_p = 1
class Post
  attr_accessor :id, :title, :author, :body, :published, :comments
  def initialize(title, author, body)
    @id = $id_p
    $id_p += 1
    @title = title
    @author = author
    @body = body
    @published = false
    @comments = []
  end

  def to_json
    {
      id: id,
      title: title,
      author: author,
      body: body,
      published: published,
    }.to_json
  end

end
