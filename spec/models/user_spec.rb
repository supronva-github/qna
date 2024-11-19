require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:owner_answers).class_name('Answer').with_foreign_key(:author_id) }
  it { should have_many(:owner_questions).class_name('Question').with_foreign_key(:author_id) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  describe '#author_of?' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:question) { create(:question, author: user) }

    context 'when the current user is the author' do
      it 'returns true' do
        expect(user).to be_author_of(question)
      end
    end

    context 'when the current user is not the author' do
      it 'returns false' do
        expect(user).to be_author_of(question)
      end
    end
  end
end
