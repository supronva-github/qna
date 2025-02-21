require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should belong_to :linkable}

  it { should validate_presence_of :name }
  it { should validate_presence_of :url }

  it { should allow_value('http://test.com').for(:url) }
  it { should allow_value('https://test.com').for(:url) }
  it { should_not allow_value('invalid_url').for(:url) }
  it { should_not allow_value('ftp://test.com').for(:url) }
end
