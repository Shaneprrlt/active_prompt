# frozen_string_literal: true

require_relative "lib/active_prompt/version"

Gem::Specification.new do |spec|
  spec.name = "active_prompt"
  spec.licenses = ["MIT"]
  spec.version = ActivePrompt::VERSION
  spec.authors = ["Shane Perreault"]
  spec.email = ["shaneprrlt@gmail.com"]
  spec.summary = "Easily create and manage LLM prompt templates in your rails app."
  spec.description = "Easily create and manage LLM prompt templates in your rails app." \
                     "Use your own custom templating engine like ERB or Shopify Liquid."
  spec.homepage = "https://www.github.com/Shaneprrlt/active_prompt"
  spec.required_ruby_version = ">= 2.6.0"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://www.github.com/Shaneprrlt/active_prompt"
  spec.metadata["changelog_uri"] = "https://www.github.com/Shaneprrlt/active_prompt/blob/main/CHANGELOG.md"
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency "liquid", "~> 5.2", ">= 5.2.0"
  spec.add_runtime_dependency "rails", "~> 6.0"
end
