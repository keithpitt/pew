# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "atomic"
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Charles Oliver Nutter", "MenTaLguY"]
  s.date = "2012-04-26"
  s.description = "An atomic reference implementation for JRuby, Rubinius, and MRI"
  s.email = ["headius@headius.com", "mental@rydia.net"]
  s.extensions = ["ext/extconf.rb"]
  s.files = ["ext/extconf.rb"]
  s.homepage = "http://github.com/headius/ruby-atomic"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "An atomic reference implementation for JRuby, Rubinius, and MRI"
end
