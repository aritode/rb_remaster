# frozen_string_literal: true
require_relative 'modules/validation'

class Station
  include Validation
  attr_reader :name, :trains
  alias to_s name

  validate :name, :presence

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    validate!
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

  def each_train
    trains.each { |train| yield train } if block_given?
  end

  private

  def validate!
    if Station.all.any? { |item| item.name.casecmp(@name.downcase).zero? }
      raise "Station #{@name} is already in Stations"
    end
    super
  end
end
