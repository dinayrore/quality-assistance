require 'roo'

class PG
  def initialize
    workbook = Roo::Spreadsheet.open("#{ENV["HOME"]}/Desktop/QA/Programming_Grid.xlsx")
    sheet = workbook.default_sheet = 'E-Mail Grid'
    version = workbook.parse(version: /V{1}e{1}r{1}s{1}i{1}o{1}n{1}/,
                         from: /F{1}r{1}o{1}m{1}/,
                         subject: /S{1}u{1}b{1}j{1}e{1}c{1}t{1}/,
                         header: /H{1}e{1}a{1}d{1}e{1}r{1}/,
                         address: /A{1}d{1}d{1}r{1}e{1}s{1}s{1}/)

    email = workbook.parse(description: /D{1}e{1}s{1}c{1}r{1}i{1}p{1}t{1}i{1}o{1}n{1}/,
                         filename: /F{1}i{1}l{1}e{1}n{1}a{1}m{1}e{1}/,
                         url: /U{1}R{1}L{1}/)

binding.pry
  end
end
