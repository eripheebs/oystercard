require 'oystercard'

describe Oystercard do
  let(:journey_class) { double :journey_class }
  subject(:card) {described_class.new(journey_class)}
  let(:station) { double :station }
  let(:station) { double :station }
  let(:journey) { double :journey}

  before do
    allow(journey).to receive(:finish).with(station).and_return(true)
    allow(journey).to receive(:calculate_fare).and_return(1)
    allow(journey_class).to receive(:new).with(station).and_return(journey)
  end

  describe '#balance' do
    it 'checks that it has a balance' do
      expect(card.balance).to eq 0
    end
  end

  context 'when is topped up' do
    before { card.top_up(described_class::MAX_AMOUNT) }

    describe '#top_up' do
      it 'raises' do
        error = described_class::MAX_ERROR
        expect { card.top_up 1 }.to raise_error error
      end
    end

    describe '#journeys' do
      it 'keeps track of journeys' do
        card.touch_in(station)
        expect{ card.touch_out(station) }.to change{ card.journeys.size }.by(1)
      end
    end

    describe '#in_journey?' do

      it 'starts out not in journey' do
        expect(card).to_not be_in_journey
      end
    end

    context 'when has touched in' do
      before :each do
        card.touch_in station
      end

      describe '#touch_in' do
        it 'puts in journey' do
          expect(card).to be_in_journey
        end

      end

      describe '#touch_out' do
        it 'takes out of journey' do
          card.touch_out(station)
          expect(card).not_to be_in_journey
        end

        it 'deducts minimum fare' do
          min_fare = described_class::MIN_FARE
          expect{ card.touch_out station }.to change{ card.balance }.by(-min_fare)
        end
      end
    end
  end

  context 'when not topped up' do
    describe '#top_up' do
      it 'increases balance by given amount' do
        expect { card.top_up(8) }.to change{ card.balance }.by(8)
      end
    end

    describe '#touch_in' do
      it 'raises error' do
        error = described_class::MIN_ERROR
        expect{ card.touch_in station }.to raise_error error
      end
    end
  end

end
