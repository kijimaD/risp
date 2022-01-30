RSpec.describe Risp::Lambda do
  describe '#call' do
    context 'when params are valid' do
      it 'return the last evaluated value' do
        lambda = Risp::Lambda.new(Risp::Env.new, Risp::Env.new, :nil, 111)
        expect(lambda.call).to eq 111
      end
    end

    context 'when params are invalid' do
      it 'raise error' do
        lambda = Risp::Lambda.new(Risp::Env.new, Risp::Env.new, :nil, 111)
        expect{ lambda.call(:invalid, :params) }.to raise_error RuntimeError # Expected 0 arguments
      end
    end
  end

  describe '#to_sexp' do
    it 'return sexp string' do
      cons = Risp::Cons.new(:+, [1, 2])
      lambda = Risp::Lambda.new(Risp::Env.new, Risp::Env.new, :nil, cons)
      expect(lambda.to_sexp).to eq '(lambda () (cons + (1 2)))'
    end
  end

  describe '#to_proc' do
    it 'return proc' do
      cons = Risp::Cons.new(:+, [1, 2])
      lambda = Risp::Lambda.new(Risp::Env.new, Risp::Env.new, :nil, cons)
      expect(lambda.to_proc.class).to eq Proc
    end
  end
end
