require 'rails_helper'

RSpec.describe Users::Processor, type: :service do
  context 'with valid params' do
    let!(:user) { create(:user, first_name: 'AAA', last_name: 'ZZZ') }

    describe '#full_name' do
      it "returns user's full name" do
        full_name = described_class.new.full_name(user)
        expect(full_name).to eq('AAA ZZZ')
      end
    end
  end
end
