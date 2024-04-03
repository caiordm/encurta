class CreateUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :urls do |t|
      t.string :url_original
      t.string :url_hash

      t.timestamps
    end
  end
end
