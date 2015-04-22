# DegreeParse

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'degree_parse'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install degree_parse

## Usage

Require and include this module to use it

``` ruby
require 'degree_parse'

include DegreeParse

student = Student.new(YAML.load(File.read("student.yml")), "requirements.yml.erb")

puts student.check.each
```

This returns a hash of requirement names and whether or not they are satisfied.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/degree_parse/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
# YAML Degree Requirements

This format allows us to specify degree plans in YAML format, and parse a
student to check this student against degree requirements. The next phase is to
make this parser produce Prolog code, and use that for reasoning.


