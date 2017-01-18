Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => { registrations: 'registrations' }

  root to: "profiles#index"
  resources :template_skill
  resources :profiles do
    post "update_profile/:template_skill_id" => 'profiles#update_profile'
    get 'search', on: :collection
    get 'show_all', on: :collection
    post 'update_like'
  end
  resources :skills
end
