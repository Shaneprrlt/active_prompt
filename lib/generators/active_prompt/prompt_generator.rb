# frozen_string_literal: true

require "rails/generators"

module ActivePrompt
  module Generators
    # This generator creates a new prompt in the app/prompts directory
    class PromptGenerator < Rails::Generators::NamedBase
      desc "This generator creates a new prompt in the app/prompts directory"
      source_root File.expand_path("templates", __dir__)

      # rubocop:disable Metrics/MethodLength
      def create_prompt_files
        unless File.exist?("app/prompts/application_prompt.rb")
          create_file "app/prompts/application_prompt.rb", <<~RUBY
            # frozen_string_literal: true

            class ApplicationPrompt < ActivePrompt::Base
              def run(model: 'gpt-3.5-turbo-0613', json_output: false, temperature: 1.0)
                # client = OpenAI::Client.new
                # parameters = {
                #   model: model,
                #   messages: render_messages,
                #   temperature: temperature
                # }
                # parameters[:response_format] = { type: 'json_object' } if json_output
                # client.chat(parameters: parameters)

                raise NotImplementedError, 'please implement this function using your chosen LLM library'
              end
            end
          RUBY
        end

        empty_directory "app/prompts/templates/#{name.underscore}_prompt"
        template "system.liquid", "app/prompts/templates/#{name.underscore}_prompt/system.liquid"
        template "user.liquid", "app/prompts/templates/#{name.underscore}_prompt/user.liquid"
        create_file "app/prompts/#{name.underscore}_prompt.rb", <<~RUBY
          # frozen_string_literal: true

          class #{name.camelize}Prompt < ApplicationPrompt
            # variable :name
          end
        RUBY
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
