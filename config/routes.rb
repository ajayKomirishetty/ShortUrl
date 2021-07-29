Rails.application.routes.draw do
	resources :urls
	root to: "urls#new"
	post '/',       :to => 'urls#create',   :as => :urls_create
	get '/:token/info/edit', :to => 'urls#edit',   :as => :urls_edit
	get '/:token', :to => 'urls#tiny_url', :as => :tiny_url
	get '/:token/info', :to => 'urls#url_info', :as => :url_info



	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
