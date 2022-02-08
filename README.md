# apiculturist
A static code generator that turns OpenAPI definitions into sorbet-rails code.

# Try it out

Apiculturist is far from finished yet but you can preview the code generation with the following steps.

```sh
gem build apiculturist.gemspec # build the gem
gem install apiculturist-0.1.0.gem # install it
irb # open ruby console
```

```ruby
require 'apiculturist'
Apiculturist.generate(config_file_path: 'example-config.yml')
```

With the default example configuration, this will generate a `test_output` folder in the repository root. You can tweak
the `example-config.yml` to your liking. Both JSON and YAML are accepted as configuration file formats and as OpenAPI
specification formats.