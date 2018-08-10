class Car
  attr_accessor :id, :model_name, :fuel_type, :fueled, :tank
  CARS = %w[BWM AUDI Mercedes-Benz Honda HYUNDAI TOYOTA].freeze
  FUEL_TYPE = %w[petrol diesel gas].freeze
  TANKS = [40, 50, 60, 70].freeze

  def initialize(car_id:, model_name: CARS.sample, fuel_type: FUEL_TYPE.sample, tank: TANKS.sample)
    @car_id     = car_id
    @model_name = model_name
    @fuel_type  = fuel_type
    @tank       = tank
    @fueled     = false
  end

  def fueled?
    @fueled
  end
end
