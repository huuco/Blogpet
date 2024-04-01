require "csv"
class Exports::SupportExportService
  HEADERES = {
    "blog" => ["Id", "User_id", "Title", "Description", "Min_read", "Viewer", "Status", "Created_at", "Updated_at"],
    "product" =>  ["Id", "Name", "Description", "Price", "Created_at", "Updated_at"],
    "user" => ["Id", "Email", "Username", "Created_at", "Updated_at"] 
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
      puts "Time elapsed #{Time.zone.now - beginning} seconds"
    end
  end

  def to_csv_row item
    case object
    when "product"
      [item.id, item.name, item.description, item.price, item.created_at, item.updated_at]
    when "user"
      [item.id, item.email, item.username, item.created_at, item.updated_at]
    when "blog"
      [item.id, item.user_id, item.description, item.min_read, item.status, item.created_at, item.updated_at]
    end
  end
end