#!/bin/bash

ruby ./text/opt_parser.rb -t [text_file_name.txt] -f [pdf_name.pdf]

ruby ./image/opt_parser.rb -t [text_file_name.txt] -p [pdf_proof_dir/]

diff-pdf --output-diff=diff.pdf source.pdf [example.pdf]
