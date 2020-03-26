require 'spec_helper'

describe Weather::ApiCall do
  subject { described_class.run!(params) }

  let(:params) do
    {
        localidad: localidad
    }
  end
  let(:request_params) do
    {
        affiliate_id: affiliate_id,
        localidad: localidad,
        api_lang: 'es',
        v: '3.0'
    }
  end

  let(:localidad) { 1234 }
  let(:uri) { Weather::ApiCall::BASE_URI }
  let(:affiliate_id) { Weather::ApiCall::AFFILIATE_ID }
  let(:api_response) { FactoryBot.create(:api_response) }

  context 'success' do
    before do
      flexmock(Request).
          should_receive(:request).
          with(
              base_uri: uri,
              params: request_params
          ).
          and_return(api_response).
          once
    end

    it 'expected results' do
      expect(subject).to be_truthy
    end
  end
end
