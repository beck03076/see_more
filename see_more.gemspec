# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'see_more/version'

Gem::Specification.new do |gem|
  gem.name          = "see_more"
  gem.version       = SeeMore::VERSION
  gem.authors       = ["beck03076"]
  gem.email         = ["senthilkumar.hce@gmail.com"]
  gem.description   = %q{ This is Toggleable }
  gem.summary       = %q{See more}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency "rails", ">= 3.1"
end
