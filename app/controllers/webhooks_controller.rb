require 'dotenv/load'

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def event
    return if params[:dtmf].nil?

    render json: [
      {
        action: 'stream',
        streamUrl: [ENV['STREAM_URL']]
      },
      {
        action: 'talk',
        language: 'en-IN',
        style: 4,
        text: "You entered, #{params[:dtmf][:digits]}, hanging up, have a good day,"
      }
    ]
  end

  def answer
    from = params[:from] || parsed_body[:from]
    from_split = from.split('').join(' ')

    render json: [
      {
        action: 'stream',
        streamUrl: [ENV['STREAM_URL']]
      },
      {
        action: 'talk',
        language: 'en-IN',
        style: 4,
        text: "Thank you, for calling, a Vonage Number, that belongs to, Sudipto, from, #{from_split}, please enter a three digit number and then press hash,"
      },
      {
        action: 'input',
        eventUrl: ["https://#{ENV['NGROK_DOMAIN']}/webhooks/event"],
        type: ['dtmf'],
        dtmf: { maxDigits: 3, submitOnHash: true, timeOut: 10 }
      }
    ]
  end
end
