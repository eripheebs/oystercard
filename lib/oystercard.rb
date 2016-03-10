class Oystercard

  attr_reader :balance, :entry_station, :journeys

  MAX_AMOUNT = 90
  MIN_FARE = 1
  MAX_ERROR = "Cannot exceed max balance £#{MAX_AMOUNT}"
  MIN_ERROR = "You need to have at least £#{MIN_FARE}"

  def initialize(journey_class = nil)
    @station = nil
    @balance = 0
    @journeys = []
    @journey = nil
    @journey_class = journey_class
  end

  def top_up(amount)
    raise MAX_ERROR if (balance + amount) > MAX_AMOUNT
    @balance += amount
  end

  def in_journey?
    !!@station
  end

  def touch_in(entry_station)
    raise MIN_ERROR unless balance > MIN_FARE
    create_journey(entry_station)
    deduct(@journey.calculate_fare) if in_journey?
    @station = entry_station
  end

  def touch_out(exit_station)
    create_journey(nil) unless in_journey?
    @journey.finish(exit_station)
    deduct(@journey.calculate_fare)
    log_journey
    @station = nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def log_journey
    @journeys << @journey
  end

  def create_journey(station)
    @journey = @journey_class.new(station)
  end

end
