class Manager
	#attr_reader :communicability, :ability_to_organize

  def initialize(options)
    @communicability		 = options[:communicability]
    @ability_to_organize = options[:ability_to_organize]
  end
end

#Manager.new({ communicability: 100, ability_to_organize: 75 })