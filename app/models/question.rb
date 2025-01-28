class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :best_answer, class_name: 'Answer', optional: true

  has_one_attached :file

  validates :title, :body, presence: true
end
