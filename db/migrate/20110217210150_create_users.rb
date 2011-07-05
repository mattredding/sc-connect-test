class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer   :soundcloud_user_id
      t.string    :soundcloud_username
      t.string    :soundcloud_access_token
      t.string    :soundcloud_refresh_token
      t.datetime  :soundcloud_expires_at
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
