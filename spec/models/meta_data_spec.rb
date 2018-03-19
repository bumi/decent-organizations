require 'spec_helper'

RSpec.describe MetaData, type: :model do
  subject { MetaData.new('https://www.railslove.com', fake_service) }
  let(:fake_service) { double 'MetaInspector', new: result }
  let(:result) { double 'result', title: 'Railslove', best_description: 'Gute Bude!', url: 'https://www.railslove.com' }

  describe '#page' do
    it { expect(subject.page).to eq(title: 'Railslove', description: 'Gute Bude!', url: 'https://www.railslove.com') }
  end
end

