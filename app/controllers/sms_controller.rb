require 'dotenv/load'
require 'vonage'

class SmsController < ApplicationController
  def initialize
    super
    @client = Vonage::Client.new(
      api_key: ENV['VONAGE_API_KEY'],
      api_secret: ENV['VONAGE_API_SECRET']
    )
  end

  def index
    if request.method == 'POST'
      sms = @client.sms.send(
        from: 'Acme Inc',
        to: params[:number],
        text: params[:text]
      )
      flash.now[:notice] = "SMS sent to #{params[:number]}!" unless sms.nil?
    end
  rescue StandardError => e
    flash.now[:error] = e.message
  end
end
