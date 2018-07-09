class Directory
  def self.read_records(text)
    records = File.readlines(text)
    img_records = records.map{ |line| line.strip! }
  end

  def self.save_front(img_records)
    img_directory = Hash.new
    record_num = 1
    front_side = img_records.select{|record| record.match(/^image_front =/)}
    front_side.each do |front|
      img_directory[record_num] = ['./proofs/' + front[/[^\\]+front.pdf/].downcase]
      break if record_num == front_side.length
      record_num += 1
    end
    img_directory
  end

  def self.save_back(img_records, img_directory)
    record_num = 1
    back_side = img_records.select{|record| record.match(/^image_back =/)}
    back_side.each do |back|
      img_directory[record_num][1] = './proofs/' + back[/[^\\]+back.pdf/].downcase
      break if record_num == back_side.length
      record_num += 1
    end
    img_directory
  end
end
