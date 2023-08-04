# frozen_string_literal: true

module Tipalti
  module Actions
    module Payee
      def payee_create(**params)
        connection.post("/api/v1/payees", **params)
      end

      def payee_get(id)
        connection.get("/api/v1/payees/#{id}")
      end

      def payee_list(**params)
        connection.get("/api/v1/payees", **params)
      end
    end
  end
end
