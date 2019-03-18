Rails.application.config.middleware.use OmniAuth::Builder do
  provider :shibboleth, {
    :uid_field                 => 'eduPersonPrincipalName',
    :info_fields => {
      :email    => 'eduPersonPrincipalName'
    }
  }
end

OmniAuth.config.logger = Rails.logger