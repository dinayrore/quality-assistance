#!/bin/bash
yel=$'\e[1;33m'
cyn=$'\e[1;36m'
mag=$'\e[1;35m'
red=$'\e[1;31m'
end=$'\e[0m'

printf "%s\n" "${yel}Begin text check...${end}"
ruby ./checks/text_check/opt_parser.rb -t ./qa_files/*.txt -f ./qa_files/*.pdf

rm -rf qa_files/*.pdf.txt

printf "%s\n" "${yel}Begin image check...this may take a moment...${end}"
printf "%s\n" "Pulling images from text record file to create proof PDF..."
ruby ./checks/image_check/opt_parser.rb -t ./qa_files/*.txt -p ./proofs

printf "%s\n" "${mag}If your terminal DID NOT explode with error messages, the PDF proofs were found and a source.pdf file was created.${end}"

printf "%s\n" "${yel}Begin creating diff.pdf...this may take awhile...${end}"
diff-pdf --output-diff=./output/diff.pdf ./output/source.pdf ./qa_files/*.pdf

rm -rf proofs/*.pdf && rm -rf qa_files/*

if [ -e ./output/diff.pdf ]
then
printf "%s\n" "Please review output/diff.pdf"
printf "%s\n" "Differences are highlighted in ${cyn}bright blue${end} and ${red} red${end}."
open ./output/diff.pdf
fi
