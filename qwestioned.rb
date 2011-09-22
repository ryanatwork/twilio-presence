require 'sinatra'
require 'erb'
require 'twilio-ruby'

get '/' do
  erb :root
end

get '/client' do
  # build up a response

  response = Twilio::TwiML::Response.new do |r|
    r.Dial do |d|
      d.Client params[:PhoneNumber]
      end
    end

  # print the result
  puts response.text
end

def generate_auth(client = 'ryan')

  account_sid = ENV['TWILIO_SID']
  auth_token = ENV['TWILIO_TOKEN']

  capability = Twilio::Util::Capability.new account_sid, auth_token
  capability.allow_client_outgoing ENV['TWILIO_APP']
  capability.allow_client_incoming client
  @token = capability.generate

end
