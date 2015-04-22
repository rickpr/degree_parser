# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'degree_parse/version'

Gem::Specification.new do |spec|
  spec.name          = "degree_parse"
  spec.version       = DegreeParse::VERSION
  spec.authors       = ["Ricardo Piro-Rael"]
  spec.email         = ["fdisk@fdisk.co"]
  spec.summary       = %q{A gem to parse degree requirements using YAML}
  spec.description   = %q{This gem allows us to quickly parse degrees using YAML, then translate them to Prolog.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
