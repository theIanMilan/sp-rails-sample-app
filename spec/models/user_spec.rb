require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  context 'with valid attributes' do
    it { is_expected.to be_valid }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:username) }
  end
end
