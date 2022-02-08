# beekeeper
A static code generator that turns OpenAPI definitions into sorbet-rails code. It's 100% writter in Ruby and has no
dependencies. The intention is to keep it simple and blazingly fast.



## Try it out

Beekeeper is far from finished yet but you can preview the code generation with the following steps.

```sh
gem build beekeeper.gemspec # build the gem
gem install beekeeper-0.1.0.gem # install it
irb # open ruby console
```

```ruby
require 'beekeeper'
Beekeeper.generate(config_file_path: 'example-config.yml')
```

With the default example configuration, this will generate a `test_output` folder in the repository root. You can tweak
the `example-config.yml` to your liking. Both JSON and YAML are accepted as configuration file formats and as OpenAPI
specification formats.