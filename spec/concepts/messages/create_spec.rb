# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Messages::Create do
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
  let(:messengers) { [type: type, user_id: user_id] }

  let(:type) { MessengerTypes.all.sample }
  let(:user_id) { Faker::PhoneNumber.cell_phone }

  describe '.call' do
    it { expect(result).to eq true }
    it { expect { operation_run }.to change(Message, :count).by(1) }
    it { expect { operation_run }.to change(Messenger, :count).by(1) }
  end
end
