# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nuntius/version"

Gem::Specification.new do |s|
  s.name        = "nuntius"
  s.version     = Nuntius::VERSION
  s.author      = "Sebastian Gamboa"
  s.email       = "me@sagmor.com"
  s.homepage    = "https://github.com/sagmor/nuntius"
  s.summary     = %q{Nuntius: A messenger, reporter, courier, bearer of news or tidings}
  s.description = %q{Nuntius is a simple scheme to send and receive messages in a cryptographicaly secure and compatible way.}

  s.rubyforge_project = "nuntius"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", ">= 2.7.0"
end
