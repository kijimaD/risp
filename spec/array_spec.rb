RSpec.describe Array do
  let(:array) { Array.new([:+, 1, 2]) }

  describe '#consify' do
    it 'convert to Cons object' do
      cons = array.consify

      expect(cons.car).to eq :+
      expect(cons.cdr.car).to eq 1
      expect(cons.cdr.cdr.car).to eq 2
      expect(cons.cdr.cdr.cdr).to eq :nil
    end
  end
end
