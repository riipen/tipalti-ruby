# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tipalti::Actions::PaymentBatch do
  subject { @client }

  before do
    @client = Tipalti::Client.new(client_id: "id", client_secret: "secret", access_token: "token")
  end

  # Instance Methods
  describe "#payment_batch_create" do
    it "issues the correct request with params" do
      stub = stub_request(:post, "#{@client.base_url}/api/v1/payment-batches").with(body: { foo: "bar" })

      @client.payment_batch_create(foo: "bar")

      expect(stub).to have_been_requested
    end
  end

  describe "#payment_batch_instructions_get" do
    it "issues the correct request with id" do
      stub = stub_request(:get, "#{@client.base_url}/api/v1/payment-batches/1/instructions")

      @client.payment_batch_instructions_get("1")

      expect(stub).to have_been_requested
    end
  end
end
