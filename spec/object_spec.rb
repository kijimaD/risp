RSpec.describe Object do
  describe 'lispeval' do
    specify '#lispeval' do
      expect(Object.lispeval(Risp::Env.new, Risp::Env.new)).to eq Object
    end
  end

  describe '#consify' do
    specify do
      expect(Object.consify).to eq Object
    end
  end


  describe '#arrayify' do
    specify do
      expect(Object.arrayify).to eq Object
    end
  end

  describe '#conslist?' do
    specify do
      expect(Object.conslist?).to eq false
    end
  end
end
