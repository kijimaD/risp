require 'pry-byebug'
require 'sexp'

require_relative 'array'
require_relative 'cons'
require_relative 'env'
require_relative 'interpreter'
require_relative 'lambda'
require_relative 'object'
require_relative 'symbol'

Risp::Interpreter.new.repl
