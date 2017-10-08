class AddRemoteAvatarUrlToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :remote_avatar_url, :string
  end
end
