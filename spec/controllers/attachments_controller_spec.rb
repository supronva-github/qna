require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  describe 'DELETE #destroy' do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:question) { create(:question, :with_files, author: user) }
  let(:file) { question.files.first }

  subject { ->(file_id) { delete :destroy, params: { id: file_id }, format: :js } }

    context 'when the user is the author of the attachment' do
      before { login(user) }

      it 'deletes the attachment' do
        expect { subject.call(file.id) }.to change(question.files, :count).by(-1)
      end
    end

    context 'when the user is not the author of the attachment' do
      before { login(other_user) }

      it 'does not delete the attachment' do
        expect { subject.call(file.id) }.not_to change(question.files, :count)
      end
    end

    context 'when attachment does not exist' do
      before { login(user) }

      it 'returns not found status' do
        expect(subject.call(100)).to have_http_status(:not_found)
      end
    end
  end
end
