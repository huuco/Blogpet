require 'csv'
class Imports::SupportImportService
  BATCH_SIZE = 1000
  def initialize params
    @params = params
  end

  def perform
    products = []
    csv = CSV.foreach(params[:file].path, encoding: "UTF-8", headers: true) rescue Array.new
    executed_time do
      ActiveRecord::Base.transaction do
        csv.each_slice(BATCH_SIZE).with_index do |row, index|
          Rails.logger.info "Batch index: #{index}"
          
          row.each{|item| products.push(item.to_h)} 
          
          Rails.logger.info "products: #{products}"
          
          Product.import! products.select{|product_attr| product_attr.compact.present? }
          
          products.clear
        end
        Rails.logger.info "Import Success "
        true
      rescue ActiveRecord::UnknownAttributeError, ActiveRecord::RecordInvalid
        false
      end
    end
  end

  private
  attr_reader :params

  def executed_time
    beginning = Time.zone.now
    begin
      yield
    ensure
      puts "Time elapsed #{Time.zone.now - beginning} seconds"
    end
  end
end