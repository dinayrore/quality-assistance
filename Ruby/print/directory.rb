class Directory
  def self.read_records(text)
    records = File.readlines(text)
    txt_records = records.map{ |line| line.strip! }
  end

  def self.save_first_names(txt_records)
    txt_record = Hash.new
    record_num = 1
    first_names = txt_records.select{|record| record.match(/^first =/)} # Current
    first_names.each do |first|
      txt_record[record_num] = [first[/"(.+)\"/].gsub(/\"/, '')]
      break if record_num == first_names.length
      record_num += 1
    end
    txt_record
  end

  def self.save_last_names(txt_records, txt_record)
    record_num = 1
    last_names = txt_records.select{|record| record.match(/^last =/)} # Resident
    last_names.each do |last|
      txt_record[record_num][0] = txt_record[record_num][0] + ' ' + last[/"(.+)\"/].gsub(/\"/, '')
      break if record_num == last_names.length
      record_num += 1
    end
    txt_record
  end

  def self.save_addresses(txt_records, txt_record)
    record_num = 1
    addresses = txt_records.select{|record| record.match(/^address =/)}
    addresses.each do |address|
      txt_record[record_num][1] = address[/"(.+)\"/].gsub(/\"/, '')
      break if record_num == addresses.length
      record_num += 1
    end
    txt_record
  end

  def self.save_cities(txt_records, txt_record)
    record_num = 1
    cities = txt_records.select{|record| record.match(/^city =/)}
    cities.each do |city|
      txt_record[record_num][2] = city[/"(.+)\"/].gsub(/\"/, '')
      break if record_num == cities.length
      record_num += 1
    end
    txt_record
  end

  def self.save_states(txt_records, txt_record)
    record_num = 1
    states = txt_records.select{|record| record.match(/^st =/)}
    states.each do |state|
      txt_record[record_num][3] = state[/"(.+)\"/].gsub(/\"/, '')
      break if record_num == states.length
      record_num += 1
    end
    txt_record
  end

  def self.save_zipcodes(txt_records, txt_record)
    record_num = 1
    zipcodes = txt_records.select{|record| record.match(/^zip =/)}
    zipcodes.each do |zipcode|
      txt_record[record_num][4] = zipcode[/"(.+)\"/].gsub(/\"/, '')
      break if record_num == zipcodes.length
      record_num += 1
    end
    txt_record
  end
end
