module Risp
  class Interpreter
    DEFAULTS = {
      :nil   => :nil,
      :t     => :t,
      :+     => lambda {|x, y| x + y },
      :-     => lambda {|x, y| x - y },
      :*     => lambda {|x, y| x * y },
      :/     => lambda {|x, y| x / y },
      :car   => lambda {|x   | x.car },
      :cdr   => lambda {|x   | x.cdr },
      :cons  => lambda {|x, y| Cons.new(x, y) },
      :atom? => lambda {|x   | x.kind_of?(Cons) ? :nil : :t},
      :eq?   => lambda {|x, y| x.equal?(y) ? :t : :nil},
      :list  => lambda {|*args| Cons.from_a(args)},
      :print => lambda {|*args| puts *args; :nil },
    }

    FORMS = {
      :quote => lambda {|env, forms, exp| exp },
      :define => lambda {|env, forms, sym, value|
        env.define(sym, value.lispeval(env, forms))
      },
      :set! => lambda {|env, forms, sym, value|
        env.set(sym, value.lispeval(env, forms))
      },
      :if => lambda {|env, forms, cond, xthen, xelse|
        if cond.lispeval(env, forms) != :nil
          xthen.lispeval(env, forms)
        else
          xelse.lispeval(env, forms)
        end
      },
      :lambda => lambda {|env, forms, params, *code|
        Lambda.new(env, forms, params, *code)
      },
      :defmacro => lambda {|env, forms, name, exp|
        func = exp.lispeval(env, forms)
        forms.define(name, lambda{|env2, forms2, *rest| func.call(*rest).lispeval(env, forms) })
        name
      },
      :eval => lambda {|env, forms, *code|
        code.map{|c| c.lispeval(env, forms)}.map{|c| c.lispeval(env, forms) }.last
      },
      :letmacro => lambda{|env, forms, binding, body|
        name = binding.car
        func = binding.cdr.car.lispeval(env, forms)
        newforms = Env.new(forms)
        newforms.define(name, lambda{|env2, forms2, *rest| func.call(*rest).lispeval(env, forms)})
        body.lispeval(env, newforms)
      },
      :ruby => lambda {|env, forms, name|
        Kernel.const_get(name)
      },
      :"!" => lambda {|env, forms, object, message, *params|
        evaled_params = params.map{|p| p.lispeval(env, forms).arrayify }
        proc = nil
        proc = evaled_params.pop if evaled_params.last.kind_of?(Lambda)
        object.lispeval(env, forms).send(message, *evaled_params, &proc).consify
      },
    }

    def initialize(defaults=DEFAULTS, forms=FORMS)
      @env   = Env.new(nil, defaults)
      @forms = Env.new(nil, forms)
    end

    def eval(string)
      exps = "(#{string})".parse_sexp
      exps.map do |exp|
        exp.consify.lispeval(@env, @forms)
      end.last
    end

    def repl
      print "> "
      STDIN.each_line do |line|
        begin
          puts self.eval(line).to_sexp
        rescue StandardError => e
          puts "ERROR: #{e}"
        end
        print "> "
      end
    end
  end
end
