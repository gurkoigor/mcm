class AddDateOfTripToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :date_of_trip, :datetime, :default => Time.now
    remove_column :users, :active
  end

  def self.down
    remove_column :users, :date_of_trip
    add_column :users, :active, :boolean, :default => false
  end
end
