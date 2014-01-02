#encoding: utf-8

require 'twfy'
require 'yaml'
require './models/constituency'

class ConstituencySearch
  POSTCODE = /^[A-Z]{1,2}[0-9]{1,2}[A-Z]? ?[0-9][A-Z]{2}$/i
  
  def initialize
    keys = YAML::load(File.open('config/keys.yml'))
    @client = Twfy::Client.new(keys[:twfy_key])
  end
  
  def find(search_string)
    if search_string =~ POSTCODE
      begin
        #Twfy::MP
        result = @client.constituency(postcode: search_string)
        return Constituency.where(name: text_to_utf8(result.name))
      rescue
        #should probably check that this isn't a service down message
      end
    end
    
    Constituency.where("name ILIKE ?", "%#{search_string}%").order(:name => :asc)
  end
  
  def populate_constituencies
    #error checking goes here, rushing
    mps = @client.mps
    
    mps.each do |mp|
      constituency = Constituency.find_or_create_by(name: text_to_utf8(mp.constituency.name))
      constituency.sitting_mp = text_to_utf8(mp.name)
      constituency.sitting_party = text_to_utf8(mp.party)
      constituency.save
    end
  end
  
  
  private
  
  def text_to_utf8(text)
    text.force_encoding("ISO-8859-1")
    text.encode("UTF-8")
  end
end