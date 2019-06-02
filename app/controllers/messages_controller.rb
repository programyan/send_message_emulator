# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    result =  Messages::Create.(params)

    if result.success?
      render json: {}, status: :created
      return
    end

    render json: result['contract.default'].errors, status: :unprocessable_entity
  end
end
