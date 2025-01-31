require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }
  it { should belong_to :author }
  it { should have_many :links }

  it { should accept_nested_attributes_for :links }

  it { should validate_presence_of :body }

  it { should have_many_attached(:files) }
end
