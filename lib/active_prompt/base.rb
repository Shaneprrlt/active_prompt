# frozen_string_literal: true

# lib/active_prompt/base.rb
require "active_support/inflector"
require "liquid"
require_relative "errors"

module ActivePrompt
  # Base class for all prompt classes
  class Base
    def self.variables
      @variables ||= []
    end

    def self.variable(name)
      variables << name
      attr_accessor name
    end

    def initialize(params = {})
      self.class.variables.each do |var|
        raise MissingVariableError, var unless params.key?(var)

        send("#{var}=", params[var]) # Dynamic method call to set the variable
      end
    end

    def render_system
      render_template("system.liquid")
    end

    def render_user
      render_template("user.liquid")
    end

    def render_messages
      [
        { role: "system", content: render_system },
        { role: "user", content: render_user }
      ]
    end

    private

    def render_template(template_name)
      template_path = File.join("app", "prompts", "templates", "#{self.class.name.underscore}", template_name)
      template = File.read(template_path)
      context = # Dynamic method call to get the variable value
        self.class.variables.map do |var|
          [var, send(var)]
        end.to_h
      Liquid::Template.parse(template).render(context.stringify_keys)
    end
  end
end
