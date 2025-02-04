[![Gem Version](https://badge.fury.io/rb/tipalti-ruby.svg)](https://badge.fury.io/rb/tipalti-ruby)
[![CircleCI](https://dl.circleci.com/status-badge/img/gh/riipen/tipalti-ruby/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/riipen/tipalti-ruby/tree/main)

# Tiplaty Ruby

An API client for Tipalti in ruby.


## Installation

Add to your `Gemfile`:

```ruby
gem 'tipalti-ruby'
```

Then `bundle install`.

## Usage

### API Client

The Tipalti API uses OAuth to authenticate API requests. 

First you need ot get an access code externally by following the [Tipalti authorization flow](https://documentation.tipalti.com/docs/authorization-flow).

Then you can create a Tipalti API client.

```ruby
client = Tipalti::Client.new(
  client_id: 'client_id', # Tipalti developer app client id
  client_secret: 'client_secret', # Tipalti developer app client id
  access_token: 'access_token', # Access token from authorization flow
  refresh_token: 'refresh_token', # Refresh token from authorization flow
  code_verifier: 'secret', # Code verifier from authorization flow
  timeout: 30, # Optional setting for timeouts of all requests (default 60)
)
```

You can use the Tipalti sandbox by setting `client.sanbox = true` or as part of the client initialization

```ruby
client = Tipalti::Client.new(
  ...
  sandbox: true
)
```

### API Endpoints

For use of each endpoint and available attributes or filtering criteria, please consult the [Tipalti API reference](https://documentation.tipalti.com/reference/introduction).

#### Payees create

[API docs](https://documentation.tipalti.com/reference/post_api-v1-payees)

Example: `client.payee_create(refCode: '123abc')`

#### Payees get

[API docs](https://documentation.tipalti.com/reference/get_api-v1-payees-id)

Example: `client.payee_get('123abc')`

#### Payees list

[API docs](https://documentation.tipalti.com/reference/get_api-v1-payees)

Example: `client.payee_list(filter: 'status=="ACTIVE"')`

#### Payment batches create

[API docs](https://documentation.tipalti.com/reference/post_api-v1-payment-batches)

Example:

```ruby
client.payment_batch_create({ 
                              paymentInstructions: [
                                { 
                                  payeeId: '123456', 
                                  amountSubmitted: { amount: 5, currency: 'USD' }, 
                                  refCode: '123ref' 
                                }
                              ] 
                            })
```

#### Payment batches instructions get

[API docs](https://documentation.tipalti.com/reference/get_api-v1-payment-batches-id-instructions)

Example: `client.payment_batch_instructions_get('3456789')`

#### Payments get

[API docs](https://documentation.tipalti.com/reference/get_api-v1-payments-id)


Example: `client.payment_get('123abc')`

### Token Management

#### Refresh

If your OAuth access token has expired, you can use the client to refresh your token.

[API docs](https://documentation.tipalti.com/docs/step-5-get-a-new-access-token-using-a-refresh-token#response)

`client.token_refresh`

This will return this [response object](https://documentation.tipalti.com/docs/step-5-get-a-new-access-token-using-a-refresh-token#response) as well as update the client to use the new access token on successful refresh.

### Errors

Any error code returned by the Tipalti API will result in one of the following expections

|Code|Exception|
|----|---------|
|400| Tipalti::BadRequest|
|401| Tipalti::Unauthorized|
|403| Tipalti::Forbidden|
|404| Tipalti::NotFound|
|429| Tipalti::TooManyRequests|
|400| Tipalti::ClientError|
|500| Tipalti::InternalServerError|
|503| Tipalti::ServiceUnavailable|
|500| Tipalti::ServerError|

### IPNs

Tiplati uses an IPN (instance payment notification) messaging service that enables you to receive notifications from Tipalti. Notifications are triggered when defined events occur (e.g., changes in payee details, system events and payment statuses).

To manage IPNs you will need to instantiate a IPN instance like so.

```ruby
ipn = Tipalti::Ipn.new(
  payload: '...', # The raw payload received to your server from the Tipalti IPN
)
```

You can use the Tipalti sandbox by setting `ipn.sanbox = true` or as part of the initialization

```ruby
ipn = Tipalti::Ipn.new(
  ...
  sandbox: true
)
```

#### Verify

[API docs](https://support.tipalti.com/Content/Topics/Development/IPNs/ipnprotocol.htm#AcknowledgeAndVerifyIPN)

Example: `ipn.verify`

## License

Copyright (C) 2023 Jordan Ell. See [LICENSE](https://github.com/riipen/tipalti-ruby/blob/master/LICENSE.md) for details.
