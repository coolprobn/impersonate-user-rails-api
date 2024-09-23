class ApplicationController < ActionController::API
  include Pundit

  respond_to :json

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :permission_denied
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  impersonates :user

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
  end

  private

  def current_user
    return @current_user if @current_user

    return unless request.headers["Authorization"]

    begin
      _, jwt_token = request.headers["Authorization"].split(" ")
      jwt_payload =
        JWT.decode(
          jwt_token,
          Rails.application.credentials.devise_jwt_secret_key!
        ).first

      logged_in_user =
        User.includes(:impersonating_user).find(jwt_payload["sub"])
      impersonating_user = logged_in_user.impersonating_user

      @current_users = impersonating_user || logged_in_user
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      head :unauthorized
    end
  end

  def permission_denied
    head(:forbidden)
  end

  def record_not_found
    head(:not_found)
  end
end
