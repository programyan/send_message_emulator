# frozen_string_literal: true

FactoryBot.define do
  factory :messenger do
    message { create(:message) }
    name { MessengerNames.all.sample }
    user_id { Faker::PhoneNumber.cell_phone }
    sent_at { nil }

    trait :telegram do
      name { MessengerNames::TELEGRAM }
    end

    trait :viber do
      name { MessengerNames::VIBER }
    end

    trait :whats_app do
      name { MessengerNames::WHATSAPP }
    end
  end
end
