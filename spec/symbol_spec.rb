RSpec.describe Symbol do
  describe '#lispeval' do
    context 'when exist key' do
      it 'return value(form)' do
        env = Risp::Env.new(nil, { :+ => lambda {|x, y| x + y } })
        forms = Risp::Env.new

        expect(:+.lispeval(env, forms).class).to eq Proc
      end

      it 'return value(variable)' do
        env = Risp::Env.new
        env.define(:aaa, 111)
        forms = Risp::Env.new

        expect(:aaa.lispeval(env, Risp::Env.new)) .to eq 111
      end
    end
  end

  describe '#arrayify' do
    context 'when symbol is :nil' do
      it '' do
        expect(:nil.arrayify).to eq []
      end
    end

    context 'when symbol is not :nil' do
      it 'return receiver' do
        expect(:+.arrayify).to eq :+
      end
    end
  end

  describe '#conslist?' do
    context 'when receiver is :nil' do
      it 'return true' do
        expect(Risp::Cons.new(1, :nil).conslist?).to be true
      end
    end

    context 'when receiver is not :nil' do
      it 'return false' do
        expect(:+.conslist?).to be false
      end
    end
  end
end
