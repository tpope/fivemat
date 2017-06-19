# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Tim Pope"]
  gem.email         = ["code@tp" + 'ope.net']
  gem.description   = %q{MiniTest/RSpec/Cucumber formatter that gives each test file its own line of dots}
  gem.summary       = %q{Why settle for a test output format when you could have a test output fivemat?}
  gem.homepage      = "https://github.com/tpope/fivemat"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "fivemat"
  gem.require_paths = ["lib"]
  gem.version       = '1.3.5'
  gem.license       = 'MIT'
end
