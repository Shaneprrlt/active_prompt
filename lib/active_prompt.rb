# frozen_string_literal: true

require_relative "active_prompt/base"
require_relative "active_prompt/errors"
require_relative "active_prompt/version"
require_relative "active_prompt/generators/active_prompt/prompt/prompt_generator"
require_relative "active_prompt/railtie" if defined?(Rails)

module ActivePrompt
  class Error < StandardError; end
end
