require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  describe 'GET #new' do
    let(:question) { create (:question) }

    before { get :new, params: { question_id: question } }

    it "" do

    end

  end
end
