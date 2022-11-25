class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json
  def create
    user = User.find_by(email: sign_in_params[:email])

    if user && user.valid_password?(sign_in_params[:password])
      render json: {
                     "data" => {
                         "id" => user.id.to_str,
                         "email" => user.email,
                         "created_at" => user.created_at
                     },
                     "accessToken" => user.generate_jwt
                   }

    else
      render json: { message: 'Email or password is invalid' }, status: :unprocessable_entity
    end
  end
end