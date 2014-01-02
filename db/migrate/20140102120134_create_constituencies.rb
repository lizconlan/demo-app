class CreateConstituencies < ActiveRecord::Migration
  def self.up
    create_table :constituencies, :force => true do |t|
      t.string  :name
      t.string  :sitting_mp
      t.string  :sitting_party
    end
  end
  
  def self.down
    drop_table :constituencies
  end
end