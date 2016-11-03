class Lesson < ApplicationRecord
  belongs_to :instructor, class_name: 'User'
  belongs_to :topic

  has_many :topic_lessons
  has_many :topics, through: :topic_lessons

  has_many :lesson_explanations
  has_many :explanations, through: :lesson_explanations

  has_many :lesson_prompts
  has_many :prompts, :through => :lesson_prompts

  has_many :lesson_models
  has_many :models, :through => :lesson_models

  has_many :lesson_concepts
  has_many :concepts, through: :lesson_concepts

  has_many :lesson_rehearsals
  has_many :rehearsals, through: :lesson_rehearsals
end
