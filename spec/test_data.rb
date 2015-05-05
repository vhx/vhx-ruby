module TestData
  def test_credentials
    {
      client_id: "34ac1dec21fc20afd5099a2e6e0e62745dead7acd20c7b87320d8e5a7c5a33cc",
      client_secret: "6a04e2cf039db7ff57850f677fe0e419cdc132b3cc04aac9f3c2cd1c193a326d",
      oauth_token: {
        access_token:  "cc7d6c93bde201968f077b73acd5ee11a2768cbcb9b43122eb294004bf5b4480",
        refresh_token: "3b9aacbeb03d05e7b901c35580bcc45e6e714cd4921d8bc8699342632f68bd63",
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

  def unauthorized_user_credentials
    {
      client_id: 'unauthorized',
      client_secret: 'unauthorized',
      oauth_token: {
        access_token:  "unauthorized",
        refresh_token: "unauthorized",
        expires_at: 1430330123,
        expires_in: 1
      }
    }
  end

  def expired_credentials
    {
      client_id: "34ac1dec21fc20afd5099a2e6e0e62745dead7acd20c7b87320d8e5a7c5a33cc",
      client_secret: "6a04e2cf039db7ff57850f677fe0e419cdc132b3cc04aac9f3c2cd1c193a326d",
      oauth_token: {
        access_token:  "cc7d6c93bde201968f077b73acd5ee11a2768cbcb9b43122eb294004bf5b4480",
        refresh_token: "3b9aacbeb03d05e7b901c35580bcc45e6e714cd4921d8bc8699342632f68bd63",
        expires_in: 1
      }
    }
  end
end
