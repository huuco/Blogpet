class ImportsController < ApplicationController
  def index
    # @form = Imports::SupportImportService.new(params).perform
    # @form = 
  end

  def create
    if allow_valid_file? && Imports::SupportImportService.new(params).perform
      flash[:notice] = "Import Success"
    else
      flash[:alert] = "Import Fail"
    end
    redirect_to imports_path
  end

  private

  def allow_valid_file?
    params[:file] && params[:file].content_type == "text/csv" && File.extname(params[:file].original_filename) == ".csv"
  end
end