class ImportsController < ApplicationController
  def index
  end

  def create
    if Imports::SupportImportService.new(params).perform
      flash[:notice] = "Import Success"
    else
      flash[:alert] = "Import Fail"
    end
    redirect_to imports_path
  end
end