require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question, author: user) }
  let(:answer) { create(:answer, question: question, author: user) }
  let(:user) { create(:user) }

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

    before { login(user) }
    subject { post :create, params: { question_id: question, answer: answer_params, author_id: user } }

    context 'with valid attributes' do
      let(:answer_params) { valid_params }

      it 'saves a new answer in database' do
        expect { subject }.to change(Answer, :count).by(1)
      end

      it 'redirects to show view' do
        subject
        expect(response).to redirect_to assigns(:answer)
      end
    end

    context 'with invalid attributes' do
      let(:answer_params) { invalid_params }

      it 'does not save the answer' do
        expect { subject }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        subject
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer, question: question, author: user) }
    context 'when the user is the author of the answer' do
      before { login(user) }

      it 'deletes the answer' do
        expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
      end

      it 'redirects to the question show page with a success notice' do
        delete :destroy, params: { id: answer }

        expect(response).to redirect_to question_path(question)
         expect(flash[:notice]).to eq 'Answer successfully deleted.'
      end
    end

    context 'when the user is not the author of the answer' do
      let(:other_user) { create(:user) }

      before { login(other_user) }

      it 'does not delete the answer' do
        expect { delete :destroy,  params: { id: answer } }.not_to change(Answer, :count)
      end

      it 'redirects to the question show page with an error notice' do
        delete :destroy, params: { id: answer }

        expect(response).to redirect_to question_path(question)
        expect(flash[:notice]).to eq 'Only author can delete answer.'
      end
    end
  end
end
