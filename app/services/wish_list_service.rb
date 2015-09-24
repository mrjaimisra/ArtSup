class WishListService
  attr_reader :connection

  def initialize
    @connection = Hurley::Client.new("http://www.justinscarpetti.com/projects/amazon-wish-lister/api")
  end

  def wish_list(id)
    parse(connection.get("?id=#{id.to_i}"))
    # sending get request to http://localhost:3000/v1/wish_list
  end

  def create_wish_list(params)
    parse(connection.post("wish_list", params))
  end

  def update_wish_list(id, params)
    connection.put("wish_list/#{id}", params)
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end
end
