Rails.application.routes.draw do

  resources :admin_users, :except => [:show]
  # resources :products, :only => [:index, :show]

=begin
  resources :subjects do
  
    member do
      get :delete # delete_subject_path(:id)
    end

    collection do
      get :export # export_subjects_path
    end

  end
=end


  resources :subjects do #Nested Resources
    member do
      get :delete
    end

    resources :pages do
      member do
        get :delete
      end

      resources :sections do
        member do
          get :delete
        end
      end
    end
  end

  root 'public#index'

  get 'show/:permalink', :to => 'public#show'

  get 'admin', :to => 'access#index'  
  
  match ':controller(/:action(/:id(.:format)))', :via => [:get, :post]

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
