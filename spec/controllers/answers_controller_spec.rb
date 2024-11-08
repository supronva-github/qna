require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'GET #new' do
    before { get :new, params: { question_id: question } }

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
    let!(:answers) { create_list(:answer, 3, question: question) }
    let(:valid_params) { attributes_for(:answer) }
    let(:invalid_params) { attributes_for(:answer, :invalid) }

    subject { post :create, params: { question_id: question, answer: answer_params } }

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
end
