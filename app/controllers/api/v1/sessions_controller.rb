class Api::V1::SessionsController < Devise::SessionsController
  def create
    user = User.find_by(email: sign_in_params[:email])

    if user && user.valid_password?(sign_in_params[:password])
      render json: {
        "data" => {"email" => user.email},
        "accessToken" => user.generate_jwt
      }
    else
      render json: { message: 'Email or password is invalid' }, status: :unprocessable_entity
    end
  end
end