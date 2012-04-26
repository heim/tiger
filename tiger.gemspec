# -*- encoding: utf-8 -*-
require File.expand_path('../lib/tiger/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andreas Heim"]
  gem.email         = ["andreas@heim.no"]
  gem.description   = %q{Calculates various metrics from git repositoried}
  gem.summary       = %q{Hello}
  gem.homepage      = ""
  gem.bindir        = "bin"

  gem.add_dependency('grit', '>=1.5.0')
  gem.add_development_dependency('rspec', '>=2.9.0')
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "tiger"
  gem.require_paths = ["lib"]
  gem.version       = Tiger::VERSION
end
