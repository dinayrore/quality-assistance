# Quality Assistance - Print QAs

Quality Assistance is your personal assistant to automating QAs! This series focuses on print projects, scraping text files and PDFs to compare like data that exists in each. Exact values are determined using REGEX and can be adjusted for use in any txt extension document.

Happy automating! 😃

## Getting Started

The instructions below will help you retrieve a copy of this project to run on your local machine through the CLI. Please read through all prerequisites and deployment for notes on how to use this project.  The instructions provided are for Macbook users only. Sorry PC.

### Requirements

There are a few required documents you will need to include in this projects file tree prior to running the script.

  1. Notepad/.txt extension file - this file may include may characters and descriptors for your QA, however, it MUST include the following attributes in order for the REGEX in this code to pull the appropriate attributes. This file should be placed in the qa_files directory prior to test script execution.
    * address =
    * city =
    * first =
    * last =
    * st =
    * suffix =
    * zip =
    * addr_line1 =
    * addr_line3 =
    * image_front =
    * image_back =

See example record below:

```
----------------------------------------------------------------------
  Record #1
----------------------------------------------------------------------
    address = "123 Street Rd"
    city = "City"
    first = "FirstName"
    last = "LastName"
    st = "ST"
    suffix = "<not set>"
    <!-- suffix = "Jr." | suffix = "Sr." | suffix = "III" -->
    zip = "12345-6789"
    addr_line1 = "FirstName LastName"
    addr_line2 = "<not set>"
    addr_line3 = "City, ST 12345-1234"
    image_front = "image_front.pdf"
    image_back = "image_back.pdf"
```

  2. PDF - this is the final product with names, addresses, and images that match those set in your text file. This file should be placed in the qa_files directory prior to test script execution.

  3. Proofs - PDFs of the images used to create the final product PDF. All PDF proofs should be uploaded into the proofs folder prior to test script execution.


### Prerequisites

You may need to install or update the following software.

Find Terminal - to run program
  1. Open Finder. Finder is available in the Dock.
  2. Select Applications from the side bar menu.  Then unfold the Utilities folder.
  3. Double click on Terminal to initialize.

Install Homebrew - to store program files properly
  1. Open up Terminal.
  2. Run `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
  3. Run `brew doctor`

Install rbenv & ruby-build - to install and compile different versions of Ruby code language
  1. Open up Terminal
  2. Run `brew install ruby-build rbenv`
  3. Run `echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile`

Install ruby 2.4.1
  1. Close and reopen Terminal. `rbenv install 2.4.1`
  2. After quite some time, run: `rbenv global 2.4.1`

Install bundler
  1. Run `gem install bundle -g`

Install diff-pdf

  1. Install pre-requisite XQuartz
  2. Run `brew cask install xquartz`
  3. Run `brew install diff-pdf`

Once you have completed the above installation processes your system is ready to launch the program!

### Deployment

Please complete the following procedure to run the program on a live system:
  1. Open Terminal.
  2. Change your directory to the one that which you would like to save this project. `$ cd folder_name`
  3. Then run the commands `$ git clone https://github.com/kteich88/quality-assistance.git` and `$ cd quality-assistance/Ruby/print`

  **Note**
    * Please see requirements for full list of documents necessary prior to test execution.
    * Example documents are provided in the examples folder; however, currently, these examples error out on REGEX checks.

  4. Run `$ bundle install` to install required gems located in the Gemfile.
  5. Run `$ time sh ./scripts/run.sh` to run a fully automated print QA, or
     Run `$ time sh ./scripts/run_text.sh` to run a text only comparison, or
     Run `$ time sh ./scripts/run_image.sh` to run a image only comparison.
  6. Run `$ time sh ./scripts/run_text_current_resident.sh` or `$ time sh ./scripts/run_text_our_neighbor.sh` for QAs that omit resident names.
  7. If you know the size of your QA PDF file is large, try running the image and text scripts separately to optimize processing.

  **Note**
    * You may also need to set the following line in file ./checks/image_check/source.rb from `optimize: true` to `optimize: false` for larger QAs.


## Author

  * **Kristine Teichmann**


### Acknowledgements

  * **Alyssa Pratt - Pratt0923**
  * **Timothy Hsieh - timothyhsieh27**
