class Chair < ActiveRecord::Base
  belongs_to :faculty

  validates :name, :presence => true,
                 :uniqueness => true,
                 :length => { :maximum => 50 }
end