# frozen_string_literal: true

module MessengerNames
  module_function

  WHATSAPP = 'WhatsApp'
  VIBER = 'Viber'
  TELEGRAM = 'Telegram'

  def all
    [WHATSAPP, VIBER, TELEGRAM].freeze
  end
end
