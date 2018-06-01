# unique option parser QA Class
require 'optparse'
require 'ostruct'
require 'pry'
require_relative 'DM'

class QA

  def self.parse(args)
    # Return a structure describing QA options.
    ARGV << '-h' if ARGV.empty?

    # The options specified in CLI will be collected in *options*.
    # Set default option values here.
    options = OpenStruct.new

    opt_parser = OptionParser.new do |opts|
      opts.banner = "How to: quality_assistance.rb [options]"

      opts.separator ""
      opts.separator "Define QA type and required files:"

      # List of arguments.
      opts.on("--email TYPE,FILEPATH,FILEPATH,FILEPATH", Array,
              "A 'list' of arguments",
              "  (TYPE = Email)",
              "  (FILEPATH 'pg.xlsx', '/*.eml', 'QA.csv' )") do |list|
        options.list = list
      end

      # List of arguments.
      opts.on("--dm TYPE,FILEPATH,FILEPATH,FILEPATH", Array,
              "A 'list' of arguments",
              "  (TYPE = DM)",
              "  (FILEPATH 'pg.xlsx', '*.pdf', '*.txt')") do |list|
        options.list = list
      end


      opts.separator ""

      opts.on("-h", "--help", "Prints options menu") do
        puts opts
        exit
      end

    end

    opt_parser.parse!(args)
    options
  end

  def self.start(options)
    Email.new(options) if options.qa == "email"
    binding.pry
    DM.new(options) if options.list[0].include?("dm")
  end

end
