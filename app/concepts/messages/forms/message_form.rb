# frozen_string_literal: true

module Messages
  module Forms
    class MessageForm < Reform::Form
      property :body
      property :sent_at, virtual: true

      collection :messengers, presence: true, populate_if_empty: Messenger do
        property :user_id
        property :name

        validates :user_id, :name, presence: true
        validates :name, inclusion: { in: MessengerNames.all }
      end

      validates :body, presence: true
      validates :messengers, presence: true

      validate :uniq_messengers
      def uniq_messengers
        return if messengers.blank?
        messenger_values = messengers.map{ |m| [m.name, m.user_id] }

        errors.add(:messengers, :taken) if messenger_values.size != messenger_values.uniq.size
      end
    end
  end
end
