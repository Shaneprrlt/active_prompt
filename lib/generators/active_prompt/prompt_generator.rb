# frozen_string_literal: true

require "rails/generators"

module ActivePrompt
  module Generators
    # This generator creates a new prompt in the app/prompts directory
    class PromptGenerator < Rails::Generators::NamedBase
      desc "This generator creates a new prompt in the app/prompts directory"
      source_root File.expand_path("templates", __dir__)

      def create_prompt_files
        empty_directory "app/prompts/#{name.underscore}"
        template "system.liquid", "app/prompts/#{name.underscore}/system.liquid"
        template "user.liquid", "app/prompts/#{name.underscore}/user.liquid"
        create_file "app/prompts/#{name.underscore}_prompt.rb", <<~RUBY
          # This is a generated prompt class for #{file_name}
          class #{name.camelize}Prompt < ActivePrompt::Base
            # Define your required template variables here, e.g.
            # variable :name
            # variable :age
            # variable :gender
          end
        RUBY
      end
    end
  end
end
