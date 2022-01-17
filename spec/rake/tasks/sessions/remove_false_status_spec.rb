require 'rails_helper'

RSpec.describe Rake::Task, type: :task do
  load Rails.root.join('lib/tasks/sessions/remove_false_status.rake')

  context 'with valid params' do
    let!(:session_false) { create(:session) }
    let!(:session_true) { create(:session, status: true) }

    before do
      session_false.status = false
      session_false.save
      session_false.reload
    end

    subject! { described_class['sessions:remove_false_status'].execute }

    it 'destroys false status sessions' do
      expect(Session.all.count).to eq(1)
    end
  end
end
