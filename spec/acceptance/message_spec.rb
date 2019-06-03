# frozen_string_literal: true

require 'acceptance_helper'

RSpec.resource 'API - Messages', acceptance: true do
  post '/messages' do
    parameter :body, 'Текст сообщения'
    parameter :sent_at, 'Время отправки (для отложенной отправки)'
    parameter :messengers, 'Получатели сообщения'

    let(:body) { Faker::Lorem.sentence }
    let(:sent_at) { Time.current }
    let(:messengers) { [messenger1, messenger2] }
    let(:messenger1) { { name: MessengerNames.all.sample, user_id: Faker::PhoneNumber.cell_phone } }
    let(:messenger2) { { name: MessengerNames.all.sample, user_id: Faker::PhoneNumber.cell_phone } }

    example_request 'Create' do
      expect(response_status).to eq(201)
    end
  end
end
