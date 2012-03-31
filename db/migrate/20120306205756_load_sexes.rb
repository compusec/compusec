require "active_record/fixtures"
class LoadSexes < ActiveRecord::Migration
  def self.up
    down
    directory = File.join(File.dirname(__FILE__), "data")
    ActiveRecord::Fixtures.create_fixtures(directory, "sexes")
  end

  def self.down
    Sex.delete_all
  end
end

