# frozen_string_literal: true

module Tipalti
  class Client
    include Tipalti::Actions::Payee
    include Tipalti::Actions::Token

    BASE_URL_P  = "https://api-p.tipalti.com"
    BASE_URL_S  = "https://api-sb.tipalti.com"
    TOKEN_URL_P = "https://sso.tipalti.com"
    TOKEN_URL_S = "https://sso.sandbox.tipalti.com"

    attr_accessor :sandbox

    def initialize(client_id:, client_secret:, access_token:, refresh_token: nil, code_verifier: nil, sandbox: false) # rubocop:disable Metrics/ParameterLists
      @client_id      = client_id
      @client_secret  = client_secret
      @access_token   = access_token
      @refresh_token  = refresh_token
      @code_verifier  = code_verifier
      @sandbox        = sandbox
    end

    def base_url
      @sandbox ? BASE_URL_S : BASE_URL_P
    end

    def connection
      Connection.new(access_token: @access_token, url: base_url)
    end

    def connection_token
      Connection.new(access_token: @access_token, url: token_url)
    end

    def token_url
      @sandbox ? TOKEN_URL_S : TOKEN_URL_P
    end
  end
end
