Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do

    resources :departments do
      collection do
        get :existing_department
      end
    end

    resources :items do
      collection do
        get :existing_item
      end
    end

    resources :categories do
      collection do
        get :existing_category
      end
    end

  end
end




