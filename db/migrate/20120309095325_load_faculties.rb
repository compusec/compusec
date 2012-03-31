require "active_record/fixtures"
class LoadFaculties < ActiveRecord::Migration
  def self.up
    down
    directory = File.join(File.dirname(__FILE__), "data")
    ActiveRecord::Fixtures.create_fixtures(directory, "faculties")
  end

  def self.down
    Faculty.delete_all
  end
end


