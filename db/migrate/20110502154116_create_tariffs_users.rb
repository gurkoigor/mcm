class CreateTariffsUsers < ActiveRecord::Migration
  def self.up
    create_table :tariffs_users do |t|
      t.integer :user_id
      t.integer :tariff_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tariffs_users
  end
end
