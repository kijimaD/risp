RSpec.describe Risp::Env do
  let(:env) { Risp::Env.new }

  describe '#define' do
    it 'return value' do
      expect(env.define(:aaa, 111)).to eq 111
    end
  end

  describe '#defined?' do
    context 'when registered' do
      it 'return true' do
        env.define(:aaa, 111)
        expect(env.defined?(:aaa)).to be true
      end
    end

    context 'when registered on parent' do
      it 'return true' do
        parent = Risp::Env.new
        parent.define(:aaa, 111)

        child = Risp::Env.new(parent)
        expect(child.defined?(:aaa)).to be true
      end
    end

    context 'when symbol and parent not exist' do
      it 'return false' do
        expect(env.defined?(:aaa)).to be false
      end
    end
  end

  describe '#lookup' do
    context 'when symbol key exist' do
      it 'return value' do
        env.define(:aaa, 111)
        expect(env.lookup(:aaa)).to be 111
      end
    end

    context 'when key exist on parent' do
      it 'return value' do
        parent = Risp::Env.new
        parent.define(:aaa, 111)

        child = Risp::Env.new(parent)
        expect(child.lookup(:aaa)).to be 111
      end
    end

    context 'when key and parent not exist' do
      it 'raise error' do
        expect{ env.lookup(:not_exist_key) }.to raise_error(RuntimeError)
      end
    end
  end

  describe '#set' do
    context 'when definition exist' do
      it 'overwrite value' do
        env.define(:aaa, 111)
        env.set(:aaa, 222)
        expect(env.lookup(:aaa)).to eq 222
      end
    end

    context 'when key and parent not exist' do
      it 'raise error' do
        expect{ env.set(:aaa, 111) }.to raise_error(RuntimeError)
      end
    end

    context 'when key exist on parent' do
      it 'overwrite' do
        parent = Risp::Env.new
        parent.define(:aaa, 111)

        child = Risp::Env.new(parent)
        child.set(:aaa, 222)

        expect(child.lookup(:aaa)).to be 222
        expect(parent.lookup(:aaa)).to be 222
      end
    end
  end
end
