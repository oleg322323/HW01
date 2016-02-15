class Customer
	#attr_reader :requirements, :remuneration, :competence, :adequacy
 	attr_reader :manager

 	def initialize(options)
 		@manager			= options[:manager] #link

		@requirements = options[:requirements]
		@remuneration = options[:remuneration]
		@сompetence   = options[:competence]
		@adequacy     = options[:adequacy]
	end
end

#Customer.new({ manager: manager, requirements: 100, remuneration: 30000, competence: 75, adequacy: 63 })