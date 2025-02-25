module Voted
  extend ActiveSupport::Concern

  included do
    before_action :set_resource, only: %i[like dislike]
  end

  def like
    result = @votable.vote_up(current_user)

    if result == :removed
      render json: { message: "Like removed" }, status: :ok
    else
      render json: { message: "Vote successful", result: result }, status: :ok
    end
  end

  def dislike
    result = @votable.vote_down(current_user)

    if result == :removed
      render json: { message: "Dislike removed" }, status: :ok
    else
      render json: { message: "Vote successful", result: result }, status: :ok
    end
  end

  private

  def model_klass
    controller_name.classify.constantize
  end

  def set_resource
    @votable = model_klass.find_by(id: params[:id])
  end
end
