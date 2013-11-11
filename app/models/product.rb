class Product < ActiveRecord::Base
  belongs_to :link
  attr_accessible :url, :link_id
end
