Rails.application.routes.draw do
  root 'application#index'
  match 'sms' => 'sms#index', :via => %i[get post]
  match 'voice' => 'voice#index', :via => %i[get post]
  match 'insights' => 'insights#index', via: %i[get post]
  match 'webhooks/answer' => 'webhooks#answer', via: :post
  match 'webhooks/event' => 'webhooks#event', via: :post
end
