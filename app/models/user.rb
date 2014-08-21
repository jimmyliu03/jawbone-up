class User < ActiveRecord::Base
	#attr_accessor :token, :uid
	has_many :authorizations
	validates :uid, :presence => true

	def add_provider(auth_hash)
  # Check if the provider already exists, so we don't add it twice
  		unless self.authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
	    	Authorization.create :user_id => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"], :token => auth_hash["credentials"]["token"]
  		end
	end

end
