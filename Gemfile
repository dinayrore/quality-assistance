source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'
gem 'pry', '~> 0.10.3'
gem 'mail', '~> 2.6', '>= 2.6.4'
gem 'roo', '~> 2.7', '>= 2.7.1'
