class LinkSerializer < ActiveModel::Serializer
  attributes :id, :phrase, :image_url, :page_url, :product_url

  #has_many :products
end
