require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question, author: user) }
  let(:answer) { create(:answer, question: question, author: user) }
  let(:user) { create(:user) }
  let(:request_format) { :html }

  describe 'GET #new' do
    before { login(user) }
    before { get :new, params: { question_id: question, user_id: user} }

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #show' do
    it 'renders show view' do
      get :show, params: { id: answer }
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    let!(:answers) { create_list(:answer, 3, question: question, author: user ) }
    let(:valid_params) { attributes_for(:answer) }
    let(:invalid_params) { attributes_for(:answer, :invalid) }
    let(:request_format) { :js }

    before { login(user) }
    subject { post :create, params: { question_id: question, answer: answer_params, author_id: user }, format: request_format }

    context 'with valid attributes' do
      let(:answer_params) { valid_params }

      it 'saves a new answer in database' do
        expect { subject }.to change(Answer, :count).by(1)
      end

      it 'renders create template' do
        subject
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      let(:answer_params) { invalid_params }
      let(:request_format) { :js }

      it 'does not save the answer' do
        expect { subject }.to_not change(Answer, :count)
      end

      it 'renders create template ' do
        subject
        expect(response).to render_template :create
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer, question: question, author: user) }
    context 'when the user is the author of the answer' do
      before { login(user) }

      it 'deletes the answer' do
        expect { delete :destroy, params: { id: answer }, format: :js }.to change(Answer, :count).by(-1)
      end

      it 'redirects to the question show page with a success notice' do
        delete :destroy, params: { id: answer }, format: :js

        expect(response).to render_template :destroy
      end
    end

    context 'when the user is not the author of the answer' do
      let(:other_user) { create(:user) }

      before { login(other_user) }

      it 'does not delete the answer' do
        expect { delete :destroy,  params: { id: answer }, format: :js }.not_to change(Answer, :count)
      end
    end
  end

  describe 'PATCH #update' do
    before { login(user) }

    context 'with valid attributes' do
      it 'chahges answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'new body'} }, format: :js
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'renders update view' do
        patch :update, params: { id: answer, answer: { body: 'new body'} }, format: :js

        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      it 'does not chahges answer attributes' do
        expect do
          patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid ) }, format: :js
        end.to_not change(answer, :body)
      end

      it 'renders update view' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid ) }, format: :js

        expect(response).to render_template :update
      end
    end
  end
end
