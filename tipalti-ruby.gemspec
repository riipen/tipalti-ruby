# frozen_string_literal: true

require_relative "lib/tipalti-ruby/version"

Gem::Specification.new do |spec|
  spec.name = "tipalti-ruby"
  spec.version = Tipalti::VERSION
  spec.authors = ["Jordan Ell"]
  spec.email = ["me@jordanell.com"]

  spec.summary = "An API client for Tipalti in ruby."
  spec.description = "An API client for Tipalti in ruby."
  spec.homepage = "https://github.com/riipen/tipalti-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/riipen/tipalti-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/riipen/tipalti-ruby/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "faraday", "~> 1.0", ">= 1.0.0"
  spec.add_runtime_dependency "oauth2", "~> 2.0"

  spec.metadata["rubygems_mfa_required"] = "true"
end
