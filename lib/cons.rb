module Risp
  class Cons
    attr_reader :car, :cdr

    def self.from_a(args)
      head, *tail = args
      return :nil unless head
      new(head, from_a(tail))
    end

    def initialize(car, cdr)
      @car, @cdr = car, cdr
    end

    def lispeval(env, forms)
      return forms.lookup(car).call(env, forms, *cdr.arrayify) if forms.defined?(car)
      func = car.lispeval(env, forms)
      return func unless func.class == Proc

      return func.call(*cdr.arrayify.map{|x| x.lispeval(env, forms) })
    end

    def arrayify
      return self unless conslist?
      return [car] + cdr.arrayify
    end

    def conslist?
      cdr.conslist?
    end

    def to_sexp
      return "(cons #{car.to_sexp} #{cdr.to_sexp})" unless conslist?
      return "(#{arrayify.map{|x| x.to_sexp}.join(' ')})"
    end
  end
end
