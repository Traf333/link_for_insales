class Link < ActiveRecord::Base
  belongs_to :site
  has_many :products, dependent: :destroy
  attr_accessible :category, :description, :image_url, :page_url, :phrase, :product_url, :site_id


  def self.import(file, site_id)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      link = find_by_id(row["id"]) || new
      link.attributes = row.to_hash.slice(*accessible_attributes)
      link.site_id = site_id
      link.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path, {})
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
