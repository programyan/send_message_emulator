# frozen_string_literal: true

require 'rails_helper'

module Messages
  RSpec.describe UpdateStatusJob do
    describe '#perform' do
      subject(:run_job) { described_class.perform_now(messenger_id) }

      let(:messenger_id) { messenger.id }

      let(:messenger) { create(:messenger) }

      before { run_job }

      specify { expect(messenger.reload.sent_at).not_to be_blank }
    end
  end
end
