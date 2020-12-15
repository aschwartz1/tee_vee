class Character
  def initialize(information)
    @information = information
  end

  def name
    @information[:name]
  end

  def actor
    @information[:actor]
  end

  def salary
    @information[:salary]
  end
end
