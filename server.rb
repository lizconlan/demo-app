require './lib/constituency_search'
require "./models/survey_response"
require "sinatra/flash"

enable :sessions
set :session_secret, ENV["session_secret"] || "secret string"

helpers do
  def percentage(number, total)
    if total < 1
      0
    else
      (number.to_f / total.to_f * 100.00).round
    end
  end
end

before do
  env = ENV["RACK_ENV"] ? ENV["RACK_ENV"] : "development"
  config = YAML::load(File.open('config/database.yml'))
  ActiveRecord::Base.establish_connection(config[env])
end

get "/" do
  haml :index
end

get "/survey" do
  if Constituency.count < 1
    search = ConstituencySearch.new
    search.populate_constituencies
  end
  @constituencies = Constituency.all.order(:name => :asc)
  haml :survey
end

post "/survey" do
  unless params[:constituencySelect].empty?
    session[:constituency_id] = params[:constituencySelect]
    redirect "/question-2"
  else
    #no response :(
    if params[:constituencySearch].empty?
      flash.next["alert"] = "Please either select a constituency or enter a search term"
      @constituencies = Constituency.all.order(:name => :asc)
      haml :survey
    #search!
    else
      search = ConstituencySearch.new
      @results = search.find(params[:constituencySearch])
      if @results.empty?
        flash.now["alert"] = "Sorry, no results found for #{params[:constituencySearch]}"
        @constituencies = Constituency.all.order(:name => :asc)
        haml :survey
      else
        haml :search_results
      end
    end
  end
end

get "/accept-constituency/:id" do
  session[:constituency_id] = params[:id]
  redirect "/question-2"
end

get "/question-2" do
  haml :survey2
end

post "/question-2" do
  unless params[:intentOptions]
    flash.now["alert"] = "Please select an option"
    haml :survey2
  else
    if params[:intentOptions] == "no"
      session[:intent] = false
      store_options
      redirect "/thanks"
    else
      session[:intent] = true
      redirect "/question-3"
    end
  end
end

get "/question-3" do
  haml :survey3
end

post "/question-3" do
  unless params[:partyVote]
    flash.now["alert"] = "Please select an option"
    haml :survey3
  else
    session[:party] = params[:partyVote]
    store_options
    redirect "/thanks"
  end
end

get "/thanks" do
  haml :thanks
end

get "/results" do
  if Constituency.count < 1
    search = ConstituencySearch.new
    search.populate_constituencies
  end
  constituency_name = params[:constituency]
  begin
    @constituency = Constituency.where(name: constituency_name).first
  rescue
    @constituency = nil
  end
  @constituencies = Constituency.all.order(:name => :asc)
  haml :results
end

private

def store_options
  result = SurveyResponse.new
  result.constituency_id = session[:constituency_id]
  result.intends_to_vote = session[:intent]
  result.preferred_party = session[:party] if session[:party]
  result.save
  session.clear
end