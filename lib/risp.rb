# frozen_string_literal: true

require 'bundler'
require 'pry-byebug'
require 'sexp'
require 'thor'

require_relative "risp/version"
require_relative 'array'
require_relative 'cons'
require_relative 'env'
require_relative 'interpreter'
require_relative 'lambda'
require_relative 'object'
require_relative 'symbol'
require_relative 'risp/version'
require_relative 'risp/cli'

module Risp
  class Error < StandardError; end

  class Risp
    def self.run
      Risp::Interpreter.new.repl
    end
  end
end
