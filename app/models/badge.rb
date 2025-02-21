class Badge < ApplicationRecord
  belongs_to :winner, class_name: 'User', optional: true
  belongs_to :question

  has_one_attached :image, dependent: :destroy

  def assign_to_winner(user)
    update!(winner: user)
  end
end
