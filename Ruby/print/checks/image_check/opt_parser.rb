# use pry for debugging
require 'pry'
require 'hexapdf'
require 'optparse'
require 'colorize'
require_relative 'directory'
require_relative 'source'

def parse_options
  ARGV << '-h' if ARGV.empty?
  options = {}
  OptionParser.new do |opts|
    opts.banner = 'How to: ruby opt_parser.rb [options]'

    opts.on('-t', '--txt text_file_name') do |text_file_name|
      options[:text] = text_file_name
    end

    opts.on('-p', '--proofs proof_directory') do |proof_directory|
      options[:proofs] = proof_directory
    end

    opts.on('-h', '--help') do
      puts opts
      exit
    end
  end.parse!

  options
end

def parse_text(text)
  img_records = Directory.read_records(text)
  img_directory = Directory.save_front(img_records)
  img_directory = Directory.save_back(img_records, img_directory)
end

def main
  options = parse_options
  img_directory = parse_text(options[:text])
  proof = Source.create_comparison(img_directory, options[:proofs])
end

main if __FILE__ == $PROGRAM_NAME
