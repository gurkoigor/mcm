class CreateTariffs < ActiveRecord::Migration
  def self.up
    create_table :tariffs do |t|
      t.string :tariff_type
      t.string :title
      t.integer :value
      t.timestamps
    end
  end

  def self.down
    drop_table :tariffs
  end
end
