# frozen_string_literal: true

module Tipalti
  class Ipn
    BASE_URL_P  = "https://console.tipalti.com"
    BASE_URL_S  = "https://console.sandbox.tipalti.com"

    attr_accessor :sandbox

    def initialize(payload:, sandbox: false)
      @payload = payload
      @sandbox = sandbox
    end

    def base_url
      @sandbox ? BASE_URL_S : BASE_URL_P
    end

    def connection
      Connection.new(url: base_url)
    end

    def verify
      connection.post("/notif/ipn.aspx", **@payload)
    end
  end
end
