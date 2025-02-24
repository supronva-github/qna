module Voted
  extend ActiveSupport::Concern

  included do
    before_action :set_resource, only: %i[like]
  end

  def like
    result = @votable.vote_up(current_user)

    if result.persisted?
      render json: result, status: :ok
    else
      render json: result.errors.full_messages, status: :unprocessable_entity
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
