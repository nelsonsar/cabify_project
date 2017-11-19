RSpec.describe Promotion do
  describe '.initialize' do
    it 'raises not implemented method' do
      expect { Promotion.new }.to raise_error(NotImplementedError)
    end
  end

  describe '#apply' do
    Promotion.class_eval do
      def initialize; end
    end

    promotion = Promotion.new
    expect { promotion.apply }.to raise_error(NotImplementedError)
  end
end
