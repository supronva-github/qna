module Voted
  extend ActiveSupport::Concern

  included do
    before_action :set_resource, only: %i[like dislike]
  end

  def like
    @votable.vote_up(current_user)
    render json: { message: "Vote successful", rating: @votable.rating }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def dislike
    @votable.vote_down(current_user)
    render json: { message: "Vote successful", rating: @votable.rating }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def model_klass
    controller_name.classify.constantize
  end

  def set_resource
    @votable = model_klass.find_by(id: params[:id])
  end
end
