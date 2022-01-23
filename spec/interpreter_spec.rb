RSpec.describe Risp::Interpreter do
  let(:risp) { Risp::Interpreter.new }

  describe 'nil' do
    it 'return :nil' do
      expect(risp.eval('(nil)')).to eq :nil
    end
  end

  describe 't' do
    specify do
      expect(risp.eval('(t)')).to eq :t
    end
  end

  describe '+' do
    specify do
      expect(risp.eval('(+ 1 1)')).to eq 2
    end
  end

  describe '-' do
    specify do
      expect(risp.eval('(- 1 1)')).to eq 0
    end
  end

  describe '*' do
    specify do
      expect(risp.eval('(* 1 1)')).to eq 1
    end
  end

  describe '/' do
    specify do
      expect(risp.eval('(/ 1 1)')).to eq 1
    end
  end

  describe 'car' do
    specify do
      expect(risp.eval('(car (list 1 2))')).to eq 1
    end
  end

  describe 'cdr' do
    specify do
      expect(risp.eval('(cdr (list 1 2))').arrayify).to eq [2]
    end
  end

  describe 'cons' do
    specify do
      expect(risp.eval('(cons 1 (cons 2 nil))').arrayify).to eq [1, 2]
    end
  end

  describe 'atom?' do
    context 'when list is atom' do
      it 'return :t' do
        expect(risp.eval('(atom? t)')).to eq :t
      end
    end

    context 'when list is not atom' do
      it 'return :nil' do
        expect(risp.eval('(atom? (cons 1 (cons 2 nil)))')).to eq :nil
      end
    end
  end

  describe 'eq?' do
    context 'when equal' do
      it 'return :t' do
        expect(risp.eval('(eq? 1 1)')).to eq :t
      end
    end

    context 'when not equal' do
      it 'return :nil' do
        expect(risp.eval('(eq? 1 2)')).to eq :nil
      end
    end
  end

  describe 'list' do
    specify do
      expect(risp.eval('(list 1 2)').class).to eq Risp::Cons
      expect(risp.eval('(list 1 2)').arrayify).to eq [1, 2]
    end
  end

  describe 'print' do
    specify do
      expect(risp.eval('(print "aaa")')). to eq :nil
    end
  end
end
