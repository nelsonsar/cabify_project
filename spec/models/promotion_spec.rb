require './models/promotion'

RSpec.describe Promotion do
  describe '.initialize' do
    it 'raises not implemented method' do
      expect { Promotion.new }.to raise_error(NotImplementedError)
    end
  end

  describe '#discount' do
    it 'raises not implemented method' do
      Promotion.class_eval { def initialize; end }
      promotion = Promotion.new

      expect { promotion.discount }.to raise_error(NotImplementedError)
    end
  end
end
