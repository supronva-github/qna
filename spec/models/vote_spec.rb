require 'rails_helper'

RSpec.describe Vote, type: :model do
  let!(:vote) { create(:vote) }

  it { should belong_to :votable }
  it { should belong_to :user }

  it { should validate_uniqueness_of(:user_id).scoped_to(:votable_type, :votable_id).with_message('can only vote once') }
  it { should validate_inclusion_of(:value).in_array([-1, 1]) }
end
