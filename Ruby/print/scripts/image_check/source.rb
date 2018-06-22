class Source
  def self.create_comparison(img_directory, proofs)
    # downcase all file names in the proofs folder
    Dir.glob(proofs + "/*").each do |proof|
      File.rename(proof, proof.downcase)
    end
    proof = HexaPDF::Document.new
    img_directory.values.each do |value|
      value.each do |file|
        pdf = HexaPDF::Document.open(file)
        pdf.pages.each {|page| proof.pages << proof.import(page)}
      end
    end
    proof.write("./output/source.pdf", optimize: true)
  end
end
