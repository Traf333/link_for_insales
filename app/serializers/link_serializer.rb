class LinkSerializer < ActiveModel::Serializer
  attributes :id, :phrase, :image_url, :page_url

  has_many :products
end
