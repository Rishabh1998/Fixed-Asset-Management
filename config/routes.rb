Rails.application.routes.draw do
  root'admin/departments#new'
  get 'sign_up' => 'admin/departments#sign_up'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    get "departments/new_release" => 'project#new_release', :as => :new_release

    resources :departments do
      collection do
        get :existing_department
        get :filter
      end
    end

    resources :items do
      collection do
        get :existing_item
        #always write all the methods of a controller together
        put :location
      end
    end

    resources :categories do
      collection do
        get :existing_category
      end
    end
  #  get 'departments', to: "department#index", as: :departments


end

end




