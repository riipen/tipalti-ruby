# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tipalti::Actions::Token do
  subject { @client }

  before do
    @client = Tipalti::Client.new(
      client_id: "id",
      client_secret: "secret",
      access_token: "token",
      refresh_token: "refresh_token",
      code_verifier: "code_verifier"
    )
  end

  # Instance Methods
  describe "#token_refresh" do
    it "issues the correct request" do
      stub = stub_request(:post, "#{@client.token_url}/connect/token").with(body: {
                                                                              client_id: "id",
                                                                              client_secret: "secret",
                                                                              grant_type: "refresh_token",
                                                                              refresh_token: "refresh_token",
                                                                              code_verifier: "code_verifier"
                                                                            })

      @client.token_refresh

      expect(stub).to have_been_requested
    end
  end
end
