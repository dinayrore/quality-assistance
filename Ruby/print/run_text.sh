#!/bin/bash
yel=$'\e[1;33m'
cyn=$'\e[1;36m'
mag=$'\e[1;35m'
end=$'\e[0m'

printf "%s\n" "${yel}Begin text check...${end}"
ruby ./scripts/text_check/opt_parser.rb -t ./qa_files/*.txt -f ./qa_files/*.pdf

rm -rf proofs/*.pdf && rm -rf qa_files/*
