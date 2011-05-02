module Admin::TariffsHelper

  def mobile_tariff_options(operator)
    options = Tariff.where(:tariff_type => "Мобильная связь", :title => operator).map{|t| [t.value, t.id]}
    options.insert(0, ["Не выбран", ""])
  end

end
