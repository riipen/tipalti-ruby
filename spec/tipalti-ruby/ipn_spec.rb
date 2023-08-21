# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tipalti::Ipn do
  subject { @ipn }

  before do
    @ipn = described_class.new(payload: { foo: "bar" })
  end

  # Class Methods
  describe ".initialize" do
    it "returns a ipn object" do
      expect(@ipn).to be_a(described_class)
    end
  end

  # Instance Methods
  describe "#base_url" do
    it "returns production url without sandbox" do
      @ipn.sandbox = false

      expect(@ipn.base_url).to eq(Tipalti::Ipn::BASE_URL_P)
    end

    it "returns sandbox url with sandbox" do
      @ipn.sandbox = true

      expect(@ipn.base_url).to eq(Tipalti::Ipn::BASE_URL_S)
    end
  end

  describe "#connection" do
    it "returns a connection instance" do
      expect(@ipn.connection).to be_a(Tipalti::Connection)
    end

    it "sets connection url to base url" do
      expect(@ipn.connection.url).to eq(@ipn.base_url)
    end
  end

  describe "#verify" do
    it "issues the correct request with params" do
      stub = stub_request(:post, "#{@ipn.base_url}/notif/ipn.aspx").with(body: { foo: "bar" })

      @ipn.verify

      expect(stub).to have_been_requested
    end
  end
end
