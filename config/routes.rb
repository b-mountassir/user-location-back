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
          sign_out: :sign_out
        }

      resource :user, only: [:show, :update]

      get :questions, to: 'api/v1/questions#index'
      get 'questions/:id', to: 'api/v1/questions#show'
      put :questions, to: 'api/v1/questions#create_in_bulk'
      get 'answers/:question_id', to: 'api/v1/answers#index'
    end
  end
end
