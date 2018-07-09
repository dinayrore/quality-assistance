# use pry for debugging
require 'pry'
require 'yomu'
require 'optparse'
require 'colorize'
require_relative 'directory'
require_relative 'source'
require_relative 'validation'

def parse_options
  ARGV << '-h' if ARGV.empty?
  options = {}
  OptionParser.new do |opts|
    opts.banner = 'How to: ruby opt_parser.rb [options]'

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
  yomu = Yomu.new(file)
	  	begin
        File.write file + '.txt', yomu.text.upcase
	  	rescue
	  		puts 'Failed to convert'
	  		puts ''
	  	end
    pdf_to_txt = file + '.txt'
end

def parse_text(text)
  txt_records = Directory.read_records(text)
  txt_record = Directory.save_first_names(txt_records)
  txt_record = Directory.save_last_names(txt_records,txt_record)
  txt_record = Directory.save_addresses(txt_records, txt_record)
  txt_record = Directory.save_cities(txt_records, txt_record)
  txt_record = Directory.save_states(txt_records, txt_record)
  txt_record = Directory.save_zipcodes(txt_records, txt_record)
end


def parse_pdf_text(pdf_to_txt, txt_record)
  pdf_records = Source.read_records(pdf_to_txt)
  pdf_record = Source.search_records(pdf_records, txt_record)
end

def main
  options = parse_options
  txt_record = parse_text(options[:text])
  pdf_to_txt = parse_pdf(options[:file])
  pdf_record = parse_pdf_text(pdf_to_txt, txt_record)
  Validation.compare_records(txt_record, pdf_record)
end

main if __FILE__ == $PROGRAM_NAME
