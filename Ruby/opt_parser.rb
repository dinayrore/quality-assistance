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

def parse_pdf(file)
  PDF::Reader.open(file) do |reader|
	  txt = reader.pages.map do |page|
	  	begin
	  		page.text
	  	rescue
	  		puts 'Failed to convert'
	  		puts ''
	  	end
	  end
	  File.write file + '.txt', txt.join("\n")
    dm = file + '.txt'
	end
end

def read_records(dm, text)
  txt_records = File.readlines(text)
  binding.pry
  pdf_records = File.readlines(dm)
  create_records(txt_records)
end

def create_records(txt_records)
  txt_records.map{ |line| line.strip! }
  binding.pry
  first_names = txt_records.select{|record| record.match(/^first =/)} # CURRENT
  last_names = txt_records.select{|record| record.match(/^last =/)} # RESIDENT
  addresses = txt_records.select{|record| record.match(/^address =/)}
  cities = txt_records.select{|record| record.match(/^city =/)}
  states = txt_records.select{|record| record.match(/^st =/)}
  zipcodes = txt_records.select{|record| record.match(/^zip =/)}
  save_txt_records(first_names, last_names, addresses, cities, states, zipcodes)
  # txt_record = create_txt_hash(txt_records)
  # pdf_record = create_pdf_hash(pdf_records, txt_record)
  # compare_records(txt_record, pdf_record)
end

# def create_txt_hash(txt_records)
#
#   txt_record_data = find_text_records(txt_records)
#   txt_record[record_num] = txt_record_data
# end

# def find_text_records(txt_records)
#
# end

def save_txt_records(first_names, last_names, addresses, cities, states, zipcodes)
  txt_record = Hash.new
  txt_record = save_first_name(txt_record, first_names)
  txt_record = save_last_name(txt_record, last_names)
  txt_record = save_addresses(txt_record, addresses)
  txt_record = save_cities(txt_record, cities)
  txt_record = save_states(txt_record, states)
  txt_record = save_zipcodes(txt_record, zipcodes)
end

def save_first_name(txt_record, first_names)
  record_num = 1
  first_names.each do |first|
    txt_record[record_num] = [first[/"(.+)\"/].gsub(/\"/, '').upcase]
    break if record_num == first_names.length
    record_num += 1
  end
  txt_record
end

def save_last_name(txt_record, last_names)
  record_num = 1
  last_names.each do |last|
    txt_record[record_num][0] = txt_record[record_num][0] + ' ' + last[/"(.+)\"/].gsub(/\"/, '').upcase
    break if record_num == last_names.length
    record_num += 1
  end
  txt_record
end

def save_addresses(txt_record, addresses)
  record_num = 1
  addresses.each do |address|
    txt_record[record_num][1] = address[/"(.+)\"/].gsub(/\"/, '').upcase
    break if record_num == addresses.length
    record_num += 1
  end
  txt_record
end

def save_cities(txt_record, cities)
  record_num = 1
  cities.each do |city|
    txt_record[record_num][2] = city[/"(.+)\"/].gsub(/\"/, '').upcase
    break if record_num == cities.length
    record_num += 1
  end
  txt_record
end

def save_states(txt_record, states)
  record_num = 1
  states.each do |state|
    txt_record[record_num][3] = state[/"(.+)\"/].gsub(/\"/, '').upcase
    break if record_num == states.length
    record_num += 1
  end
  txt_record
end

def save_zipcodes(txt_record, zipcodes)
  record_num = 1
  zipcodes.each do |zipcode|
    txt_record[record_num][4] = zipcode[/"(.+)\"/].gsub(/\"/, '')
    break if record_num == zipcodes.length
    record_num += 1
  end
  txt_record
  binding.pry
end

def create_pdf_hash(pdf_records, record_num, txt_record)
  pdf_record = Hash.new
  pdf_records.each do |record|
    pdf_records.map{ |line| line.strip! }
    pdf_record_data = find_pdf_record(pdf_records, txt_record)
    record_num += 1
    pdf_record[record_num] = pdf_record_data
  end
end

def compare_records(txt_record, pdf_record)
  if txt_record == pdf_record
    puts 'Test Complete.'.blue
    puts 'ALL RECORDS MATCH!'.green
    exit
  else
    verify_data(txt_record, pdf_record)
  end
end

def verify_data(txt_record, pdf_record)
  index += 1
  if txt_record[index] != pdf_record[index]
    verify_recipient(txt_record, index)
  else
    puts 'Test Complete.'.blue
    exit
  end
end

def verify_recipient(txt_record, index, pdf_record)
  if txt_record[index][0] != pdf_record[index][0]
    puts "Record # #{index}".red
    puts "Recipient #{txt_record[index][0]} does not match #{pdf_record[index][0]}".red
    puts ''
  else
    verify_address(txt_record, index, pdf_record)
  end
end

def verify_address(txt_record, index, pdf_record)
  if txt_record[index][1] != pdf_record[index][1]
    puts "Record # #{index}".red
    puts "Recipient #{txt_record[index][1]} does not match #{pdf_record[index][1]}".red
    puts ''
  else
    verify_address(txt_record, index, pdf_record)
  end
end

def verify_city(txt_record, index, pdf_record)
  if txt_record[index][2] != pdf_record[index][2]
    puts "Record # #{index}".red
    puts "Recipient #{txt_record[index][2]} does not match #{pdf_record[index][2]}".red
    puts ''
  else
    verify_state(txt_record, index, pdf_record)
  end
end

def verify_state(txt_record, index, pdf_record)
  if txt_record[index][3] != pdf_record[index][3]
    puts "Record # #{index}".red
    puts "Recipient #{txt_record[index][3]} does not match #{pdf_record[index][3]}".red
    puts ''
  else
    verify_zipcode(txt_record, index, pdf_record)
  end
end

def verify_zipcode(txt_record, index, pdf_record)
  if txt_record[index][4] != pdf_record[index][4]
    puts "Record # #{index}".red
    puts "Recipient #{txt_record[index][4]} does not match #{pdf_record[index][4]}".red
    puts ''
  else
    verify_data(txt_record, index, pdf_record)
  end
end

def main
  options = parse_options
  file = options[:file]
  text = options[:text]
  dm = parse_pdf(file)
  read_records(dm, text)
end

main if __FILE__ == $PROGRAM_NAME

# def main
#   # record_num prompt
#   # merge_variable prompt
#   options = parse_options
#   txt_record = List.new(options[:text])
#   pdf_record = DirectMail.new(options[:file])
#   compare_records(txt_record, pdf_record)
# end
