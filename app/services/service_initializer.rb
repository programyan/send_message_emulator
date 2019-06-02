# frozen_string_literal: true

module ServiceInitializer
  def call(*args)
    new(*args).call
  end
end
