class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :content
      t.string :url

      t.timestamps
    end
  end
end
