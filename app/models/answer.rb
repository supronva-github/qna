class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  validates :body, presence: true

  scope :by_add, -> { order(created_at: :desc) }

  def mark_as_best
		question.update(best_answer_id: self.id)
	end

  def best?
    question&.best_answer_id == self.id
  end
end
