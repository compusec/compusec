class Post < ActiveRecord::Base
  has_many :users
  validates :name, :presence => true,
            :uniqueness => true,
            :length => { :maximum => 50 }
end