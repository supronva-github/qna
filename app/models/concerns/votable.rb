module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def vote_up(user)
    toggle_vote(user, 1)
  end

  def vote_down(user)
    toggle_vote(user, -1)
  end

  def rating
    votes.sum(:value)
  end

  private

  def toggle_vote(user, value)
    existing_vote = votes.find_by(user: user)

    if existing_vote
      return :removed if existing_vote.value == value && existing_vote.destroy

      existing_vote.update(value: value)
    else
      existing_vote = votes.create(user: user, value: value)
    end

    existing_vote
  end
end
