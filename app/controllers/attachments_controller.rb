class AttachmentsController < ApplicationController
  before_action :authenticate_user!, only: %i[destroy]
  before_action :find_attachment, only: %i[destroy]

  def destroy
    if @attachment && current_user.author_of?(@attachment.record)
      @attachment.purge
    else
      render json: { error: 'Attachment not found' }, status: :not_found
    end
  end

  private

  def find_attachment
    @attachment = ActiveStorage::Attachment.find_by(id: params[:id])
  end
end
