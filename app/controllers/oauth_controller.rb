class OauthController < ApplicationController

	def pull_redirect_url
    url = request.params[:platform_url]
    if request.env["REQUEST_URI"].include?("login-google")
    	# redirect_to "/auth/google_oauth2?state=#{url}"
    	redirect_to "/auth/google_oauth2?platform_url=#{url}"
    elsif request.env["REQUEST_URI"].include?("login-linkedin")
    	redirect_to "/auth/linkedin?platform_url=#{url}"
    elsif request.env["REQUEST_URI"].include?("login-facebook")
    	redirect_to "/auth/facebook?platform_url=#{url}"
    end
  end

  def identify_network_entry
  	url = request.env["omniauth.params"]["platform_url"]
    if request.env["omniauth.auth"]["info"]
      user = User.find_by(email: request.env["omniauth.auth"]["info"][:email])
      unless user
        auth_info = request.env["omniauth.auth"]
        user = User.create email: request.env["omniauth.auth"]["info"][:email], password: "password"
      end
      send_back_to_platform(url)
    end
  end

  def send_back_to_platform(destination)
    redirect_to "#{destination}"
  end

  def failure
    redirect_to request.env["omniauth.params"]["platform_url"]
  end

end
