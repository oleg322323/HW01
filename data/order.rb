class Order
	#attr_reader :complexity, :clear, :deadline
	attr_reader :customer, :manager

  def initialize(options)
  	@customer 	= options[:customer] #link
  	@manager		= options[:manager] #link

    @сomplexity	= options[:complexity]
    @clear			= options[:clear]
    @deadline		= options[:deadline]
  end
end

#Order.new({ сustomer: сustomer, manager: manager, complexity: 100, clear: 30000, deadline: 75 })

#сustomer = Customer.new
#order = Order.new({ сustomer: сustomer })
#order.сustomer == сustomer#=>true