# frozen_string_literal: true

require "faraday"

module Tipalti
  class Connection
    attr_accessor :access_token, :url

    def initialize(url:, access_token: nil)
      @access_token = access_token
      @url          = url
    end

    def delete(path, **params)
      request(:delete, path, params)
    end

    def get(path, **params)
      request(:get, path, params)
    end

    def head(path, **params)
      request(:head, path, params)
    end

    def post(path, params = {}, options = {})
      request(:post, path, params, options)
    end

    def put(path, **params)
      request(:put, path, params)
    end

    def request(method, path, params, options = {}) # rubocop:disable Metrics/MethodLength
      response = connection.public_send(method, path, params) do |request|
        request.headers["accept"] = "application/json"
        request.headers["authorization"] = "Bearer #{@access_token}" if @access_token

        if options[:body] == :form
          request.headers["Content-Type"] = "application/x-www-form-urlencoded"
          request.body = URI.encode_www_form(params)
        end
      end

      error = Error.from_response(response)

      raise error if error

      response.body
    end

    private

    def connection
      @connection ||= Faraday.new(url: @url) do |c|
        c.adapter :net_http
        c.request :json, content_type: /\bjson$/
        c.response :json, content_type: /\bjson$/
        c.request :url_encoded, content_type: /x-www-form-urlencoded/
      end
    end
  end
end
