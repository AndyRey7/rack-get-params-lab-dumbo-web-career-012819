class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.empty?
          resp.write "Your cart is empty"
      else
          @@cart.each do |item|
              resp.write "#{item}\n"
          end
      end
  elsif req.path.match(/add/)
      fruits = req.params["item"]
      resp.write adding_items_to_cart(fruits)
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

  def adding_items_to_cart(fruits)
      if @@items.include? fruits
          @@cart << fruits
          return "added #{fruits}"
      else
          return "We don't have that item"
      end
  end

end
