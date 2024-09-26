require "csv"
class Exports::SupportExportService
  HEADERS = {
    "blog" => [
      "Id", "User_id", "Title", "Description", "Min_read", "Viewer",
      "Status", "Created_at", "Updated_at"
    ],
    "product" => [
      "Id", "Name", "Description", "Price", "Created_at", "Updated_at"
    ],
    "user" => [
      "Id", "Email", "Username", "Created_at", "Updated_at"
    ]
  }
  OBJECT_TYPES = {
    "product" => Product, 
    "user" => User, 
    "blog" => Blog
  }
  
  def initialize(object)
    @object = object
  end

  def perform
    executed_time do
      CSV.generate do |csv|
        csv << HEADERES[object]
        OBJECT_TYPES[object].order(created_at: :desc).each_slice(1000) do |items|
          items.each do |item|
            csv << to_csv_row(item)
          end
        end
      end
    end
  end

  private
  attr_reader :object

  def executed_time
    beginning = Time.zone.now
    
    begin
      yield
    ensure
      Rails.logger.info "Time elapsed #{Time.zone.now - beginning} seconds"
    end
  end

  def to_csv_row(item)
    HEADERS[object].map { |header| item.send(header.downcase) }
  end
end