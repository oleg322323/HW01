class Programmer
	#attr_reader :skill, :rationality, :fatigue
	attr_reader :manager, :order

  def initialize(options)
  	@manager			= options[:manager] #link
  	@order 				= options[:order] #link

    @skill 				= options[:skill]
    @rationality 	= options[:rationality]
    @fatigue   		= options[:fatigue]
  end
end

#Programmer.new({ manager: manager, order: order, skill: 100, rationality: 30000, fatigue: 75 })