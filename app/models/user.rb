class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true
    attribute :role, :integer
    enum role: { user: 0, admin: 1 }
    attribute :status, :integer
    enum status: { pending: 0, accepted: 1,rejected: 2}

    def self.ransackable_attributes(auth_object = nil)
        column_names - ['encrypted_password', 'password_reset_token', 'owner']
      end
      def user?
        role == 'user'
      end
      def accepted?
        status == 'accepted'
      end
end

