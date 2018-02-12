class Collections
  attr_accessor :id
  attr_accessor :name

  def initialize(hash)
    @name=hash['name']
    @id=hash['id']
  end
end