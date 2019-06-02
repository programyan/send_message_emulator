# frozen_string_literal: true

module Messages
  class AfterCreateJob < ApplicationJob
    def perform(message_id)
      message = Message.find(message_id)

      message.messengers.each do |messenger|
        SendJob.perform_later(messenger.id)
      end
    end
  end
end
