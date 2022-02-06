# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'apiculturist'
  spec.version = '0.1.0'
  spec.summary = 'Sorbet-rails static code generator from OpenAPI definitions'
  spec.description = '"A static code generator that turns OpenAPI definitions into sorbet-rails code.'
  spec.authors = ['Jacobo Bouzas Quiroga']
  spec.email = 'jacobo@lostrego.org'
  spec.files = Dir['**/*'].keep_if { |file| File.file?(file) && File.extname(file) == '.rb' }
  spec.homepage = 'https://rubygems.org/gems/apiculturist'
  spec.license = 'GPL-3.0'
end
