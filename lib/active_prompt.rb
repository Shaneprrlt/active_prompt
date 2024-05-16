# frozen_string_literal: true

require "active_prompt/railtie" if defined?(::Rails::Railtie)
require "active_prompt/base"
require "active_prompt/errors"
require "active_prompt/version"

module ActivePrompt
  class Error < StandardError; end
end
