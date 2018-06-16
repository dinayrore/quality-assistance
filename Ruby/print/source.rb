class Source
  def self.read_records(pdf_text)
    records = File.readlines(pdf_text)
    pdf_records = records.map{ |line| line.strip! }
  end

  def self.search_records(pdf_records, txt_record)
    pdf_record = Hash.new
    index = 1
    until index == txt_record.length
      recipient = pdf_records[recipient_index = pdf_records.index{|record| record.include?(txt_record[index][0])}] # CURRENT
      binding.pry
      if pdf_records[recipient_index + 1] == txt_record[index][1]
        address = pdf_records[recipient_index + 1]
  	  else
	  	 address = nil
      end
      if pdf_records[recipient_index + 2][/^[^,]*/] == txt_record[index][2]
        city = pdf_records[recipient_index + 2][/^[^,]*/]
      else
          city = nil
      end
      if pdf_records[recipient_index + 2][/[A-Z]{2}/] == txt_record[index][3]
        state = pdf_records[recipient_index + 2][/[A-Z]{2}/]
      else
        state = nil
      end
      if pdf_records[recipient_index + 2][/[0-9]{5}(-)[0-9]{4}|[0-9]{5}/] == txt_record[index][4]
        zipcode = pdf_records[recipient_index + 2][/[0-9]{5}(-)[0-9]{4}|[0-9]{5}/]
      else
        zipcode = nil
      end
      pdf_record[index] = [recipient, address, city, state, zipcode]
      index += 1
    end
    pdf_record
  end
end
