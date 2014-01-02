class CreateSurveyResponses < ActiveRecord::Migration
  def self.up
    create_table :survey_responses, :force => true do |t|
      t.integer  :constituency_id
      t.boolean :intends_to_vote
      t.string  :preferred_party
    end
  end
  
  def self.down
    drop_table :survey_responses
  end
end