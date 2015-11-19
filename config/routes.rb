Rails.application.routes.draw do

  # This is for exposing the API needed by the client applications
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :subscription_lists
      resources :notifications
    end
  end

  resources "subscriptionlists", :controller => :subscription_lists, :as => :subscription_lists
  resources :enrollments do
    member do
      get 'enrollments_for_student'
    end
  end
  get 'student/index'
  #resources :students
  #get '/students/:id/enrollments', to: 'enrollments#index'
  resources :students do
    #member do
    #  get 'enrollments'
    resources :enrollments
    #end
    resources "subscriptionlists"
  end

  resources :notifications
  post 'notifications/send' => 'notifications#send'   #TODO delete after test

  get 'flat_student/index'

  get 'csv_importer' => 'csv_importer#index'
  post 'csv_importer/import_csv'

  #root to: 'csv_importer#index'

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
