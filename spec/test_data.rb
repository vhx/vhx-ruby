module TestData
  def test_credentials
    {
      client_id: "34ac1dec21fc20afd5099a2e6e0e62745dead7acd20c7b87320d8e5a7c5a33cc",
      client_secret: "6a04e2cf039db7ff57850f677fe0e419cdc132b3cc04aac9f3c2cd1c193a326d",
      oauth_token: {
        access_token:  "41d2ed8ead125347d38cf13dd7da8df0a32e9c9e839a9ea1b39c0d4f8b9caa92",
        refresh_token: "3483852aa88be2632faa47486fb8aa44d331aa301b696015338de7a6b5cb7025",
        expires_at: 1430773600,
        expires_in: 7200
      }
    }
  end

  def application_only_credentials
    {api_key: "-HyMMMvuWsXSezKvYFJ1N_1xRe9dymeh"}
  end

  def application_user_credentials
    {
      client_id: '7ed37300580e27f1acb5f16112e91aba43931d1e8e8c9829cc0fc36358f2cd44',
      client_secret: 'ce0fc20cad4cb74b4e5c30803446066b6d8556f413217a6a102aaab03372ac77',
      oauth_token: {
        access_token:  "5eb4f0d3f9e6ef8a3afdf7f3d8288d5067d626f1904b73b5695e4f65104be1c2",
        refresh_token: "132916e95bacc977a7890b31bf608e3d641d8a5c19b4ff4ffcf50e5b4273ed99",
        expires_at: 1430330123,
        expires_in: 7200
      }
    }
  end
end