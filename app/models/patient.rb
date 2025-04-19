class Patient < ApplicationRecord
    # Validations
    validates :name, :email, :phone, :blood_group, presence: true

    validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

    validates :phone, format: {
        with: /\A\+?[0-9\s\-\(\)]{10,}\z/,
        message: "must be a valid phone number"
    }

    validates :blood_group, inclusion: {
      in: %w[A+ A- B+ B- AB+ AB- O+ O-],
      message: "%{value} is not a valid blood group"
    }

    validates :avatar_url, allow_blank: true, format: {
      with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
      message: "must be a valid URL"
    }

    # Optional: could be stored in a text field
    validates :medical_history, length: { maximum: 2000 }
end
