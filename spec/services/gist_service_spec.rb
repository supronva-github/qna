require 'rails_helper'

RSpec.describe GistService do
  let(:gist_address) { 'https://gist.github.com/username/abcdef123456' }
  let(:client) { instance_double('GitHubClient') }
  let(:gist_service) { described_class.new(gist_address, client: client) }

  subject { gist_service.call }

  describe '#call' do
    it 'calls the client with the correct gist id and returns the expected result' do
      allow(client).to receive(:gist).with('abcdef123456').and_return('Gist details')

      expect(subject).to eq('Gist details')
      expect(client).to have_received(:gist).with('abcdef123456')
    end
  end
end
