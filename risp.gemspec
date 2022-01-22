# frozen_string_literal: true

require_relative "lib/risp/version"

Gem::Specification.new do |spec|
  spec.name = "risp"
  spec.version = Risp::VERSION
  spec.authors = ["kijima"]
  spec.email = ["norimaking777@gmail.com"]

  spec.summary = "TODO: Write a short summary, because RubyGems requires one."
  spec.description = "TODO: Write a longer description or delete this line."
  spec.homepage = "TODO: Put your gem's website or public repo URL here."
  spec.license = "GPL3"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.glob('{assets,config,lib}/**/*', File::FNM_DOTMATCH)
  spec.bindir = "exe"
  spec.executables = risp
  spec.require_paths = ["lib"]
end
