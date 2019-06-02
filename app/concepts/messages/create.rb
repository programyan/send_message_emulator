# frozen_string_literal: true

module Messages
  class Create < ApplicationOperation
    step Model(Message, :new)
    step Contract::Build(constant: Forms::MessageForm)
    step Contract::Validate()
    step Contract::Persist()
  end
end
