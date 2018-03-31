# main file to run through QA options
require_relative 'qa'

def main
  options = QA.parse(ARGV)
  QA.start(options)
end

main if __FILE__ == $PROGRAM_NAME
