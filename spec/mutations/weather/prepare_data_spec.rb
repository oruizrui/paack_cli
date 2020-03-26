require 'spec_helper'

describe Weather::PrepareData do
  subject { described_class.run!(params) }

  let(:params) { FactoryBot.create(:body) }

  context 'success' do
    let(:expected_data) { FactoryBot.create(:data) }

    it 'expected result' do
      expect(subject).to be_truthy
      expect(subject).to match(expected_data)
    end
  end


  shared_examples_for :expected_error do
    it 'raises an error' do
      expect{subject}.to raise_error(
                             Mutations::ValidationException,
                             'Wrong data consisntecy. Data is invalid.'
                         )
    end
  end

  context 'failure' do
    context 'missing keys' do
      context 'status equal 0' do
        [:location, :url, :day].each do |key|
          context "missing key: #{key.to_s}" do
            let(:params) do
              FactoryBot.create(:body).tap do |param|
                param.delete(key)
              end
            end

            include_examples :expected_error
          end
        end
      end
      context 'status equal 1' do
        context 'missing key: error' do
          let(:params) do
            FactoryBot.create(:wrong, :localidad).tap do |param|
              param.delete(:error)
            end
          end

          include_examples :expected_error
        end
      end
    end
  end

  #context 'only we can continue if we have correct data' do
  #  context 'status must be 0' do
  #    let(:params) { FactoryBot.create(:wrong, :localidad) }
  #
  #    it 'expected error' do
  #      expect{subject}.to raise_error(
  #                             Mutations::ValidationException,
  #                             params[:error]
  #                         )
  #    end
  #  end
  #end
end
