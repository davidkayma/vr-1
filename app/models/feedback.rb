class Feedback < ApplicationRecord
  belongs_to :user, optional: true

  serialize :concept_review

  # has_many :performance_feedbacks, dependent: :destroy
  belongs_to :rehearsal

  after_initialize :set_defaults, :if => :new_record?
  def set_defaults
    self.refnum ||= "Fe-"+SecureRandom.hex(n=3)
  end
end
