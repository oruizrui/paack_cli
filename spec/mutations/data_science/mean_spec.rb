require 'spec_helper'

describe DataScience::Mean do
  subject { described_class.run!(params) }

  let(:params) do
    {
        numbers: [3, 4, 5]
    }
  end

  it 'expected results' do
    expect(subject).to be_truthy
    expect(subject).to eq(4.0)
  end
end
