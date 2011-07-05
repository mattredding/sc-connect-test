class User < ActiveRecord::Base
  # Sound Cloud Battle
  # http://soundcloud.com/you/apps/battle/edit
  # Client ID DeDNYH72GVOkmSU6gBtIDA
  # Client Secret TZmM0XbY5NCfNBwM1Qq5zV0KAP3SZDyex9WqXOsDGE
  # End User Authorization https://soundcloud.com/connect
  # Token https://api.soundcloud.com/oauth2/token

  SOUNDCLOUD_CLIENT_ID     = "DeDNYH72GVOkmSU6gBtIDA"
  SOUNDCLOUD_CLIENT_SECRET = "TZmM0XbY5NCfNBwM1Qq5zV0KAP3SZDyex9WqXOsDGE"

  def self.soundcloud_client(options={})
    options = {
      :client_id     => SOUNDCLOUD_CLIENT_ID,
      :client_secret => SOUNDCLOUD_CLIENT_SECRET,
    }.merge(options)

    Soundcloud.new(options)
  end
  
  
  def soundcloud_client(options={})
    options= {
      :expires_at    => soundcloud_expires_at,
      :access_token  => soundcloud_access_token,
      :refresh_token => soundcloud_refresh_token
    }.merge(options)
    
    client = self.class.soundcloud_client(options)
    
    # define a callback for successful token exchanges
    # this will make sure that new access_tokens are persisted once an existing 
    # access_token expired and a new one was retrieved from the soundcloud api
    client.on_exchange_token do
      self.update_attributes!({
        :soundcloud_access_token  => client.access_token,
        :soundcloud_refresh_token => client.refresh_token,
        :soundcloud_expires_at    => client.expires_at,
      })
    end
    
    client
  end
end
