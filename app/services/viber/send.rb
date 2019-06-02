# frozen_string_literal: true

module Viber
  class Send
    extend ServiceInitializer

    # stub
    def initialize(user_id:, body:)
      @user_id = user_id
      @body = body
    end

    # stub
    def call
      rand(100) <= 95 ? true : raise('error')
    end

    private

    attr_reader :user_id, :body
  end
end
