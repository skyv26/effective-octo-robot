class AddAvatarUrlToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :avatar_url, :string
  end
end
