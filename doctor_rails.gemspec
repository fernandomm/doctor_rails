$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "doctor_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "doctor_rails"
  s.version     = DoctorRails::VERSION
  s.authors     = ["Fernando Morgenstern"]
  s.email       = ["contato@fernandomarcelo.com"]
  s.homepage    = "http://fernandomarcelo.com"
  s.summary     = "A heath checker for Rails apps."
  s.description = "Dr. Rails: improving your uptime since 2013."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.11"

  s.add_development_dependency "sqlite3"
end
