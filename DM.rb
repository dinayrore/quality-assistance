# unique option parser Direct Mail Class
require 'pry'

class DM
  def initialize(options)
    pg = options.list[1]
    pdf = options.list[2]
    txt = options.list[3][/\/*.xlsx/]
    binding.pry
  end

  def find_records(file, text)
    pdf = PDF::Reader.new(file)
    pdf_records = []
    pdf.pages.each do |page|
      pdf_records <<  page.text.gsub("\n", "").upcase
    end
    txt_records = File.readlines(text)
    record_num = 0
    find_txt_record(txt_records, pdf_records, record_num)
  end

end
