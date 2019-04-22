class User < ApplicationRecord
    # attr_accessible :name, :oauth_expires_at, :oauth_tok, :provider, :uid
    has_one :session
    has_one :applicant
    
    def self.from_omniauth(auth)
        where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
            user.email = auth.info.email
            user.provider = auth.provider
            user.uid = auth.uid
            user.name = auth.info.name
            user.oauth_tok = auth.credentials.token
            user.oauth_expires_at = Time.at(auth.credentials.expires_at)
            user.save!
        end
    end
end