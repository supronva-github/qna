module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def vote_up(user)
    votes.create(user: user, value: 1)
  end

  def vote_down(user)
    votes.create(user: user, value: -1)
  end
end
