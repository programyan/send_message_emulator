# frozen_string_literal: true

class Message < ApplicationRecord
  has_many :messengers
end
