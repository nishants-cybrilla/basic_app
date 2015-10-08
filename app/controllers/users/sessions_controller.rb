include UrlHelper
require 'openssl'
require 'base64'

class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end

  def sso
    # authenticate
    self.resource = warden.authenticate(auth_options)
    resource_name = self.resource_name
    sign_in(resource_name, resource) if resource
    if user_signed_in?
      # redirect to forum
      sig = params[:sig]
      sso = params[:sso]
      if OpenSSL::HMAC.hexdigest('sha256', 'yoursupersecurepassword', sso) == sig
        nonce = Base64.decode64(sso)
        sso = Base64.encode64(nonce + '&username=' + resource.name + '&email=' + resource.email + '&external_id=' + resource.id.to_s)
        sig = OpenSSL::HMAC.hexdigest('sha256', 'yoursupersecurepassword', sso)
        return_params = { sso: sso, sig: sig }
        redirect_to generate_url( 'http://localhost:4040/t/welcome-to-discourse/8', return_params )
      end
    else
      redirect_to root_path, alert: t('.sign_in')
    end
  end
end
