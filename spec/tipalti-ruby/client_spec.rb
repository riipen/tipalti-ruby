# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tipalti::Client do
  subject { @client }

  before do
    @client = described_class.new(client_id: "id", client_secret: "secret", access_token: "token")
  end

  # Class Methods
  describe ".initialize" do
    it "returns a client object" do
      expect(@client).to be_a(described_class)
    end
  end

  # Instance Methods
  describe "#base_url" do
    it "returns production url without sandbox" do
      @client.sandbox = false

      expect(@client.base_url).to eq(Tipalti::Client::BASE_URL_P)
    end

    it "returns sandbox url with sandbox" do
      @client.sandbox = true

      expect(@client.base_url).to eq(Tipalti::Client::BASE_URL_S)
    end
  end

  describe "#connection" do
    it "returns a connection instance" do
      expect(@client.connection).to be_a(Tipalti::Connection)
    end

    it "sets connection url to base url" do
      expect(@client.connection.url).to eq(@client.base_url)
    end
  end

  describe "#connection_token" do
    it "returns a connection instance" do
      expect(@client.connection_token).to be_a(Tipalti::Connection)
    end

    it "sets connection_token url to token url" do
      expect(@client.connection_token.url).to eq(@client.token_url)
    end
  end

  describe "#token_url" do
    it "returns production url without sandbox" do
      @client.sandbox = false

      expect(@client.token_url).to eq(Tipalti::Client::TOKEN_URL_P)
    end

    it "returns sandbox url with sandbox" do
      @client.sandbox = true

      expect(@client.token_url).to eq(Tipalti::Client::TOKEN_URL_S)
    end
  end
end
