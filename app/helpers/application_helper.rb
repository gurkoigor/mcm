module ApplicationHelper

  def navigation_menu
    id_proc = Proc.new do |controller_classes|
      controller_classes = [controller_classes] unless controller_classes.is_a?(Array)
      'selected' if controller_classes.include? controller.class
    end

    result = ""
    result << "<ul>"
    if current_user.admin?
      result << "<li>#{link_to "Пользователи", admin_users_path,
        :class => "#{id_proc.call(Admin::UsersController)}"}</li>"
      result << "<li>#{link_to "Тарифы", admin_tariffs_path,
        :class => "#{id_proc.call(Admin::TariffsController)}"}</li>"
    end
    result << "</ul>"
    result
  end

  def generate_rendom_id
    Digest::SHA1.hexdigest(Time.now.to_f.to_s)
  end

end

