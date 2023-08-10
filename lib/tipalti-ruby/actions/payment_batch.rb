# frozen_string_literal: true

module Tipalti
  module Actions
    module PaymentBatch
      def payment_batch_create(**params)
        connection.post("/api/v1/payment-batches", **params)
      end

      def payment_batch_instructions_get(id)
        connection.get("/api/v1/payment-batches/#{id}/instructions")
      end
    end
  end
end
