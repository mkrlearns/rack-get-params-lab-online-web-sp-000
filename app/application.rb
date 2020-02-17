class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each { |item| resp.write "#{item}\n" }
    elsif req.path.match(/search/)
      resp.write handle_search(req.params["q"])
    elsif req.path.match(/cart/)
      @@cart.length == 0 ?
        resp.write "Your cart is empty" :
        @@cart.each { |item| resp.write "#{item}\n" }
    elsif req.path.match(/add/)
      new_item = req.params["item"]
      if @@items.include?(new_item)
        @@cart << new_item
        resp.write "added #{new_item}"
      else
        resp.write "We don't have that item"
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
