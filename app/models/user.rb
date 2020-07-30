class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_one_attached :avatar
  has_person_name

  has_many :notifications, foreign_key: :recipient_id
  has_many :services
  has_many :channel_users, dependent: :destroy
  has_many :channels, through: :channel_users
  has_many :messages, dependent: :destroy

  def self.online
    ids = ActionCable.server.pubsub.redis_connection_for_subscriptions.smembers 'online'
    where(id: ids)
  end

  def online?
    ActionCable.server.pubsub.redis_connection_for_subscriptions.sismember 'online', id
  end
end
