# frozen_string_literal: true

module ActivePrompt
  # Error raised when a required variable is missing
  class MissingVariableError < StandardError
    def initialize(variable_name)
      super("Missing required variable: #{variable_name}")
    end
  end
end
