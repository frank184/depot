class User < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_secure_password

  after_destroy :admin_exists?

  private

    def admin_exists?
      raise "Cannot delete last administrator" if User.count.zero?
    end

end
