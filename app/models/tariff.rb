class Tariff < ActiveRecord::Base
  has_many :tariffs_users, :dependent => :destroy
  has_many :users, :through => :tariffs_users

  validates :value, :presence => true
  validates :tariff_type, :presence => true
  validates :title, :presence => true
  validates_numericality_of :value, :only_integer => true, :greater_than => 0
end
