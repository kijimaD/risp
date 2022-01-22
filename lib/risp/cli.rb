module Risp
  class Cli < Thor
    desc 'repl', 'repl'
    def repl
      Risp.repl
    end
  end
end
