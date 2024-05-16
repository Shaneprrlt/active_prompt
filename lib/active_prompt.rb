# frozen_string_literal: true

require_relative "active_prompt/base"
require_relative "active_prompt/errors"
require_relative "active_prompt/version"
require_relative "active_prompt/railtie" if defined?(::Rails::Railtie)

module ActivePrompt
  class Error < StandardError; end
end
