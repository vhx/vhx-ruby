#VHX Ruby Gem
The following are instructions for using the VHX Ruby Gem.

##References
* [VHX Api Documentation](http://dev.vhx.tv/docs/api/)
* [Oauth2 Ruby Gem](https://github.com/intridea/oauth2)

##Authentication

For application-only authentication, you will need an api key. Borrowing heavily from [Twitter's api](https://dev.twitter.com/oauth), "application-only authentication is a form of authentication where your application makes API requests on its own behalf, without a user context."

For application-user authentication, you will need an access token. Borrowing heavily from [Twitter's api](https://dev.twitter.com/oauth), "Your signed request both identifies your application’s identity in addition to the identity accompanying granted permissions of the end-user you’re making API calls on behalf of, represented by the user’s access token."

If you are looking to access your own data, then the application-only authentication is the way to go. If you are looking to access data on behalf of an end user of your app, then application-user authentication is for you.

###API Key (Application-only authentication)

To obtain an api key, please visit [TBD, but Kevin's PR](https://github.com/vhx/crystal/pull/1073)

###Access Token (Application-User Authentication)

The easiest way to obtain access credentials for an 'application-user' authentication flow is by using the [VHX OmniAuth Strategy](https://github.com/vhx/omniauth-vhx).

An alternative is to use the Oauth2 Gem directly, as described below:

Docs for [Oauth2 Gem](https://github.com/intridea/oauth2). You will also need your VHX client id, and VHX client secret. Once you have these credentials, instantiate a OAuth client:

```ruby
client_id     = '9ac56e0574439fd569fbb5a47986d6dffff01a790429cc2b46cbfdd5e47f59ee'
client_secret = '5fcddd236f9b9fce172a34af47805e426c3a66ecf36e4c558807edcc2d52a389'

client        = OAuth2::Client.new(client_id, client_secret, site: 'https://api.vhx.tv')
```

Then, you will need to generate an authorization url to redirect to. This authorization url will walk your end user through the authorization process with VHX:

```ruby
client.auth_code.authorize_url(redirect_uri: 'https://youapp.com/oauth2/callback')
```

Once your user has authenticatecd with VHX, they will be redirected to the uri that you provide, in this example (https://youapp.com/oauth2/callback). You will receive this incoming request, which will come with a code, in your app. From this point, you can use the Oauth Client to retreive a token to use with the VHX Gem.

```ruby
code  = params[:code]
token = client.auth_code.get_token(code, redirect_uri: 'https://youapp.com/oauth2/callback', grant_type: 'authorization_code')

access_token  = token.token
refresh       = token.refresh_token
expires_at    = token.expires_at
expires_in    = token.expires_in
```

####Important consideration for refresh tokens when using Application-User authentication.

By default, the vhx gem will automatically refresh your credentials if they have expired. Because credentials will change once refreshed, you will need to store these new credentials so that you do not receive an Unauthorized error the next time you create a client instance. One way to accomplish this is the following:

```ruby
vhx = Vhx.setup(current_user.credentials)
begin
  @packages = Vhx::User.me.packages
ensure
  current_user.credentials = vhx.client.credentials
  current_user.save
end
```

Alternatively, you can disable auto-refresh and instead manage the process by checking if the token has expired. To disable auto-refresh, pass in the following option when calling either `#config` or `#setup` on `Vhx`:

`Vhx.config(client_id: ENV['VHX_CLIENT_ID'], client_secret: ENV['VHX_CLIENT_SECRET'], skip_auto_refresh: true)`

OR

`Vhx.setup(credentials.merge(skip_auto_refresh: true))`

Now, you will have to manage refreshing the token manually like the following:

```ruby
if Vhx.client.expired?
  Vhx.client.refresh_access_token!
  current_user.credentials = vhx.client.credentials
  current_user.save
end

@packages = Vhx::User.me.packages
```

###Make your first request

Now that you have either an api key or access_token you are ready to make your first request!

```ruby
credentials = {
  client_id: client_id,
  client_secret: client_secret,
  access_token: access_token,
  refresh_token: refresh,
  expires_at: expires_at,
  expires_in: expires_in
}
```

OR

```ruby
credentials = {
  api_key: api_key
}
```

Instantiate the VHX Client:

```ruby
vhx = Vhx.setup(credentials)
```

Once your VHX Client is instantiated, you can make your first call:

```ruby
Vhx::User.me
```

Which will return an object like this:
```ruby
#<Vhx::User:0x007fcb5d10c130 @id=179232, @name="John Smith", @has_password=true, @thumbnail={"small"=>"https://secure.gravatar.com/avatar/b883c9efcd8ed81c7934586sca6a6a9.png?d=https://cdn.vhx.tv/assets/thumbnails/default-portrait-small.png&r=PG&s=100", "medium"=>"https://secure.gravatar.com/avatar/b883c9efcd8ed81c7934586sca6a6a9.png?d=https://cdn.vhx.tv/assets/thumbnails/default-portrait-medium.png&r=PG&s=200", "large"=>"https://secure.gravatar.com/avatar/b883c9efcd8ed81c7934586sca6a6a9.png?d=https://cdn.vhx.tv/assets/thumbnails/default-portrait-large.png&r=PG&s=300"}, @packages_count=13, @sites_count=1, @created_at="2013-08-19T19:27:30Z", @updated_at="2015-04-20T20:43:10Z">
```

You can call methods on this object to access it's attributes:

```ruby
user.packages_count
->13

user.name
->"John Smith"
```

You can also retrieve associations such as the following:

```ruby
user.sites

->[#<Vhx::Site:0x007fd0329921b8 @obj_hash={"_links"=>{"self"=>{"href"=>"http://api.vhx.tv/sites/10149"}, "home_page"=>{"href"=>"http://test.vhx.tv"}, "followers"=>{"href"=>"http://api.vhx.tv/sites/10149/followers"}}, "id"=>10149, "title"=>"test", "description"=>"", "domain"=>"test.vhx.tv", "subdomain"=>"test", "key"=>"test", "color"=>"#22B9B0", "facebook_url"=>nil, "twitter_name"=>nil, "google_analytics_id"=>"", "packages_count"=>0, "videos_count"=>0, "followers_count"=>0, "created_at"=>"2015-02-25T20:14:51Z", "updated_at"=>"2015-02-25T20:15:54Z"}, @id=10149, @title="test", @description="", @domain="test.vhx.tv", @subdomain="test", @key="test", @color="#22B9B0", @facebook_url=nil, @twitter_name=nil, @google_analytics_id="", @packages_count=0, @videos_count=0, @followers_count=0, @created_at="2015-02-25T20:14:51Z", @updated_at="2015-02-25T20:15:54Z">]
```

These association calls will default to fetching from embedded resources attached to the calling object. If the requested resources are not available, the gem will proceed to make a call to the Vhx Api to fetch those resources. Once resources are pulled the first time, they are cached; so all future calls to your object's association will not make additional requests.

You can also request individual or a collection of objects using the `#find` and `#all` methods, respectively, which are available to all resources.

Create Vhx Objects using the Vhx-Ruby Gem by using the `#create` method on any resources that allow `POST` requests. For example, here's creating a package to sell for your site:

```ruby
options = {
  title: "My New Package",
  description: "My package description.",
  price_cents: 500,
  custom_email_message: "Thank you for buying my movie!",
  is_preorder: true,
  site:"https://api.vhx.tv/sites/1"
}

Vhx::Package.create(options)
-> #<Vhx::Package:0x007f92c44825e8 @obj_hash={"_links"=>{"self"=>{"href"=>"http://api.crystal.dev/packages/6799"}, "site"=>{"href"=>"http://api.crystal.dev/sites/1900"}, "videos"=>{"href"=>"http://api.crystal.dev/packages/6799/videos"}, "buy_page"=>{"href"=>"http://sagartestmovie.crystal.dev/buy/my-new-package-2"}, "home_page"=>{"href"=>"http://sagartestmovie.crystal.dev/packages/my-new-package-2"}}, "_embedded"=>{"site"=>{"_links"=>{"self"=>{"href"=>"http://api.crystal.dev/sites/1900"}, "home_page"=>{"href"=>"http://sagartestmovie.crystal.dev"}, "followers"=>{"href"=>"http://api.crystal.dev/sites/1900/followers"}}, "id"=>1900, "title"=>"SagarTestMovie", "description"=>"This is my test movie. ", "domain"=>"sagartestmovie.crystal.dev", "subdomain"=>"sagartestmovie", "key"=>"sagartestmovie", "color"=>"#28DBF7", "facebook_url"=>nil, "twitter_name"=>nil, "google_analytics_id"=>"", "packages_count"=>8, "videos_count"=>3, "followers_count"=>35, "created_at"=>"2013-12-27T00:20:28Z", "updated_at"=>"2015-04-23T22:07:56Z"}, "videos"=>[], "trailer"=>nil}, "id"=>6799, "title"=>"My New Package", "description"=>"My package description.", "sku"=>"my-new-package-2", "price"=>{"cents"=>500, "currency"=>"USD", "formatted"=>"$5", "US"=>{"cents"=>500, "currency"=>"USD", "formatted"=>"$5"}}, "rental"=>nil, "trailer_url"=>nil, "trailer_embed_code"=>"<iframe src=\"http://embed.crystal.dev/packages/6799\" width=\"640\" height=\"360\" frameborder=\"0\" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>", "thumbnail"=>{"small"=>"http://cdn.crystal.dev/assets/thumbnails/default-small.png", "medium"=>"http://cdn.crystal.dev/assets/thumbnails/default-medium.png", "large"=>"http://cdn.crystal.dev/assets/thumbnails/default-large.png", "blurred"=>nil}, "is_active"=>true, "is_locked"=>false, "is_preorder"=>true, "release_date"=>nil, "videos_count"=>0, "extras_count"=>0, "created_at"=>"2015-04-23T22:07:56Z", "updated_at"=>"2015-04-23T22:07:56Z"}, @id=6799, @title="My New Package", @description="My package description.", @sku="my-new-package-2", @price={"cents"=>500, "currency"=>"USD", "formatted"=>"$5", "US"=>{"cents"=>500, "currency"=>"USD", "formatted"=>"$5"}}, @rental=nil, @trailer_url=nil, @trailer_embed_code="<iframe src=\"http://embed.crystal.dev/packages/6799\" width=\"640\" height=\"360\" frameborder=\"0\" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>", @thumbnail={"small"=>"http://cdn.crystal.dev/assets/thumbnails/default-small.png", "medium"=>"http://cdn.crystal.dev/assets/thumbnails/default-medium.png", "large"=>"http://cdn.crystal.dev/assets/thumbnails/default-large.png", "blurred"=>nil}, @is_active=true, @is_locked=false, @is_preorder=true, @release_date=nil, @videos_count=0, @extras_count=0, @created_at="2015-04-23T22:07:56Z", @updated_at="2015-04-23T22:07:56Z", @self=nil, @site=nil, @videos=nil, @buy_page=nil, @home_page=nil, @packages=nil, @sites=nil>
```
