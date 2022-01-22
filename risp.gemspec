# frozen_string_literal: true

require_relative "lib/risp/version"

Gem::Specification.new do |spec|
  spec.name = "risp"
  spec.version = Risp::VERSION
  spec.authors = ["kijima"]
  spec.email = ["norimaking777@gmail.com"]

  spec.summary = "Lisp implementation on Ruby."
  spec.description = "Lisp implementation on Ruby."
  spec.homepage = "https://github.com/kijimaD/risp"
  spec.license = "GPL3"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://github.com/kijimaD/risp"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kijimaD/risp"
  spec.metadata["changelog_uri"] = "https://github.com/kijimaD/risp"

  spec.files = Dir.glob('{assets,config,lib}/**/*', File::FNM_DOTMATCH)
  spec.bindir = "exe"
  spec.executables = 'risp'
  spec.require_paths = ["lib"]
end
