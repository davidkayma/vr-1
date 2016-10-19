class Explanation < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson

  has_many :lesson_explanations
  has_many :lessons, through: :lesson_explanations

  serialize :tags
end
