#encoding: utf-8
Gem::Specification.new do |gem|
  gem.name    = "district"
  gem.version = "0.1.0"

  gem.authors     = "Anthony Laibe"
  gem.email       = "anthony.laibe@gmail.com"
  gem.description = ""
  gem.summary     = gem.description
  gem.homepage    = "https://github.com/alaibe/district"

  gem.add_development_dependency "gemnasium-parser"

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(/^spec\//)
  gem.require_paths = ["lib"]
end
