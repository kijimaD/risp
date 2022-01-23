module Risp
  class Lambda
    def initialize(env, forms, params, *code)
      @env    = env
      @forms  = forms
      @params = params.arrayify
      @code   = code
    end

    def call(*args)
      raise "Expected #{@params.size} arguments" unless args.size == @params.size
      newenv = Risp::Env.new(@env)
      newforms = Risp::Env.new(@forms)
      @params.zip(args).each do |sym, value|
        newenv.define(sym, value)
      end
      @code.map{|c| c.lispeval(newenv, newforms) }.last
    end

    def to_sexp
      "(lambda #{@params.to_sexp} #{@code.map{|x| x.to_sexp}.join(' ')})"
    end

    def to_proc
      return lambda{|*args| self.call(*args) }
    end
  end
end
