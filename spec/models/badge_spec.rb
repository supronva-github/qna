require 'rails_helper'

RSpec.describe Badge, type: :model do
  it { should belong_to(:winner).optional }
  it { should belong_to :question }

  it { should have_one_attached :image }
end
