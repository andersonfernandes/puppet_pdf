[![Gem Version](https://badge.fury.io/rb/puppet_pdf.svg)](https://badge.fury.io/rb/puppet_pdf) [![Build Status](https://travis-ci.org/andersonfernandes/puppet_pdf.svg?branch=master)](https://travis-ci.org/andersonfernandes/puppet_pdf) [![Maintainability](https://api.codeclimate.com/v1/badges/d7347b2b2ab3ffdc4668/maintainability)](https://codeclimate.com/github/andersonfernandes/puppet_pdf/maintainability)

# PuppetPdf

PuppetPdf is a lib that wraps [Google Puppeteer](https://pptr.dev/) pdf generation method to be used with Rails.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'puppet_pdf'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install puppet_pdf

Run this task to install some dependencies: 

    $ rails puppet_pdf:install_dependencies

## Usage

In any part of the application you can call:

```ruby
PuppetPdf.pdf_from_url(url, options)
```
***For now only the output_path option is available to use.***

And a pdf of the given url will be generated, and the path to this file is going to be returned.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/puppet_pdf. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PuppetPdf project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/puppet_pdf/blob/master/CODE_OF_CONDUCT.md).
