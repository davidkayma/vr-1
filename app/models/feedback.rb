class Feedback < ApplicationRecord
  belongs_to :user, optional: true

  serialize :concept_review

  has_many :performance_feedbacks
  has_many :rehearsals, through: :performance_feedbacks
end
