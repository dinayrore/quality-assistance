# unique option parser QA Class
require 'optparse'
require 'ostruct'
require 'pry'

class QA

  def self.parse(args)
    # Return a structure describing QA options.
    ARGV << '-h' if ARGV.empty?

    # The options specified in CLI will be collected in *options*.
    # Set default option values here.
    options = Hash.new

    opt_parser = OptionParser.new do |opts|
      opts.banner = "How to: quality_assistance.rb [options]"

      opts.separator ""
      opts.separator "QA options:"

      # Optional arguments & multi-line descriptions
      opts.on('-e', '--email FILEPATH', 'Analyze Email QA') do |email|
        options[:email] = email
      end

      opts.on('-d', '--direct mail FILEPATH',
              'Analyze Direct Mail QA',
              ' (PDF text & images)') do |dm|
        options[:direct_mail] = dm
      end

      opts.separator ""
      opts.separator "Common options:"

      opts.on("-h", "--help", "Prints help options") do
        puts opts
        exit
      end

    end

    opt_parser.parse!(args)
    options
  end

  def self.start(options)
    binding.pry
  end

end
