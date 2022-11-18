Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  scope :api, defaults: { format: :json } do
    scope :v1 do
      devise_for :users,
        controllers: {
          sessions: "api/v1/sessions",
          registrations: "api/v1/registrations",
        },
        path_names: {
          sign_in: :login,
          sign_up: :sign_up,
        }

      resource :user, only: [:show, :update]

      resources :answers, controller: 'api/v1/answers'
      resources :questions, controller: 'api/v1/questions'
    end
  end
end
