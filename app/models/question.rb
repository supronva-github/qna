class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :best_answer, class_name: 'Answer', optional: true

  has_many_attached :files, dependent: :destroy

  validates :title, :body, presence: true
end
