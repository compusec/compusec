class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :password
      t.boolean :activated
      t.boolean :banned
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.references :sex
      t.references :chair
      t.references :military_rank
      t.references :scientific_rank
      t.references :post
      t.string :phone
      t.string :room

      t.timestamps
    end
    add_index :users, :sex_id
    add_index :users, :chair_id
    add_index :users, :military_rank_id
    add_index :users, :scientific_rank_id
    add_index :users, :post_id
  end

  def self.down
    drop_table :users
  end
end
