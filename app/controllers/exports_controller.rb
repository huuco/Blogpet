class ExportsController < ApplicationController
  def index
  end

  def create
    respond_to do |format|
      format.csv { send_data Exports::SupportExportService.new(params[:object]).perform,
        filename: file_name }
    end
  end

  private

  def file_name
    "#{params[:object].capitalize}#{Time.zone.now.strftime('%Y%m%d')}.csv"
  end
end