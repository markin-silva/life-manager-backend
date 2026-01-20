# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :categories, dependent: :destroy
  has_many :transactions, dependent: :destroy
end
