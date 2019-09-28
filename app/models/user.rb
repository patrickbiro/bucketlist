class User < ApplicationRecord
  has_many :comments
  has_many :ideas
  has_and_belongs_to_many :goals, class_name: 'Idea'
  has_secure_password
  before_validation :downcase_email
  validates :email, uniqueness: true, presence: true
  after_initialize :default_role!
  validates :role, inclusion: { in: %w(registered admin) }
  mount_uploader :avatar, AvatarUploader



  private

  def downcase_email
    self.email = email.downcase
  end

  def default_role!
    self.role ||= 'registered'
  end

end
