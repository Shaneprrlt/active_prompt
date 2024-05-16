# frozen_string_literal: true

require "rails/railtie"

module ActivePrompt
  class Railtie < Rails::Railtie
    generators do
      require_relative "generators/active_prompt/prompt/prompt_generator"
    end

    config.autoload_paths += Dir["#{config.root}/app/prompts/**/"]
  end
end
