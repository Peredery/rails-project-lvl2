# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy, foreign_key: 'creator_id', inverse_of: :creator
  has_many :comments, dependent: :destroy, class_name: 'PostComment', inverse_of: :user
  has_many :likes, dependent: :destroy, class_name: 'PostLike', inverse_of: :user
  has_many :deleted_entities, as: :deleted_entity, dependent: :destroy
  has_many :deleted_by, class_name: 'DeletedEntity', foreign_key: :deleted_by, inverse_of: :user, dependent: :destroy
end
