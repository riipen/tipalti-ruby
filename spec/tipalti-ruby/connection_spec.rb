# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tipalti::Connection do
  subject { @connection }

  before do
    @connection = described_class.new(access_token: "token", url: "https://foo.com")
  end

  # Class Methods
  describe ".initialize" do
    it "returns a connection object" do
      expect(@connection).to be_a(described_class)
    end
  end

  # Instance Methods
  describe "#delete" do
    it "issues a delete request" do
      stub = stub_request(:delete, "https://foo.com/bar")

      @connection.delete("/bar")

      expect(stub).to have_been_requested
    end
  end

  describe "#get" do
    it "issues a get request" do
      stub = stub_request(:get, "https://foo.com/bar")

      @connection.get("/bar")

      expect(stub).to have_been_requested
    end

    it "adds authorization to request when present" do
      stub = stub_request(:get, "https://foo.com/bar").with(headers: {
                                                              "Accept" => "application/json",
                                                              "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
                                                              "Authorization" => "Bearer token",
                                                              "User-Agent" => "Faraday v1.10.3"
                                                            })

      @connection.get("/bar")

      expect(stub).to have_been_requested
    end

    it "does not add authorization to request when not present" do
      @connection.access_token = nil

      stub = stub_request(:get, "https://foo.com/bar").with(headers: {
                                                              "Accept" => "application/json",
                                                              "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
                                                              "User-Agent" => "Faraday v1.10.3"
                                                            })

      @connection.get("/bar")

      expect(stub).to have_been_requested
    end
  end

  describe "#head" do
    it "issues a head request" do
      stub = stub_request(:head, "https://foo.com/bar")

      @connection.head("/bar")

      expect(stub).to have_been_requested
    end
  end

  describe "#post" do
    it "issues a post request" do
      stub = stub_request(:post, "https://foo.com/bar")

      @connection.post("/bar")

      expect(stub).to have_been_requested
    end

    it "issues a post request with form encoded body" do
      stub = stub_request(:post, "https://foo.com/bar").with(headers: {
                                                               "Content-Type" => "application/x-www-form-urlencoded"
                                                             }, body: "foo=bar")

      @connection.post("/bar", { foo: "bar" }, { body: :form })

      expect(stub).to have_been_requested
    end
  end

  describe "#put" do
    it "issues a put request" do
      stub = stub_request(:put, "https://foo.com/bar")

      @connection.put("/bar")

      expect(stub).to have_been_requested
    end
  end

  describe "#request" do
    it "issues the correct request" do
      stub = stub_request(:post, "https://foo.com/bar")

      @connection.request(:post, "/bar", {})

      expect(stub).to have_been_requested
    end
  end
end
