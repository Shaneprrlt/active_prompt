# frozen_string_literal: true

require 'rails/generators'

module ActivePrompt
  module Generators
    # This generator creates a new prompt in the app/prompts directory
    class PromptGenerator < Rails::Generators::Base
      desc "This generator creates a new prompt in the app/prompts directory"
      source_root File.expand_path("templates", __dir__)

      def create_prompt_files
        empty_directory "app/prompts/#{file_name}"
        template "system.liquid", "app/prompts/#{file_name}/system.liquid"
        template "user.liquid", "app/prompts/#{file_name}/user.liquid"
        create_file "app/prompts/#{file_name}/prompt.rb", <<~RUBY
          # This is a generated prompt class for #{file_name}
          class #{file_name.camelize}Prompt < ActivePrompt::Base
            # Define your prompt methods here
          end
        RUBY
      end
    end
  end
end
