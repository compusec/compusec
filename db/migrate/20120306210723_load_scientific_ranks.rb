require "active_record/fixtures"
class LoadScientificRanks < ActiveRecord::Migration
  def self.up
    down
    directory = File.join(File.dirname(__FILE__), "data")
    ActiveRecord::Fixtures.create_fixtures(directory, "scientific_ranks")
  end

  def self.down
    ScientificRank.delete_all
  end
end


