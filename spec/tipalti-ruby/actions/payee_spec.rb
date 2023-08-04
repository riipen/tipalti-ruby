# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tipalti::Actions::Payee do
  subject { @client }

  before do
    @client = Tipalti::Client.new(client_id: "id", client_secret: "secret", access_token: "token")
  end

  # Instance Methods
  describe "#payee_create" do
    it "issues the correct request with params" do
      stub = stub_request(:post, "#{@client.base_url}/api/v1/payees").with(body: { foo: "bar" })

      @client.payee_create(foo: "bar")

      expect(stub).to have_been_requested
    end
  end

  describe "#payee_get" do
    it "issues the correct request with id" do
      stub = stub_request(:get, "#{@client.base_url}/api/v1/payees/1")

      @client.payee_get("1")

      expect(stub).to have_been_requested
    end
  end

  describe "#payee_list" do
    it "issues the correct request with params" do
      stub = stub_request(:get, "#{@client.base_url}/api/v1/payees").with(query: { filter: 'refCode=="123"' })

      @client.payee_list(filter: 'refCode=="123"')

      expect(stub).to have_been_requested
    end
  end
end
