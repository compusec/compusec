class CreateLogs < ActiveRecord::Migration
  def self.up
    create_table :logs do |t|
      t.text :content
      t.references :user

      t.timestamps
    end
    add_index :logs, :user_id
  end

  def self.down
    drop_table :logs
  end
end
