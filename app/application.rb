class Application
  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each { |i| resp.write "#{i}\n" }
    elsif req.path.match(/search/)
      resp.write handle_search(req.params["q"])
    elsif req.path.match(/cart/)
      if @@cart.length == 0; resp.write "Your cart is empty"
      else; @@cart.each { |i| resp.write "#{i}\n" } end
    elsif req.path.match(/add/)
      item = req.params["item"]
      if @@items.include?(item); @@cart << item; resp.write "added #{item}"
      else; resp.write "We don't have that item" end
    else; resp.write "Path Not Found" end

    resp.finish
  end

  def handle_search(s)
    @@items.include?(s) ? "#{s} is one of our items" : "Couldn't find #{s}"
  end
end
