require 'bundler'
Bundler.setup

require 'rake'
require 'active_record'

Dir["./tasks/*.rake"].sort.each { |ext| load ext }


namespace :demo do
  desc "populate database"
  task :populate_db => :environment do
    require './lib/constituency_search'
    search = ConstituencySearch.new
    search.populate_constituencies
  end
end
