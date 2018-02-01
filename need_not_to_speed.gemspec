
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "need_not_to_speed/version"

Gem::Specification.new do |spec|
  spec.name          = "need_not_to_speed"
  spec.version       = NeedNotToSpeed::VERSION
  spec.authors       = ["Petr Wudi"]
  spec.email         = ["petr.wudi@gmail.com"]

  spec.summary       = %q{A game with cars where you have to obey traffic law.}
  spec.description   = %q{A game when player has to finish as fast as possible without breaking any traffic law.}
  spec.homepage      = "https://github.com/wudip/need-not-to-speed"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'chunky_png', '~> 1.3.10'
  spec.add_runtime_dependency 'gosu', '~> 0.13.0'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end