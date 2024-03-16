class ApplicationController < ActionController::API
  respond_to :json

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
  end

  private

  def current_user
    return @current_user if @current_user

    return unless request.headers['Authorization']

    begin
      _, jwt_token = request.headers['Authorization'].split(' ')
      jwt_payload = JWT.decode(jwt_token, Rails.application.secrets.secret_key_base).first

      @current_user = User.find(jwt_payload['sub'])
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      head :unauthorized
    end
  end
end
