# frozen_string_literal: true

require 'rails_helper'

module Messages
  RSpec.describe AfterCreateJob do
    describe '#perform' do
      subject(:run_job) { described_class.perform_now(message_id) }

      before do
        allow(SendJob).to receive(:perform_later)
        run_job
      end

      describe 'sent to every messenger' do
        let(:message) { create(:message, :with_receivers, messenger_names: MessengerNames.all) }
        let(:message_id) { message.id }

        it { expect(SendJob).to have_received(:perform_later).exactly(MessengerNames.all.size).times }
      end

      describe 'send to specific messenger' do
        let(:messenger) { create(:messenger) }
        let(:message_id) { messenger.message_id }

        it { expect(SendJob).to have_received(:perform_later).with(messenger.id) }
      end
    end
  end
end
