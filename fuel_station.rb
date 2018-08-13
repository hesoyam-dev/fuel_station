require_relative './car'
require_relative './pump'
require 'pry'

class FuelStation
  attr_accessor :pumps, :cars_queue
  include Enumerable
  STATIONS_NAME = %w[OKKO WOG UKR_NAFTA SOCAR].freeze

  def initialize(name: STATIONS_NAME.sample, pumps_count: 3)
    @name = name
    @pumps = []
    pumps_count.times do |p|
      @pumps << Pump.new(pump_id: p + 1)
    end
  end

  def cars_queue(cars: 6)
    @cars_queue = []
    cars.times do |i|
      @cars_queue << Car.new(car_id: i)
    end
    @cars_queue
  end

  def assign_to_pumps(cars_queue, pumps)
    chunk_queue(cars_queue, pumps.length).each_with_index do |cars, index|
      pumps[index].cars << cars;
      pumps[index].cars.flatten!
    end
  end

  def chunk_queue(array, pieces=2)
    len = array.length;
    mid = (len/pieces)
    chunks = []
    start = 0
    1.upto(pieces) do |i|
      last = start+mid
      last = last-1 unless len%pieces >= i
      chunks << array[start..last] || []
      start = last+1
    end
    chunks
  end
end

station = FuelStation.new
cars_queue = station.cars_queue(cars: 7)
pumps = station.pumps
threads = []
station.assign_to_pumps(cars_queue, station.pumps)
station.pumps.each do |pump|
  threads << Thread.new(pump) do |pump|
    pump.cars.each do |car|
      pump.fuel_car(car.model_name, car.tank)
    end
  end  
end

threads.each(&:join)
