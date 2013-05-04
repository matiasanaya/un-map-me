class CreateHags < ActiveRecord::Migration
  def change
    create_table :hags do |t|
      t.float :value
      t.integer :user_id
      t.integer :product_id

      t.timestamps
    end
  end
end
