# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git_switch_branch/version'

Gem::Specification.new do |gem|
  gem.name          = "git_switch_branch"
  gem.version       = GitSwitchBranch::VERSION
  gem.authors       = ["Daniel Eriksson"]
  gem.email         = ["daniel.eriksson@bukowskis.com"]
  gem.description   = %q(Easy git branch switching)
  gem.summary       = %q(Simplifies switching between branches without losing uncommitted changes.)
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "git", ">= 1.2.5"
  gem.add_dependency "colored", ">= 1.2"
  gem.add_dependency "highline", ">= 1.6.15"

end
