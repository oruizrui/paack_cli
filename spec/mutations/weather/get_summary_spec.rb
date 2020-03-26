require 'spec_helper'

describe Weather::GetSummary do
  subject { described_class.run!(params) }

  let(:params) {  { localidad: localidad } }
  let(:localidad) { 1234 }
  let(:api_response) { FactoryBot.create(:api_response) }
  let(:body) { FactoryBot.create(:body) }
  let(:data) { FactoryBot.create(:data) }
  let(:cooked_data) { FactoryBot.create(:cooked_data) }

  context 'success' do
    before do
      flexmock(Weather::ApiCall).
          should_receive(:run!).
          with(params).
          and_return(api_response).
          once

      flexmock(Weather::ApiCallback).
          should_receive(:run!).
          with(api_response).
          and_return(body).
          once

      flexmock(Weather::PrepareData).
          should_receive(:run!).
          with(body).
          and_return(data).
          once

      flexmock(Weather::Summary).
          should_receive(:run!).
          with(data).
          and_return(cooked_data).
          once
    end

    it 'expected response' do
      expect(subject).to be_truthy
    end
  end
end
