module ApplicationHelper

  def navigation_menu
    id_proc = Proc.new do |controller_classes|
      controller_classes = [controller_classes] unless controller_classes.is_a?(Array)
      'selected' if controller_classes.include? controller.class
    end

    result = ""
    result << "<ul>"
    result << "<li>#{link_to "Пользователи", admin_users_path,
      :class => "#{id_proc.call(Admin::UsersController)}"}</li>" if current_user.admin?
    result << "</ul>"
    result
  end

end

