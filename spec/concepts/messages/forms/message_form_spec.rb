# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Messages::Forms::MessageForm do
  let(:form) { described_class.new(model) }
  let(:form_validate) { form.validate(params) }
  let(:error_messages) { form.errors.messages }

  let(:model) { Message.new }

  let(:params) do
    {
      body: body,
      sent_at: sent_at,
      messengers: messengers
    }
  end

  let(:body) { nil }
  let(:sent_at) { nil }
  let(:messengers) { nil }

  before { form_validate }

  specify { expect(error_messages[:body]).to include "can't be blank" }
  specify { expect(error_messages[:messengers]).to include "can't be blank" }

  describe 'body' do
    let(:body) { Faker::Lorem.sentence }

    specify { expect(error_messages[:body]).to be_blank }
  end

  describe 'messengers' do
    context 'when empty array' do
      let(:messengers) { [] }

      specify { expect(error_messages[:messengers]).to include "can't be blank" }
    end

    context 'when structure' do
      let(:messengers) { [messenger1] }
      let(:messenger1) { { type: type, user_id: user_id } }

      let(:type) { nil }
      let(:user_id) { nil }

      it { expect(error_messages[:"messengers.type"]).to include "can't be blank" }
      it { expect(error_messages[:"messengers.user_id"]).to include "can't be blank" }

      context 'with valid user_id' do
        let(:user_id) { Faker::PhoneNumber.cell_phone }

        it { expect(error_messages[:"messengers.user_id"]).to be_blank }
      end

      context 'with invalid type' do
        let(:type) { Faker::Lorem.word }

        it { expect(error_messages[:"messengers.type"]).to include 'is not included in the list' }
      end

      context 'with invalid type' do
        let(:type) { MessengerTypes.all.sample }

        it { expect(error_messages[:"messengers.type"]).to be_blank }
      end
    end
  end
end
