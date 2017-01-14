Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "profile#index"
  resources :template_skill
  resources :profile do
    post "update_profile/:template_skill_id" => 'profile#update_profile'
  end
end
