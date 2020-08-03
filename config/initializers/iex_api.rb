IEX::Api.configure do |config|
  config.publishable_token = 'Tpk_f726de855a7742be9ecefd068684f465' # defaults to ENV['IEX_API_PUBLISHABLE_TOKEN']
  config.secret_token = 'Tsk_2b0bf2af9aee41a68a7f1fbfac2d0988' # defaults to ENV['IEX_API_SECRET_TOKEN']
  config.endpoint = 'https://sandbox.iexapis.com/v1' # use 'https://sandbox.iexapis.com/v1' for Sandbox
end