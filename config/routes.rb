Rails.application.routes.draw do
  root 'application#show_html_builder'
  post '/', to: 'application#show_html_builder'
end
