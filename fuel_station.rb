require_relative './car'
require_relative './pump'
require 'pry'

class FuelStation
  attr_accessor :pumps, :cars_queue

  STATIONS_NAME = %w[OKKO WOG UKR_NAFTA SOCAR].freeze

  def initialize(name: STATIONS_NAME.sample, pumps_count: 3)
    @name = name
    @pumps = []
    pumps_count.times do |p|
      @pumps << Pump.new(pump_id: p + 1)
    end
  end

  def cars_queue(cars: 10)
    @cars_queue = []
    cars.times do |i|
      @cars_queue << Car.new(car_id: i)
    end
    @cars_queue
  end

end

station = FuelStation.new()
station.cars_queue(cars: 3)
threads = []

station.pumps.each do |pump|
  threads << Thread.new(pump) do |pump|
    station.cars_queue.each do |car|
      print("\r")
      print("\n")
      next if car.fueled
      print(pump.fuel_car(car.model_name, car.tank))
      car.fueled = true
    end
  end
end

threads.each(&:join)
