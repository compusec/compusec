class CreateMilitaryRanks < ActiveRecord::Migration
  def self.up
    create_table :military_ranks do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :military_ranks
  end
end
