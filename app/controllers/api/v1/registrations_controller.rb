class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
    build_resource(sign_up_params)
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        render json: {
          "data" => {"email" => resource.email},
            "accessToken" => resource.generate_jwt
        }
      end
    end

  end
end