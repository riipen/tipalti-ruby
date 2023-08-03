# frozen_string_literal: true

module Tipalti
  module Actions
    module Token
      def token_refresh
        response = connection_token.post("/connect/token",
                                         client_id: @client_id,
                                         client_secret: @client_secret,
                                         grant_type: "refresh_token",
                                         refresh_token: @refresh_token,
                                         code_verifier: @code_verifier)

        # Refresh the client values inline
        @access_token   = response["access_token"]
        @refresh_token  = response["refresh_token"]

        # Give a chance to the invoker of the client to do something with the response
        response
      end
    end
  end
end
