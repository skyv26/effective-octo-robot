class User < ApplicationRecord
  ROLES = %w[admin doctor receptionist superadmin].freeze  # Add 'superadmin' here

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, inclusion: { in: ROLES }
  before_create :set_user_code

  # Role checking methods
  def superadmin?
    role == 'superadmin'
  end

  def admin?
    role == 'admin'
  end

  def receptionist?
    role == 'receptionist'
  end

  def doctor?
    role == 'doctor'
  end

  private

  def set_user_code
    prefix = case role
             when 'admin' then 'AD'
             when 'doctor' then 'DT'
             when 'receptionist' then 'RP'
             when 'superadmin' then 'SA'  # Handle superadmin role code prefix
             else 'US'
             end

    timestamp = Time.zone.now.strftime('%Y%m%d%H%M%S')
    self.user_code = "#{prefix}-#{timestamp}-#{SecureRandom.hex(2).upcase}"
  end
end
