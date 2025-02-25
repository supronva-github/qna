RSpec.shared_examples 'vote action' do |action, votable_type, value|
  let(:votable) { create(votable_type) }

  before { login(user) }

  context 'when you vote' do
    it 'creates a vote with value 1 and returns :ok' do
      expect { post action, params: { id: votable.id }, as: :json }
        .to change(Vote, :count).by(1)

      expect(response).to have_http_status(:ok)
      expect(Vote.last.value).to eq(value)
    end
  end

  context 'when the user has already voted' do
    let!(:vote) { create(:vote, user: user, votable: votable) }

    it 'does not create a new vote and returns :unprocessable_entity' do
      expect { post action, params: { id: votable.id }, as: :json }
        .not_to change(Vote, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
