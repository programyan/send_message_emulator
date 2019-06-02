# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    body { Faker::Lorem.sentence }

    trait :with_receivers do
      transient do
        messenger_names { [] }
      end

      after(:build) do |message, evaluator|
        evaluator.messenger_names.each do |name|
          message.messengers << build(:messenger, name: name)
        end
      end
    end
  end
end
