require "active_record/fixtures"
  class LoadPosts < ActiveRecord::Migration
  def self.up
    down
    directory = File.join(File.dirname(__FILE__), "data")
    ActiveRecord::Fixtures.create_fixtures(directory, "posts")
  end

  def self.down
    Post.delete_all
  end
end


