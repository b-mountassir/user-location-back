class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
    build_resource(sign_up_params)
    yield resource if block_given?
    if resource.save
      if resource.active_for_authentication?
        render json: {
          "data" => {
            "id" => resource.id.to_str,
            "email" => resource.email
          },
            "accessToken" => resource.generate_jwt
        }
      end
    else
      render json: { message: 'Email is taken or invalid' }, status: :unprocessable_entity
    end

  end
end