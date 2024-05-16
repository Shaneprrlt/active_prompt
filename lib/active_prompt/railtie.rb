require 'rails/railtie'

module ActivePrompt
  class Railtie < Rails::Railtie
    generators do
      require_relative 'generators/active_prompt/prompt/prompt_generator'
    end
  end
end
