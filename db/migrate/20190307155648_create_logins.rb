class CreateLogins < ActiveRecord::Migration[5.2]
  def change
    create_table :logins do |t|
      t.string :access_token
      t.string :provider
      t.string :email
      t.string :uid
      t.timestamps
    end

    add_reference :logins, :user, foreign_key: true
  end
end
