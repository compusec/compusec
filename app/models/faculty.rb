class Faculty < ActiveRecord::Base
  has_many :users
  has_many :chairs
  validates :name, :presence => true,
            :uniqueness => true,
            :length => { :maximum => 50 }
end