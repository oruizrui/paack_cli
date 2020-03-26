require 'spec_helper'

describe Weather::Summary do
  subject { described_class.run!(params) }

  let(:params) { FactoryBot.create(:data) }
  let(:expected_data) { FactoryBot.create(:cooked_data) }

  context 'success' do
    it 'expected response' do
      expect(subject).to be_truthy
      expect(subject).to match(expected_data)
    end
  end
end
