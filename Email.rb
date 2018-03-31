# unique option parser Direct Mail Class
require 'pry'

class Email
  def initialize(options)
    pg = options.list[1]
    eml = options.list[2]
    csv = options.list[3][/\/*.csv/]
    binding.pry
  end

end
