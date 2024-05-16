require 'rails/railtie'

module ActivePrompt
  class Railtie < Rails::Railtie
    config.app_generators do |g|
      g.templates.unshift File.expand_path('../generators/active_prompt', __dir__)
    end
  end
end
