Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "profiles#index"
  resources :template_skill
  resources :profiles do
    post "update_profile/:template_skill_id" => 'profiles#update_profile'
    get 'search', on: :collection
    post 'update_like'
  end
  resources :skills
end
