class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :password_hash
      t.integer :access_level

      t.timestamps
    end
  end
end
