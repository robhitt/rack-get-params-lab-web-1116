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

    elsif req.get? && req.path.match(/add/) && req.params["item"]
      parameter_item = req.params["item"]
      if @@items.include?(parameter_item)
        @@cart << parameter_item
        resp.write "added #{parameter_item}"
      else
        resp.write "We don't have that item"
      end
      # new_param = req.params
      #if @@.include?params
      # @@cart << item
      #else "We don't have that item"

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
