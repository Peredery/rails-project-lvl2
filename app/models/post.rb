# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  body        :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#  creator_id  :integer          not null
#
# Indexes
#
#  index_posts_on_category_id  (category_id)
#  index_posts_on_creator_id   (creator_id)
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#  creator_id   (creator_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :creator, class_name: "User", inverse_of: :posts
  belongs_to :category

  validates :title,
            :body,
            :creator,
            :category,
            presence: true

  validates_length_of :body, in: 200..4000, allow_blank: true
  validates_length_of :title, in: 5..255, allow_blank: true
end
