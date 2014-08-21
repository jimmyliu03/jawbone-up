class Authorization < ActiveRecord::Base

	belongs_to :user
	validates :provider, :uid, :token, :presence => true

	def self.find_or_create(auth_hash)
  		unless auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    		user = User.create :uid => auth_hash["uid"]
    		auth = create :user => user, :provider => auth_hash["provider"], :uid => auth_hash["uid"], :token => auth_hash["credentials"]["token"]
  		end 

  		auth
	end

end
