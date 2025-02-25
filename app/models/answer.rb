class Answer < ApplicationRecord
  include Votable

  belongs_to :question
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :links, dependent: :destroy, as: :linkable

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  has_many_attached :files, dependent: :destroy

  validates :body, presence: true

  scope :by_add, -> { order(created_at: :desc) }

  def mark_as_best
    transaction do
		  question.update(best_answer_id: self.id)
      question.badge&.assign_to_winner(self.author)
    end
	end

  def best?
    question&.best_answer_id == self.id
  end
end
