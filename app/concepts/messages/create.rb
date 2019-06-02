# frozen_string_literal: true

module Messages
  class Create < ApplicationOperation
    step Model(Message, :new)
    step Contract::Build(constant: Forms::MessageForm)
    step Contract::Validate()
    step Contract::Persist()
    step :notify!

    def notify!(options, **)
      if options['contract.default'].sent_at
        AfterCreateJob.set(wait_until: options['contract.default'].sent_at).perform_later(options['model'].id)
      else
        AfterCreateJob.perform_later(options['model'].id)
      end
    end
  end
end
