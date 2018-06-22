#!/bin/bash
yel=$'\e[1;33m'
cyn=$'\e[1;36m'
mag=$'\e[1;35m'
end=$'\e[0m'

rm -rf qa_files/*.pdf.txt

printf "%s\n" "${yel}Begin image check...${end}"
ruby ./scripts/image_check/opt_parser.rb -t ./qa_files/*.txt -p ./proofs

printf "%s\n" "${mag}If you have not recieved an error message, PDF proofs found!${end}"

printf "%s\n" "${yel}Begin creating diff.pdf...this may take awhile...${end}"
diff-pdf --output-diff=./output/diff.pdf ./output/source.pdf ./qa_files/*.pdf

printf "%s\n" "${mag}Please review output/diff.pdf${end}"
printf "%s\n" "${cyn}Differences are highlighted in bright blue.${end}"

rm -rf proofs/*.pdf && rm -rf qa_files/*

open ./output/diff.pdf
