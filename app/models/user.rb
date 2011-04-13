class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :parent_id,
    :first_name, :last_name
  attr_protected :active, :admin

  validates :parent_id, :presence => true

  acts_as_tree :order => "email"

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end

