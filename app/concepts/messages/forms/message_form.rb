# frozen_string_literal: true

module Messages
  module Forms
    class MessageForm < Reform::Form
      property :body
      property :sent_at, virtual: true

      collection :messengers, presence: true, populate_if_empty: Messenger, default: [] do
        property :user_id
        property :type

        validates :user_id, :type, presence: true
        validates :type, inclusion: { in: MessengerTypes.all }
      end

      validates :body, presence: true
      validates :messengers, presence: true
    end
  end
end
