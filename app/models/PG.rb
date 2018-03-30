require 'roo'

class PG
  def initialize
    @workbook = Roo::Spreadsheet.open("#{ENV["HOME"]}/Desktop/QA/Programming_Grid.xlsx")
    # if current_page?(email_requirements_path)
    #   @mvs =
    # else
    #   @mvs =
    # end
    #
    # @mvs.
  end
end
