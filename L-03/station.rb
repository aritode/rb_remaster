class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    @trains << train unless @trains.include?(train)
  end

  def release_train(train)
    @trains.delete(train)
  end

  def trains
    @trains.each { |train| puts train }
  end

  def trains_by(type)
    trains.map { |train| train.type == type }
  end
end
