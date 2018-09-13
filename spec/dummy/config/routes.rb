Rails.application.routes.draw do
  mount ActiveCurrency::Engine => "/active_currency"
end
