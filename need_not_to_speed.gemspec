
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'need_not_to_speed/version'

Gem::Specification.new do |spec|
  spec.name          = 'need_not_to_speed'
  spec.version       = NeedNotToSpeed::VERSION
  spec.authors       = ['Petr Wudi']
  spec.email         = ['petr.wudi@gmail.com']
  spec.license       = 'MIT'

  spec.summary       = 'A game with cars where you have to obey traffic law'
  spec.description   = 'A game when player has to finish as fast as possible ' \
                       'without breaking any traffic law.'
  spec.homepage      = 'https://github.com/wudip/need-not-to-speed'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'chunky_png', '~> 1.3.10', '>= 1.3.10'
  spec.add_runtime_dependency 'gosu', '~> 0.13.0', '>= 0.13.0'
  spec.add_runtime_dependency 'json', '~> 2.1.0', '>= 2.1.0'
  spec.add_development_dependency 'bundler', '~> 1.16', '>= 1.16'
  spec.add_development_dependency 'inch', '~> 0.7.1', '>= 0.7.1'
  spec.add_development_dependency 'rake', '~> 10.0', '>= 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0', '>= 3.0'
  spec.add_development_dependency 'rspec-simplecov', '~> 0.2.2', '>= 0.2.2'
  spec.add_development_dependency 'rubocop', '~> 0.52.1', '>= 0.52.1'
  spec.add_development_dependency 'simplecov', '~> 0.15.1', '>= 0.15.1'
end
