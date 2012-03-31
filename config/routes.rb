Compusec::Application.routes.draw do

  match 'project/restart' => 'project#restart'

  root :to => 'user/login#login'
  scope :module => "user" do
    match 'register' => 'register#step1'
    match 'register/step2' => 'register#step2'
    match 'register/step3' => 'register#step3'
    match 'register/step4' => 'register#step4'
    match 'register/update_chair_select/:id' => 'register#update_chair_select'
    match 'register/validate_uniqueness_email' => 'register#validate_uniqueness_email'

    match 'login/login' => 'login#login'
    match 'login/logout' => 'login#logout'
  end

  scope :module => "pages" do
    match 'admin' => 'admin#index'
    match 'home' => 'home#index'
  end

  scope :module => "admin" do
    match 'user/index' => 'user#index'
    match 'user/new' => 'user#new'
    match 'user/:id' => 'user#show'
    match 'user/:id/destroy' => 'user#destroy'
    match 'user/:id/edit' => 'user#edit'
    match 'user/:id/activate' => 'user#activate'

    match 'faculty/index' => 'faculty#index'
    match 'faculty/new' => 'faculty#new'
    match 'faculty/:id' => 'faculty#show'
    match 'faculty/:id/destroy' => 'faculty#destroy'
    match 'faculty/:id/edit' => 'faculty#edit'

    match 'chair/index' => 'chair#index'
    match 'chair/new' => 'chair#new'
    match 'chair/:id' => 'chair#show'
    match 'chair/:id/destroy' => 'chair#destroy'
    match 'chair/:id/edit' => 'chair#edit'

    match 'dictonary/index' => 'dictonary#index'

    namespace :dictonary do
      match 'sex/index' => 'sex#index'
      match 'sex/new' => 'sex#new'
      match 'sex/:id/destroy' => 'sex#destroy'
      match 'sex/:id/edit' => 'sex#edit'

      match 'military_rank/index' => 'military_rank#index'
      match 'military_rank/new' => 'military_rank#new'
      match 'military_rank/destroy' => 'military_rank#destroy'
      match 'military_rank/edit/:id' => 'military_rank#edit'

      match 'scientific_rank/index' => 'scientific_rank#index'
      match 'scientific_rank/new' => 'scientific_rank#new'
      match 'scientific_rank/destroy' => 'scientific_rank#destroy'
      match 'scientific_rank/edit/:id' => 'scientific_rank#edit'

      match 'post/index' => 'post#index'
      match 'post/new' => 'post#new'
      match 'post/destroy' => 'post#destroy'
      match 'post/edit/:id' => 'post#edit'
    end
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
