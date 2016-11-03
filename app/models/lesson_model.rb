class LessonModel < ApplicationRecord
  belongs_to :lesson
  belongs_to :model
  accepts_nested_attributes_for :lesson
end
