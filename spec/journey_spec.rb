require 'journey'

describe Journey do
  let(:Journey) { described_class }
  let(:entry_station) { double :station }
  let(:journey) { described_class.new entry_station }
  let(:exit_station) { double :station }

  describe '#initialize' do
    it 'sets the entry station' do
    end
  end

  describe '#calculate_fare' do
    it 'calculates the normal fare when journey complete' do
      journey.change_station(exit_station)
      expect(journey.calculate_fare).to eq(Journey::MINIMUM_FARE)
    end

    it 'calculates a penalty fare when journey incomplete' do
      expect(journey.calculate_fare).to eq(Journey::PENALTY_FARE)
    end
  end
end
