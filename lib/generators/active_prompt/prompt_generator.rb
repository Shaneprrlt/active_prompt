# frozen_string_literal: true

require "rails/generators"

module ActivePrompt
  module Generators
    # This generator creates a new prompt in the app/prompts directory
    class PromptGenerator < Rails::Generators::NamedBase
      desc "This generator creates a new prompt in the app/prompts directory"
      source_root File.expand_path("templates", __dir__)

      def create_prompt_files
        empty_directory "app/prompts/templates/#{name.underscore}_prompt"
        template "system.liquid", "app/prompts/templates/#{name.underscore}_prompt/system.liquid"
        template "user.liquid", "app/prompts/templates/#{name.underscore}_prompt/user.liquid"
        create_file "app/prompts/#{name.underscore}_prompt.rb", <<~RUBY
          # frozen_string_literal: true

          class #{name.camelize}Prompt < ActivePrompt::Base
            # variable :name
          end
        RUBY
      end
    end
  end
end
