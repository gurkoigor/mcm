module Admin::TariffsHelper

  def mobile_tariff_options(operator)
    options = Tariff.where(:tariff_type => Tariff::MOBILE_CONNECTION, :title => operator).order("tariff_type, title, value").
      map{|t| [t.value, t.id]}
    options.insert(0, ["Не выбран", ""])
  end

end
