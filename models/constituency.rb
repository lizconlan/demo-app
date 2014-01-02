#encoding: utf-8

require 'active_record'

class Constituency < ActiveRecord::Base
  has_many :survey_responses
end