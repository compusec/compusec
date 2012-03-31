class CreateScientificRanks < ActiveRecord::Migration
  def self.up
    create_table :scientific_ranks do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :scientific_ranks
  end
end
