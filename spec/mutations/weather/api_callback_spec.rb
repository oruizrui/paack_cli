require 'spec_helper'

describe Weather::ApiCallback do
  subject { described_class.run!(params) }

  context 'success' do
    let(:params) { FactoryBot.create(:api_response) }

    shared_examples_for :expected_result do
      it 'must be truthy' do
        expect(subject).to be_truthy
      end
    end

    include_examples :expected_result

    it 'expected keys' do
      expect(subject.has_key?(:status)).to be_truthy
      expect(subject.has_key?(:location)).to be_truthy
      expect(subject.has_key?(:url)).to be_truthy
      expect(subject.has_key?(:day)).to be_truthy
      expect(subject.has_key?(:error)).to be_falsey
    end

    context 'with wrong params' do
      let(:params) do
        {code: 200, body: body}
      end

      shared_examples_for :expected_keys do
        it 'expected keys' do
          expect(subject.has_key?(:status)).to be_truthy
          expect(subject.has_key?(:location)).to be_falsey
          expect(subject.has_key?(:url)).to be_falsey
          expect(subject.has_key?(:day)).to be_falsey
          expect(subject.has_key?(:error)).to be_truthy
        end
      end

      context 'localidad' do
        let(:body) { FactoryBot.create(:wrong, :localidad).to_json }

        include_examples :expected_result
        include_examples :expected_keys
      end

      context 'affiliate' do
        let(:body) { FactoryBot.create(:wrong, :affiliate).to_json }

        include_examples :expected_result
        include_examples :expected_keys
      end
    end
  end

  context 'failure' do
    let(:params) do
      {
          code: 200,
          body: 'invalid JSON'
      }
    end

    it 'expected result' do
      expect{subject}.to raise_error(Mutations::ValidationException, "Must be a valid JSON.")
    end
  end
end
