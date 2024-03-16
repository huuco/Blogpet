require 'csv'
class Imports::SupportImportService
  BATCH_SIZE = 1000
  def initialize params
    @params = params
  end

  def perform
    return false unless valid_params?

    items = []
    objects = []
    objects_invalid = []
    line = 0
    object_type = params[:object]
    csv = CSV.foreach(params[:file].path, encoding: "UTF-8", headers: true) rescue Array.new
    executed_time do
      ActiveRecord::Base.transaction do
        csv.each_slice(BATCH_SIZE).with_index do |row, index|
          Rails.logger.info "Batch index: #{index}"
          
          row.each do |element|
            line += 1
            items.push(build_object(object_type, element, line))
          end

          items.each{|item| objects_invalid << item[:line] unless item[object_type.to_sym].valid?}
          # Rails.logger.info "Line: #{objects_invalid}"

          items.each{|item| objects << item[object_type.to_sym]}
          # Rails.logger.info "-->#{objects}"
          
          object_import object_type, objects
          
          objects.clear
          items.clear
        end
        Rails.logger.info "::Import Success "
        true
      rescue ActiveRecord::RecordInvalid => e
        Rails.logger.info "Error line: #{objects_invalid}"
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

  def build_object object_type, attributes, line
    {"#{object_type}": object_type.classify.safe_constantize.new(attributes.to_h), "line": line}
  end

  def object_import object_type, objects
    object_type.classify.safe_constantize.import! objects
  end

  def valid_params?
    params[:object] && params[:file] && params[:file].original_filename.include?(".csv")
  end
end