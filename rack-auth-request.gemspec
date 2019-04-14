
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rack/auth/request/version"

Gem::Specification.new do |spec|
  spec.name          = "rack-auth-request"
  spec.version       = Rack::Auth::Request::VERSION
  spec.authors       = ["Kugayama Nana"]
  spec.email         = ["nonamea774@gmail.com"]

  spec.summary       = %q{ngx_http_auth_request_module like authorization interface}
  spec.description   = %q{Rack::Auth::Request provides ngx_http_auth_request_module like authorization interface. `auth_request` directive}
  spec.homepage      = "https://github.com/nna774/rack-auth-request"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = spec.homepage
    spec.metadata["changelog_uri"] = "https://github.com/nna774/rack-auth-request/releases"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rack", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
