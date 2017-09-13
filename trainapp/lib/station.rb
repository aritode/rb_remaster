class Station
  attr_reader :name, :trains

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
  end

  def self.all
    @@stations
  end

  def accept_train(train)
    @trains << train unless @trains.include?(train)
  end

  def release_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end
end
