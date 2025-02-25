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

    case existing_vote
    when nil
      create_vote(user, value)
    when Vote
      handle_existing_vote(existing_vote, value)
    end

    true
  end

  private

  def handle_existing_vote(vote, value)
    vote.value == value ? destroy_vote(vote) : update_vote(vote, value)
  end

  def destroy_vote(vote)
    vote.destroy!
  end

  def update_vote(vote, new_value)
    vote.update!(value: new_value)
  end

  def create_vote(user, value)
    votes.create!(user: user, value: value)
  end
end
