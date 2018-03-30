# use pry for debugging
require 'pry'
require 'pdf-reader'
require 'optparse'
require 'colorize'

def parse_options
  ARGV << '-h' if ARGV.empty?
  options = {}
  OptionParser.new do |opts|
    opts.banner = 'How to: ruby dm_automation.rb [options]'

    opts.on('-t', '--txt text_file_name') do |text_file_name|
      options[:text] = text_file_name
    end

    opts.on('-f', '--file file_name') do |file_name|
      options[:file] = file_name
    end

    opts.on('-h', '--help') do
      puts opts
      exit
    end
  end.parse!

  options
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

def find_txt_record(txt_records, pdf_records, record_num)
  txt_records.each do |record|
    txt_records.map{ |line| line.strip! }
    recipient = txt_records[txt_records.index{|record| record.include?('addr_line1')}][/"(.+)\"/].gsub(/\"/, '').upcase # "CURRENT RESIDENT"
    address = txt_records[txt_records.index{|record| record.include?('address')}][/"(.+)\"/].gsub(/\"/, '').upcase
    city = txt_records[txt_records.index{|record| record.include?('city')}][/"(.+)\"/].gsub(/\"/, '').upcase
    state = txt_records[17][/"(.+)\"/].gsub(/\"/, '').upcase # may vary
    zipcode = txt_records[txt_records.index{|record| record.include?('zip')}][/"(.+)\"/].gsub(/\"/, '')
    txt_record = []
    txt_record << recipient << address << city << state << zipcode
    record_num += 1
    txt_records = txt_records[122..-1] # may vary  
    find_pdf_record(txt_record, txt_records, pdf_records, record_num)  
  end
end

def find_pdf_record(txt_record, txt_records, pdf_records, record_num)
  pdf_record = []
  recipient = txt_record[0] if pdf_records[0].include?(txt_record[0])
  address = txt_record[1] if pdf_records[0].include?(txt_record[1])
  city = txt_record[2] if pdf_records[0].include?(txt_record[2])
  state = txt_record[3] if pdf_records[0].include?(txt_record[3])
  zipcode = txt_record[4] if pdf_records[0].include?(txt_record[4])
  pdf_record << recipient << address << city << state << zipcode
  pdf_records = pdf_records[2..-1] # may vary
  compare_records(pdf_record, pdf_records, txt_record, record_num, txt_records) 
end

def compare_records(pdf_record, pdf_records, txt_record, record_num, txt_records)
  verify_recipient(txt_record, pdf_record,record_num)
  # verify_version()
  verify_record(txt_records, pdf_records, record_num)
end

def verify_recipient(txt_record, pdf_record, record_num)
  if txt_record[0] != (pdf_record[0])
    puts "Record # #{record_num}".red
    puts "Recipient #{txt_record[0]} does not match #{pdf_record[0]}".red
    puts ""
  end
  verify_address(txt_record, pdf_record, record_num)
end

def verify_address(txt_record, pdf_record, record_num)
  if txt_record[1] != pdf_record[1]
    puts "Record # #{record_num}".red if 
    puts "Address #{txt_record[1]} does not match #{pdf_record[1]}".red
    puts ""
  end
  verify_city(txt_record, pdf_record, record_num)
end

def verify_city(txt_record, pdf_record, record_num)
  if txt_record[2] != pdf_record[2]
    puts "Record # #{record_num}".red
    puts "City #{txt_record[2]} does not match #{pdf_record[2]}".red
    puts ""
  end
  verify_state(txt_record, pdf_record, record_num)
end

def verify_state(txt_record, pdf_record, record_num)
  if txt_record[3] != pdf_record[3]
    puts "Record # #{record_num}".red
    puts "State #{txt_record[3]} does not match #{pdf_record[3]}".red
    puts ""
  end
  verify_zipcode(txt_record, pdf_record, record_num)
end

def verify_zipcode(txt_record, pdf_record, record_num)
  if txt_record[4] === pdf_record[4]
    puts "Record # #{record_num}".green
    puts "Recipient Matched!".green
    puts "Address Matched!".green
    puts ""
  else
    puts "Record # #{record_num}".red
    puts "Zipcode #{txt_record[4]} does not match #{pdf_record[4]}".red
    puts ""
  end
end

# def verify_version
#   # Open spreadsheet from FILEPATH to get variables for testing
#   worksheet = Roo::Spreadsheet.open('Programming_Grid.xlsm')
#   # Set the worksheet you want to work with as the default worksheet.
#   worksheet.default_sheet = 'Mail_Imp_Grid'
#   # Create a hash of the headers so we can access columns by nameqwor
#   mv = { 10 => [ worksheet.g109, worksheet.g110, worksheet.g111, worksheet.g112,
#                  worksheet.g113, worksheet.g114, worksheet.g115, worksheet.g116,
#                  worksheet.g117, worksheet.g118, worksheet.g119, worksheet.g120,
#                  worksheet.g121, worksheet.g122, worksheet.g123, worksheet.g124 ],
#         11 => [ worksheet.h109, worksheet.h110, worksheet.h111, worksheet.h112, 
#               worksheet.h113, worksheet.h114, worksheet.h115, worksheet.h116 ] 
#         }
#   binding.pry
#   # Create version variables from spreadsheet for validation
#   MV10_AT = mv[10][0][/(?<==).*[^"]/]
#   MV10_KN = mv[10][1][/(?<==).*[^"]/]
#   MV10_MR = mv[10][2][/(?<==).*[^"]/]
#   MV10_VW = mv[10][3][/(?<==).*[^"]/]
#   MV10_XG = mv[10][4][/(?<==).*[^"]/]
#   MV10_NW = mv[10][5][/(?<==).*[^"]/]
#   MV10_UH = mv[10][6][/(?<==).*[^"]/]
#   MV10_PT = mv[10][7][/(?<==).*[^"]/]
#   MV10_WS = mv[10][8][/(?<==).*[^"]/]
#   MV10_PA = mv[10][9][/(?<==).*[^"]/]
#   MV10_PF = mv[10][10][/(?<==).*[^"]/]
#   MV10_JF = mv[10][11][/(?<==).*[^"]/]
#   MV10_J2 = mv[10][12][/(?<==).*[^"]/]
#   MV10_J3 = mv[10][13][/(?<==).*[^"]/]
#   MV10_W2 = mv[10][14][/(?<==).*[^"]/]
#   MV10_X2 = mv[10][15][/(?<==).*[^"]/]

#   recipient = txt_record[0] if pdf_records[0].include?(MV)
  

# end

def verify_record(txt_records, pdf_records, record_num)
  if record_num === 471  # change this number for total records in QA 
    puts "Test Complete.".blue
    exit
  else
    find_txt_record(txt_records, pdf_records, record_num)
  end
end

def main
  options = parse_options
  file = options[:file]
  text = options[:text]
  find_records(file, text)
end

main if __FILE__ == $PROGRAM_NAME

