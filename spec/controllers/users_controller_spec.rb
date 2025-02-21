require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:badges) { create_list(:badge, 3, winner: user, question: question) }

  before do
    login(user)
    get :badges
  end

  describe 'GET #badges' do

    it 'assigns @badges' do
      expect(assigns(:badges)).to match_array(badges)
    end

    it 'renders the badges template' do
      expect(response).to render_template(:badges)
    end
  end
end
