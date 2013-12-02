# == Schema Information
#
# Table name: links
#
#  id          :integer          not null, primary key
#  phrase      :string(255)
#  page_url    :string(255)
#  image_url   :string(255)
#  category    :string(255)
#  product_url :string(255)
#  description :text
#  site_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
