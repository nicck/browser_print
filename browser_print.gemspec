# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'browser_print/version'

Gem::Specification.new do |gem|
  gem.name          = "browser_print"
  gem.version       = BrowserPrint::VERSION
  gem.authors       = ["nicck"]
  gem.email         = ["nicck.olay@gmail.com"]
  gem.description   = %q{awesome_print right in your browser}
  gem.summary       = %q{print object inspect on top of rendered HTML page}
  gem.homepage      = "http://github.com/nicck/browser_print"

  gem.add_dependency 'awesome_print'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rack-test'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
