# ActivePrompt

ActivePrompt is a gem that helps you structure and manage LLM prompts in your rails apps. View the gem on [RubyGems](https://rubygems.org/gems/active_prompt_rails).

## Installation

Add the following line to your Gemfile:

```Gemfile
gem "active_prompt_rails", "~> 0.1.22", require: "active_prompt"
```

and run `bundle install`

## Usage

When you want to create a new LLM prompt, you can generate one using the following command:

```bash
rails g active_prompt:prompt moderate_user_comment
```

This will create the following files in your rails project:

```bash
app/prompts/application_prompt.rb
app/prompts/moderate_user_comment_prompt.rb
app/prompts/templates/moderate_user_comment_prompt/system.liquid
app/prompts/templates/moderate_user_comment_prompt/user.liquid
```

You can add your system message and user message to the corresponding Liquid template files and include any dynamic variables you'd like, e.g.:

```ruby
# /app/prompts/moderate_user_comment_prompt.rb

class ModerateUserCommentPrompt < ApplicationPrompt
  variable :comment
end
```

```liquid
# /app/prompts/templates/moderate_user_comment_prompt/system.liquid

You are a comment moderator agent that is responsible for reviewing and moderating user comments on a social media platform. You are assigned to reviewing comments and returning your decision on whether to approve or flag them for further review. Check for bullying, hate speech, and threatening language. Swearing is allowed as long as it's not harrassing. You return your decision in JSON format with the following structure: 
{
  "result": "approve" (or "flag"),
  "reason": "optional reason for flagging the comment"
}
```

```liquid
# /app/prompts/templates/moderate_user_comment_prompt/user.liquid

Review this comment and return your decision in the specified JSON format:

{{ comment }}
```

Then within your application, you can use this prompt when calling an LLM as such:

```ruby
prompt = ModerateUserCommentPrompt.new(comment: user_comment)

client = OpenAI::Client.new
response = client.chat(
    parameters: {
        model: "gpt-4o",
        response_format: { type: "json_object" },
        messages: prompt.render_messages, # ActivePrompt::Base.render_messages returns OpenAI formatted message data
        temperature: 1.0
    }
)
content = response.dig("choices", 0, "message", "content")
data = JSON.parse(content)
puts data
```

You can also override the `run()` method in `ApplicationPrompt` to integrate your LLM layer with ActivePrompt and execute your prompts from the prompt object. Here's an example using OpenAI:

```ruby
# frozen_string_literal: true

class ApplicationPrompt < ActivePrompt::Base
  def run(model: 'gpt-3.5-turbo-0613', json_output: false, temperature: 1.0)
    client = OpenAI::Client.new
    parameters = {
      model: model,
      messages: render_messages,
      temperature: temperature
    }
    parameters[:response_format] = { type: 'json_object' } if json_output
    client.chat(parameters: parameters)
  end
end
```

Using this, we can simplify the code shown earlier:

```ruby
prompt = ModerateUserCommentPrompt.new(comment: user_comment)
response = prompt.run(model: 'gpt-4o')
output = response.dig("choices", 0, "message", "content")
data = JSON.parse(output)
puts data
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Shaneprrlt/active_prompt.
