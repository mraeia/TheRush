Rails.application.routes.draw do
  resources :rush_stats

  get '/rush_stats/all/search', controller: 'rush_stats', action: 'search'
  get '/rush_stats/download/csv',controller: 'rush_stats', action: 'download_csv'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
