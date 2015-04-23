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

To obtain an access token, you will need the [Oauth2 Gem](https://github.com/intridea/oauth2), a VHX client id, and VHX client secret. Once you have these credentials, instantiate a OAuth client:

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
token = client.auth_code.get_token(code, redirect_uri: 'https://youapp.com/oauth2/callback', grant_type: 'client_credentials')

token         = token.token
refresh       = token.refresh_token
expires_at    = token.expires_at
```

###Make your first request

Now that you have either an api key or access_token you are ready to make your first request!

```ruby
credentials = {
  client_id: client_id,
  client_secret: client_secret,
  oauth_token: {
    access_token: token,
    refresh_token: refresh,
    expires_at: expires_at
  }
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
