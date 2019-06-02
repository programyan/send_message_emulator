# frozen_string_literal: true

module Messages
  class SendJob < ApplicationJob
    def perform(messenger_id)
      messenger = Messenger.find(messenger_id)

      if messenger.name.constantize::Send.call(user_id: messenger.user_id, body: messenger.message_body)
        UpdateStatusJob.perform_later(messenger_id)
      end
    end
  end
end
