Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :facebook, Rails.application.credentials[:omniauth][:facebook][:id], Rails.application.credentials[:omniauth][:facebook][:key], secure_image_url: true
  
	on_failure { |env| OauthController.action(:failure).call(env) }
end
