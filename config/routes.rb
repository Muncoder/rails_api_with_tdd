Rails.application.routes.draw do
	resources :articles, only: [:index, :show]

	post 'login', to: 'access_tokens#create'
end
