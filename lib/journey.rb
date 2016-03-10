
class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end

  def change_station(exit_station)
    @exit_station = exit_station
  end

  def calculate_fare
    return PENALTY_FARE unless complete?
    MINIMUM_FARE
  end

private

  def complete?
    @entry_station && @exit_station ? true : false
  end

end
