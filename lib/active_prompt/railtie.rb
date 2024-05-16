# frozen_string_literal: true

require "rails/railtie"

module ActivePrompt
  class Railtie < Rails::Railtie
    config.autoload_paths << Dir["#{config.root}/app/prompts/**/"]
  end
end
