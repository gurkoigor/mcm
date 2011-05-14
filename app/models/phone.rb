class Phone < ActiveRecord::Base
  belongs_to :user
  validates_numericality_of :number, :only_integer => true
end
