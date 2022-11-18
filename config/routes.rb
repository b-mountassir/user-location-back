Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  scope :api, defaults: { format: :json } do
    scope :v1 do
      devise_for :users, controllers: { sessions: "api/v1/sessions" },
                 path_names: { sign_in: :login}

      resource :user, only: [:show, :update]
    end
  end
end
