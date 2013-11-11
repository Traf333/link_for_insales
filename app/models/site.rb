class Site < ActiveRecord::Base

  has_many :links
  attr_accessible :description, :name, :url
end
