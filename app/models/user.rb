  class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

    has_many :lists, dependent: :destroy
    has_many :tasks, through: :lists
    validates :username, :avatar, presence: true
  end
