class Session < ApplicationRecord
    # attr_accessible :name, :oauth_expires_at, :oauth_tok, :provider, :uid
    has_one :user
end