RSpec.describe Risp::Cons do
  let(:cons) do
    Risp::Cons.new(:+,
                   Risp::Cons.new(1,
                                  Risp::Cons.new(2, :nil)))
  end

  describe '#initialize' do
    it 'have car and cons attribute' do
      expect(cons.car).to eq :+
      expect(cons.cdr.car).to eq 1
      expect(cons.cdr.cdr.car).to eq 2
      expect(cons.cdr.cdr.cdr).to eq :nil
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

    context 'when cons nesting' do
      it 'return recursive evaluated value' do
        child = Risp::Cons.new(:+, [1, 2])
        parent = Risp::Cons.new(:+, [child, 2])

        env = Risp::Env.new(nil, { :+ => lambda {|x, y| x + y } })
        forms = Risp::Env.new(nil, { })
        expect(parent.lispeval(env, forms)).to eq 5
      end
    end
  end

  describe '#arrayify' do
    context 'when conslist' do
      it 'return array' do
        expect(cons.arrayify).to eq [:+, 1, 2]
      end
    end

    context 'when not conslist' do
      it 'return original cons' do
        cons = Risp::Cons.new(1, 2)
        expect(cons.arrayify).to eq cons
      end
    end
  end

  describe '#conslist?' do
    context 'when composing of cons' do
      it 'return true' do
        expect(cons.conslist?).to be true
      end
    end

    context 'when containing other class' do
      it 'return false' do
        cons = Risp::Cons.new(1, 2)
        expect(cons.conslist?).to be false
      end
    end
  end

  describe '#to_sexp' do
    context 'when composing of cons' do
      it 'return sexp' do
        expect(cons.to_sexp).to eq '(+ 1 2)'
      end
    end

    context 'when containing other class' do
      it 'return cons added sexp' do
        cons = Risp::Cons.new(:+, [1, 2])
        expect(cons.to_sexp).to eq '(cons + (1 2))'
      end
    end
  end
end
