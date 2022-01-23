RSpec.describe Risp::Cons do
  let(:cons) { Risp::Cons.new(:+, [1, 2]) }

  describe '#initialize' do
    it 'have car and cons attribute' do
      expect(cons.car).to eq :+
      expect(cons.cdr).to eq [1, 2]
    end
  end

  describe '#lispeval' do
    context 'when exist symbol' do
      it 'return evaluated value' do
        env = Risp::Env.new(nil, { :+ => lambda {|x, y| x + y } })
        forms = Risp::Env.new(nil, { })
        expect(cons.lispeval(env, forms)).to eq 3
      end
    end

    context 'when not exist symbol' do
      it 'raise error' do
        env = Risp::Env.new(nil, { })
        forms = Risp::Env.new(nil, { })
        expect{ cons.lispeval(env, forms) }.to raise_error(RuntimeError)
      end
    end

    context 'when exist other cons in cdr' do
      it 'return recursive evaluated value' do
        child = Risp::Cons.new(:+, [1, 2])
        parent = Risp::Cons.new(:+, [child, 2])

        env = Risp::Env.new(nil, { :+ => lambda {|x, y| x + y } })
        forms = Risp::Env.new(nil, { })
        expect(parent.lispeval(env, forms)).to eq 5
      end
    end
  end
end
