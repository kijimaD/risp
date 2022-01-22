# frozen_string_literal: true

require 'pry-byebug'
require 'sexp'

require_relative "risp/version"
require_relative 'array'
require_relative 'cons'
require_relative 'env'
require_relative 'interpreter'
require_relative 'lambda'
require_relative 'object'
require_relative 'symbol'

module Risp
  class Error < StandardError; end
end

Risp::Interpreter.new.repl
