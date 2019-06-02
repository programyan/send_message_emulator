# frozen_string_literal: true

require 'rails_helper'

module Messages
  RSpec.describe Create do
    let(:operation_run) { described_class.call(params) }
    let(:result) { operation_run.success? }
    let(:operation) { operation_run[1] }

    let(:params) do
      {
        body: body,
        sent_at: sent_at,
        messengers: messengers,
      }
    end

    let(:body) { Faker::Lorem.sentence }
    let(:sent_at) { nil }
    let(:messengers) { [name: name, user_id: user_id] }

    let(:name) { MessengerNames.all.sample }
    let(:user_id) { Faker::PhoneNumber.cell_phone }

    describe '.call' do
      it { expect(result).to eq true }
      it { expect { operation_run }.to change(Message, :count).by(1) }
      it { expect { operation_run }.to change(Messenger, :count).by(1) }

      context 'with jobs' do
        before do
          allow(AfterCreateJob).to receive(:perform_later)
          operation_run
        end

        it { expect(AfterCreateJob).to have_received(:perform_later).with(Message.last.id) }
      end

      context 'with scheduled job' do
        let(:sent_at) { 2.days.from_now }
        let(:scheduled_job) { double('AfterCreateJob') }

        before do
          allow(AfterCreateJob).to receive(:set).and_return(scheduled_job)
          allow(scheduled_job).to receive(:perform_later)
          operation_run
        end

        it { expect(AfterCreateJob).to have_received(:set).with(wait_until: sent_at) }
        it { expect(scheduled_job).to have_received(:perform_later).with(Message.last.id) }
      end
    end
  end
end
