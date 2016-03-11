require 'station'

describe Station do
  subject(:station) { described_class.new name, zone}
  let(:name) {double :name}
  let(:zone) {double :zone}

  describe '#initialize' do
    it 'should initialize with a name' do
      expect(station.name).to eq(name)
    end

    it 'should initialize with a zone' do
      expect(station.zone).to eq(zone)
    end
  end

end
