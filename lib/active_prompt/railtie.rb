# frozen_string_literal: true

require "rails/railtie"

module ActivePrompt
  class Railtie < Rails::Railtie
    config.eager_load_namespaces << ActivePrompt
  end
end
