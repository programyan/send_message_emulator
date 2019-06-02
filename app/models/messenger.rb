# frozen_string_literal: true

class Messenger < ApplicationRecord
  belongs_to :message

  delegate :body, to: :message, prefix: true
end
