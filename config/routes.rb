Rails.application.routes.draw do
  
  devise_for :admins
  devise_for  :users,
              :path => '',
              :path_names => {:sign_in => 'sign-in', :sign_out => 'sign-out', :sign_up => 'register' },
              controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  #Custom routes used by devise
  #http://stackoverflow.com/questions/3827011/devise-custom-routes-and-login-pages
  
  #If the user is logged in
  authenticated :user do
    root to: 'dashboard#show', as: 'authenticated_root'
  end
  
  namespace 'admin' do
    resources :machines
  end
  
  root to: 'static#home'
  
  resources :model_names
  resources :makes
  resources :years
  resources :machines
  
  
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
