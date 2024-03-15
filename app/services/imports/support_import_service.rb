require 'csv'
class Imports::SupportImportService
  BATCH_SIZE = 1000
  def initialize params
    @params = params
  end

  def perform
    items = []
    products = []
    products_invalid = []
    line = 0
    csv = CSV.foreach(params[:file].path, encoding: "UTF-8", headers: true) rescue Array.new
    executed_time do
      ActiveRecord::Base.transaction do
        csv.each_slice(BATCH_SIZE).with_index do |row, index|
          Rails.logger.info "Batch index: #{index}"
          
          row.each do |element|
            line += 1
            items.push({"product": Product.new(element.to_h), "line": line})
          end

          items.each{|item| products_invalid << item[:line] unless item[:product].valid?}
          # Rails.logger.info "Line: #{products_invalid}"

          items.each{|item| products << item[:product]}
          # Rails.logger.info "-->#{products}"
          
          Product.import!(products)
          
          products.clear
          items.clear
        end
        Rails.logger.info "::Import Success "
        true
      rescue ActiveRecord::RecordInvalid => e
        Rails.logger.info "Error line: #{products_invalid}"
        Rails.logger.error "Error Import #{e.record.errors.messages}"
        false
      rescue ActiveRecord::RecordNotUnique, ActiveRecord::UnknownAttributeError, ArgumentError => e
        Rails.logger.error "Error Import #{e.inspect}"
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