# frozen_string_literal: true

require 'rails_helper'

module Messages
  RSpec.describe SendJob do
    describe '#perform' do
      subject(:run_job) { described_class.perform_now(messenger_id) }

      let(:messenger_id) { messenger.id }

      context 'with telegram' do
        let(:messenger) { create(:messenger, :telegram) }

        before do
          allow(Telegram::Send).to receive(:call)
          run_job
        end

        specify { expect(Telegram::Send).to have_received(:call).with(user_id: messenger.user_id, body: messenger.message_body) }
      end

      context 'with viber' do
        let(:messenger) { create(:messenger, :viber) }

        before do
          allow(Viber::Send).to receive(:call)
          run_job
        end

        specify { expect(Viber::Send).to have_received(:call).with(user_id: messenger.user_id, body: messenger.message_body) }
      end

      context 'with whatsapp' do
        let(:messenger) { create(:messenger, :whats_app) }

        before do
          allow(WhatsApp::Send).to receive(:call)
          run_job
        end

        specify { expect(WhatsApp::Send).to have_received(:call).with(user_id: messenger.user_id, body: messenger.message_body) }
      end
    end
  end
end
