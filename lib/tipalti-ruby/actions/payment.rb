# frozen_string_literal: true

module Tipalti
  module Actions
    module Payment
      def payment_get(id)
        connection.get("/api/v1/payments/#{id}")
      end
    end
  end
end
