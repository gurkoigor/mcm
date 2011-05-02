class Tariff < ActiveRecord::Base
  has_many :tariffs_users, :dependent => :destroy
  has_many :users, :through => :tariffs_users

  validates :value, :presence => true
  validates :tariff_type, :presence => true
  validates :title, :presence => true
  validates_numericality_of :value, :only_integer => true, :greater_than => 0

  MOBILE_CONNECTION = "Мобильная связь"
  KYIVSTAR = "Kyivstar"
  LIFE = "Life"

  scope :mobile_tariff, where(:tariff_type => MOBILE_CONNECTION)
  scope :mobile_kyivstar_tariff, where(:tariff_type => MOBILE_CONNECTION, :title => KYIVSTAR)
  scope :mobile_life_tariff, where(:tariff_type => MOBILE_CONNECTION, :title => LIFE)
end
