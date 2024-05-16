# frozen_string_literal: true

require "rails/railtie"

module ActivePrompt
  # This class is a Railtie that allows ActivePrompt to be loaded as a Rails engine
  class Railtie < Rails::Railtie
    config.eager_load_namespaces << ActivePrompt
  end
end
