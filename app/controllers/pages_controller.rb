require 'roo'

class PagesController < ApplicationController
  attr_reader :workbook, :worksheets

  def worksheet
    @workbook = Roo::Spreadsheet.open("#{ENV["HOME"]}/Desktop/QA/Programming_Grid.xlsx")
    @worksheets = @workbook.sheets
  end
end
