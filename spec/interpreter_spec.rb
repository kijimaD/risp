RSpec.describe Risp::Interpreter do
  let(:interpreter) { Risp::Interpreter.new }
  subject { interpreter.eval(risp) }

  describe  'Default Functions' do
    describe 'nil' do
      let(:risp) { '(nil)' }

      it 'return :nil' do
        expect(subject).to eq :nil
      end
    end

    describe 't' do
      let(:risp) { '(t)' }

      specify do
        expect(subject).to eq :t
      end
    end

    describe '+' do
      let(:risp) { '(+ 1 1)' }

      specify do
        expect(subject).to eq 2
      end
    end

    describe '-' do
      let(:risp) { '(- 1 1)' }

      specify do
        expect(subject).to eq 0
      end
    end

    describe '*' do
      let(:risp) { '(* 1 1)' }

      specify do
        expect(subject).to eq 1
      end
    end

    describe '/' do
      let(:risp) { '(/ 1 1)' }

      specify do
        expect(subject).to eq 1
      end
    end

    describe 'car' do
      let(:risp) { '(car (list 1 2))' }

      specify do
        expect(subject).to eq 1
      end
    end

    describe 'cdr' do
      let(:risp) { '(cdr (list 1 2))' }

      specify do
        expect(subject.arrayify).to eq [2]
      end
    end

    describe 'cons' do
      let(:risp) { '(cons 1 (cons 2 nil))' }

      specify do
        expect(subject.arrayify).to eq [1, 2]
      end
    end

    describe 'atom?' do
      let(:risp) { '(atom? t)' }

      context 'when list is atom' do
        it 'return :t' do
          expect(subject).to eq :t
        end
      end

      context 'when list is not atom' do
        let(:risp) { '(atom? (cons 1 (cons 2 nil)))' }

        it 'return :nil' do
          expect(subject).to eq :nil
        end
      end
    end

    describe 'eq?' do
      context 'when equal' do
        let(:risp) { '(eq? 1 1)' }

        it 'return :t' do
          expect(subject).to eq :t
        end
      end

      context 'when not equal' do
        let(:risp) { '(eq? 1 2)' }

        it 'return :nil' do
          expect(subject).to eq :nil
        end
      end
    end

    describe 'list' do
      let(:risp) { '(list 1 2)' }

      specify do
        expect(subject.class).to eq Risp::Cons
        expect(subject.arrayify).to eq [1, 2]
      end
    end

    describe 'print' do
      let(:risp) { '(print "aaa")' }

      specify do
        expect(subject). to eq :nil
      end
    end
  end

  describe  'Special Forms' do
    describe 'quote' do
      let(:risp) { '(quote aaa)' }

      specify do
        expect(subject).to eq :aaa
      end
    end

    describe 'define' do
      let(:risp) do
        '
        (define aaa 111)
        (aaa)
        '
      end

      specify do
        expect(subject).to eq 111
      end
    end

    describe 'set!' do
      # let(:risp) do
      #   '
      #   (define aaa 111)
      #   (set! aaa 222)
      #   aaa
      #   '
      # end

      xspecify do
        # FIXME: multiline eval problem
        expect(subject).to eq 222
      end

      specify do
        interpreter.eval('(define aaa 111)')
        interpreter.eval('(set! aaa 222)')
        expect(interpreter.eval('aaa')).to eq 222
      end
    end

    describe 'if' do
      context 'when true condition' do
        let(:risp) { '(if t 1 2)' }

        it 'specify' do
          expect(subject).to eq 1
        end
      end

      context 'when false condition' do
        let(:risp) { '(if nil 1 2)' }

        specify do
          expect(subject).to eq 2
        end
      end
    end

    describe 'lambda' do
      let(:risp) { '(lambda (+ 1 2))' }

      specify do
        expect(subject.class).to eq Risp::Lambda
      end
    end

    describe 'defmacro' do
      let(:risp) { '' }

      specify do
        interpreter.eval('(defmacro unless (lambda (cond then else) (list (quote if) cond else then)))')
        expect(interpreter.eval('(unless nil 1 2)')).to eq 1
        expect(interpreter.eval('(unless t 1 2)')).to eq 2
      end
    end

    describe 'eval' do
      let(:risp) { '(eval (quote (+ 1 2)))' }

      specify do
        expect(subject).to eq 3
      end
    end

    describe 'letmacro' do
      let(:risp) { '' }

      specify do

      end
    end

    describe 'ruby' do
      let(:risp) { '' }

      specify do

      end
    end

    describe '!' do
      let(:risp) { '' }

      specify do
        interpreter.eval('(define f (! (ruby File) open "README.md"))')
        interpreter.eval('(define lines (! f readlines))')
        interpreter.eval('(! f close)')
        expect(interpreter.eval('(eval lines)')).to include 'Risp'
      end

      specify do
        expect(interpreter.eval('(! (ruby Object) name)')).to eq 'Object'
      end
    end
  end

  describe 'handle string correctly' do
    it 'return string' do
      interpreter.eval('(define string (+ "aaa" "aaa"))')
      expect(interpreter.eval('string')).to eq "aaaaaa"
    end
  end
end
