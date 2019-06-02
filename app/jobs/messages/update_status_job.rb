# frozen_string_literal: true

module Messages
  class UpdateStatusJob < ApplicationJob
    def perform(messenger_id)
      Messenger.where(id: messenger_id).update(sent_at: Time.current)
    end
  end
end
