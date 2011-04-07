require 'config/environment.rb'

desc "create root usersd"
namespace :db do
  task :create_root_users do
    user = User.find_by_email("gurko.igor@gmail.com")
    if user.nil?
      user = User.create!(:email => "gurko.igor@gmail.com", :first_name => "Igor", :last_name => "Gurko",
      :password => "123456", :password_confirmation => "123456", :parent_id => "0")
      user.active = true
      user.admin = true
      user.save
    end
  end
end

