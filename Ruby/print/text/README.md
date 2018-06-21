# Quality Assistance - Print QAs

Quality Assistance is your personal assistant to automating QAs! This series focuses on print projects, scraping text files and PDFs to compare like data that exists in each. Exact values are determined using REGEX and can be adjusted for use in any txt extension document.

Happy automating! 😃

## Getting Started

The instructions below will help you retrieve a copy of the project to run on your local machine through the Terminal application. Please see deployment for notes on how to deploy this project on your own system.  The instructions provided are for Mac users only, sorry PC.

### Prerequisites

You may need to install or update the following software.

Install rbenv & ruby-build - to install and compile different versions of Ruby code language
  1. Open up Terminal
  2. Run `brew install ruby-build rbenv`
  3. Run `echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile`

Install ruby 2.4.1
  1. Close and reopen Terminal. `rbenv install 2.4.1`
  2. After quite some time, run: `rbenv global 2.4.1`

### Deployment

Please complete the following procedure to run the program on a live system:
  1. Open Terminal.
  2. Change your directory to the one that which you would like to save this project. `$ cd folder_name`
  3. Then run the commands `$ git clone https://github.com/kteich88/quality-assistance.git` and `$ cd quality-assistance`
  4. Run `$ bundle install` to install needed gems located in the Gemfile.
  5. Type `$ ruby opt_parser.rb [options]` to run the program.

## Authors

* **Kristine Teichmann**
