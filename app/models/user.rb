class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :owner_answers, class_name: 'Answer', foreign_key: :author_id
  has_many :owner_questions, class_name: 'Question', foreign_key: :author_id
  has_many :badges, foreign_key: :winner_id

  def author_of?(obj)
    self.id == obj.author_id
  end
end
