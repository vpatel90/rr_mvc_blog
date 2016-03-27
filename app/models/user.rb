$id_u = 0
class User
  attr_accessor :id, :first_name, :last_name, :posts, :comments
  def initialize(first_name, last_name)
    @id = $id_u + 1
    $id_u += 1
    @first_name = first_name
    @last_name = last_name
    @posts = []
    @comments = []
  end

  def to_json( _ = nil)
    {
      id: id,
      first_name: first_name,
      last_name: last_name,
      posts: posts,
      comments: comments,
    }.to_json
  end
end
