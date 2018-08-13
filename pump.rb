require 'ruby-progressbar'

class Pump
  attr_accessor :pump_id, :busy, :cars

  def initialize(pump_id:, busy: false)
    @pump_id = pump_id
    @busy    = busy
    @cars    = []   
  end

  def busy?
    @busy
  end

  def fuel_car(model_name, tank)
    fueling = ProgressBar.create(title: "PUMP: #{@pump_id} || #{model_name} / #{tank}", starting_at: 0, total: tank)
    tank.times do
      fueling.increment
      sleep 0.01
    end
  end
end
