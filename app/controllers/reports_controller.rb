# frozen_string_literal: true

class ReportsController < ApplicationController
  REPORT_TYPES = { 'About the amount of deposits for a period of time' => '1',
                   'Average, maximum and minimum amount of transfers' => '2',
                   'The sum of all accounts at the current time' => '3' }.freeze
  def create
    redirect_to report_path(REPORT_TYPES[report_params[:report]])
  end

  def new
    @report_types = REPORT_TYPES
  end

  def show
    @type = params[:format]
    @data = ReportCreator.call(@type)
  end

  private

  def report_params
    params.require(:report).permit(%i[report])
  end
end
