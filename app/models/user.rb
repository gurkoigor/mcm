class User < ActiveRecord::Base

  has_many :tariffs_users, :dependent => :destroy
  has_many :tariffs, :through => :tariffs_users

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :tariff_ids
  attr_accessible :email, :password, :password_confirmation, :remember_me, :parent_id,
                  :full_name, :tariff_ids
  attr_protected :active, :admin

  validates :parent_id, :presence => true
  validates :full_name, :presence => true
  validates_numericality_of :parent_id, :greater_than => 0, :if => Proc.new { |user| !user.admin? }
  validates_numericality_of :parent_id, :only_integer => true

  acts_as_tree :order => "email", :dependent => false

  validate :parent_user
  validate :select_tariff_ids

  after_create :create_tariff

  COEF_CARD = {"1" => 5, "2" => 1, "3" => 1, "4" => 1, "5" => 1}
  COEF_BALANS = {"1" => 5, "2" => 1, "3" => 0.5, "4" => 0.25, "5" => 0.12}

  def update_without_current_password(params={})
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    params.delete(:current_password) if params[:current_password].blank?
    self.update_attributes(params)
  end

  def create_tariff
    tariffs_users.clear
    tariff_ids.uniq.each do |t|
      tariffs_users.create(:tariff_id => t)
    end
  end

  private

  def parent_user
    errors.add(:parent_id, "не найден") if User.find_by_id(self.parent_id).nil? &&
      !self.parent_id.nil? && !self.parent_id.zero? || self.parent_id == self.id
  end

  def select_tariff_ids
    self.tariff_ids = self.tariff_ids.split(',') if self.tariff_ids.is_a?(String)
    puts "===="
    puts self.tariff_ids.inspect
    errors.add(:tariff_ids, "должен быть выбран") if self.tariff_ids.reject{|value| value.blank? }.empty?
    errors.add(:tariff_ids, "не известен") if (Tariff.mobile_kyivstar_tariff.find_all_by_id(self.tariff_ids).count > 1) ||
      (Tariff.mobile_life_tariff.find_all_by_id(self.tariff_ids).count > 1)
  end


end

