# == Schema Information
#
# Table name: sites
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  url         :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Site < ActiveRecord::Base

  has_many :links
  attr_accessible :description, :name, :url
end
