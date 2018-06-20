class Source
  def self.read_records(pdf_text)
    records = File.readlines(pdf_text)
    pdf_records = records.map{ |line| line.strip! }
    # pdf_records = records.map{ |line| line.gsub(/\\xe2\\x80\\x99/, "'" ).gsub(/\\x0c/, ' ').gsub(/\\xc2\\xae/, ' ') }
  end

  def self.search_records(pdf_records, txt_record)
    index = 1
    pdf_record = Hash.new
    until index == txt_record.length
      recipient_index = pdf_records.index{|record| record.include?(txt_record[index][0])} if pdf_records.index{|record| record.include?(txt_record[index][0])}
      address_index = recipient_index + 1
      city_state_zip_index = recipient_index + 2
      recipient = pdf_records[recipient_index] # Current Resident
      if pdf_records[address_index].match?(/^(?:[Pp][Oo]\s[Bb][Oo][Xx]|[0-9]{1,}|[0-9]{1,}[A-Za-z])\s(?:[0-9A-Za-z\.'#]|[^\S\r\n])+/)
        address = pdf_records[address_index]
  	  else
	  	 address = nil
      end
      if pdf_records[city_state_zip_index].match?(/([A-Z]+\s?)+,\s[A-Z]{2}\s\d{5}-?\d{4}?/)
        city = pdf_records[city_state_zip_index][/^[^,]*/]
        state = pdf_records[city_state_zip_index][/,\s[A-Z]{2}/].gsub(/,\s/, '')
        zipcode = pdf_records[city_state_zip_index][/[0-9]{5}(-)[0-9]{4}|[0-9]{5}/]
      else
          city = state = zipcode = nil
      end
      pdf_record[index] = [recipient, address, city, state, zipcode]
      index += 1
    end
    pdf_record
  end
end
