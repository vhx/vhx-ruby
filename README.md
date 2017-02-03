# VHX Ruby API Client

The VHX API is currently Private Beta. You can request an API key by emailing api@vhx.tv.

### Installation

`gem install vhx-ruby`

#### Building Locally

```shell
$ gem build vhx.gemspec
Successfully built RubyGem
Name: vhx
Version: 0.0.0
File: vhx-0.0.0.gem

$ gem install vhx-0.0.0.gem
Successfully installed vhx-0.0.0
1 gem installed

$ irb
irb(main)> require 'vhx'
```

#### Running Specs

```shell
rspec .
```

### Documentation

Documentation is available at http://dev.vhx.tv/docs/api/ruby.
Full API reference is available at http://dev.vhx.tv/docs/api?ruby.

## Getting Started

Before requesting your first resource, you must setup an instance of the Vhx Client:

```ruby
vhx = Vhx.setup({ api_key: 'your VHX API key' })
```

Here's an example of creating a Vhx resource with payload options. You can handle errors by rescuing Vhx::VhxError.

```ruby
begin
  # Example Customer Create
  customer = Vhx::Customer.create({
    email: 'customer@email.com',
    name: 'First Last',
    subscription: 'https://api.vhx.tv/subscriptions/1'
  })
rescue Vhx::VhxError
  # Handle error
end
```

### Resources & methods

 customers
  * [`create`](http://dev.vhx.tv/docs/api?ruby#create_customer)
  * [`update`](http://dev.vhx.tv/docs/api?ruby#update_customer)
  * [`retrieve`](http://dev.vhx.tv/docs/api?ruby#retrieve_customer)
  * [`list`](http://dev.vhx.tv/docs/api?ruby#list_customers)

authorizations
  * [`create`](http://dev.vhx.tv/docs/api?ruby#create_authorization)

videos
  * [`create`](http://dev.vhx.tv/docs/api?ruby#create_customer)
  * [`update`](http://dev.vhx.tv/docs/api?ruby#update_customer)
  * [`retrieve`](http://dev.vhx.tv/docs/api?ruby#retrieve_customer)
  * [`list`](http://dev.vhx.tv/docs/api?ruby#list_customers)

collections
  * [`create`](http://dev.vhx.tv/docs/api?ruby#create_collection)
  * [`update`](http://dev.vhx.tv/docs/api?ruby#update_collection)
  * [`retrieve`](http://dev.vhx.tv/docs/api?ruby#retrieve_collection)
  * [`list`](http://dev.vhx.tv/docs/api?ruby#list_collections)
  * [`items`](http://dev.vhx.tv/docs/api?ruby#list_collection_items)

analytics
  * [`report`](http://dev.vhx.tv/docs/api/?ruby#analytics)
