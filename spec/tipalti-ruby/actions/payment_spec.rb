# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tipalti::Actions::Payment do
  subject { @client }

  before do
    @client = Tipalti::Client.new(client_id: "id", client_secret: "secret", access_token: "token")
  end

  # Instance Methods
  describe "#payment_get" do
    it "issues the correct request with id" do
      stub = stub_request(:get, "#{@client.base_url}/api/v1/payments/1")

      @client.payment_get("1")

      expect(stub).to have_been_requested
    end
  end
end
