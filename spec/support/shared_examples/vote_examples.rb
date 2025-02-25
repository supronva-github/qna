RSpec.shared_examples 'vote action' do |action, votable_type, value|
  let(:votable) { create(votable_type) }

  before { login(user) }

  context 'when you vote' do
    it 'creates a vote with the correct value and returns :ok' do
      expect { post action, params: { id: votable.id }, as: :json }
        .to change(Vote, :count).by(1)

      expect(response).to have_http_status(:ok)
      expect(Vote.last.value).to eq(value)
    end
  end

  context 'when the user has already voted' do
    let!(:vote) { create(:vote, user: user, votable: votable, value: value) }

    it 'removes the existing vote and returns :ok' do
      expect { post action, params: { id: votable.id }, as: :json }
        .to change(Vote, :count).by(-1)

      expect(response).to have_http_status(:ok)
    end
  end

  context 'when the user re-votes with the opposite value' do
    let!(:vote) { create(:vote, user: user, votable: votable, value: value == 1 ? -1 : 1) }

    it 'does not create a new vote and returns :ok' do
      expect { post action, params: { id: votable.id }, as: :json }
        .not_to change(Vote, :count)

      expect(response).to have_http_status(:ok)
      expect(Vote.last.value).to eq(value)
    end
  end

  context 'when an error occurs during voting' do
    before do
      allow_any_instance_of(votable_type.to_s.classify.constantize).to receive(:vote_up).and_raise(StandardError, 'Error')
      allow_any_instance_of(votable_type.to_s.classify.constantize).to receive(:vote_down).and_raise(StandardError, 'Error')
    end

    it 'returns :unprocessable_entity with an error message' do
      post action, params: { id: votable.id }, as: :json

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['error']).to eq('Error')
    end
  end
end
