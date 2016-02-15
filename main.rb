require_relative "data/customer"
require_relative "data/order"
require_relative "data/manager"
require_relative "data/programmer"

class ItCompanySimulator
  def self.start
  	manager			= Manager.new({ communicability: 100, ability_to_organize: 75 })

    customer 		= Customer.new({ manager: manager, requirements: 100, remuneration: 30000, competence: 75, adequacy: 63 })
    customer.manager == manager#=>true
    
    order 			= Order.new({ сustomer: сustomer, manager: manager, complexity: 100, clear: 30000, deadline: 75 })
    order.сustomer == сustomer#=>true
    order.manager == manager#=>true

    programmer 	= Programmer.new({ manager: manager, order: order, skill: 100, rationality: 30000, fatigue: 75 })
    programmer.manager == manager#=>true
    programmer.order == order#=>true
  end
end