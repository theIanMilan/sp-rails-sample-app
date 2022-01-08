class Session < ApplicationRecord
  belongs_to :user
  TOKEN_LENGTH = 32
  TOKEN_LIFETIME = 1.day

  before_validation :generate_token, on: :create
  after_create :used

  def late?
    if (last_used_at + TOKEN_LIFETIME) >= Time.now
      false
    else
      update(status: false)
      true
    end
  end

  def used
    update(last_used_at: Time.now)
  end

  def close
    update(status: false)
  end

  def self.search(user_id, token)
    Session.find_by(user_id: user_id, status: true, token: token)
  end

  def generate_token
    self.status = true
    self.token = loop do
      random_token = SecureRandom.base58(TOKEN_LENGTH)
      break random_token unless Session.exists?(token: random_token)
    end
  end
end
