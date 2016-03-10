require 'journey'

describe Journey do
  let(:Journey) {described_class}
  let(:journey) {described_class.new}
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  describe '#start' do
    it 'sets the entry station' do
      journey.start(entry_station)
      expect(journey.entry_station).to eq(entry_station)
    end

  end

  describe '#finish' do
    it 'sets the exit station' do
      journey.finish(exit_station)
      expect(journey.exit_station).to eq(exit_station)
    end
  end

  describe '#calculate_fare' do
    it 'calculates the normal fare when journey complete' do
      journey.start(entry_station)
      journey.finish(exit_station)
      expect(journey.calculate_fare).to eq(Journey::MINIMUM_FARE)
    end

    it 'calculates a penalty fare when journey incomplete' do
      journey.start(entry_station)
      expect(journey.calculate_fare).to eq(Journey::PENALTY_FARE)
    end
  end

end
