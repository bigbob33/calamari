require 'spec_helper'

RSpec.describe Calamari::Client do
  let(:domain) { 'https://example.calamari.io' }
  let(:api_key) { 'SOME_KEY' }
  let(:api_user) { 'SOME_USER' }

  describe '.new' do
    subject { described_class.new(domain: domain, api_key: api_key, api_user: api_user) }

    it { expect { subject }.not_to raise_error }
  end

  context 'instance methods' do
    let(:client) { described_class.new(domain: domain, api_key: api_key, api_user: api_user) }

    describe '#absence_requests_find' do
      before do
        allow(described_class).to receive(:post).and_return(double(:httparty_response, parsed_response: []))
      end

      subject { client.absence_requests_find }

      it { expect(subject.count).to eq 0 }
    end
  end
end