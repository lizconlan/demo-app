#encoding: utf-8

require 'active_record'

class SurveyResponse < ActiveRecord::Base
  belongs_to :constituency
  
  scope :non_voters, -> { where(intends_to_vote: false) }
  scope :voters, -> { where(intends_to_vote: true) }
  
  scope :con, -> { where(preferred_party: "con") }
  scope :lab, -> { where(preferred_party: "lab") }
  scope :lib, -> { where(preferred_party: "lib") }
  scope :other, -> { where(preferred_party: "other") }
end