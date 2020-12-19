require 'dotenv/load'
require 'vonage'

class VoiceController < ApplicationController
  def initialize
    super
    @client = Vonage::Client.new(
      application_id: ENV['VONAGE_APPLICATION_ID'],
      private_key: File.read(ENV['VONAGE_PRIVATE_KEY_PATH'])
    )
  end

  def index
    if request.method == 'POST'
      call = @client.voice.create(
        to: [{
          type: 'phone',
          number: params[:number]
        }],
        from: {
          type: 'phone',
          number: ENV['VONAGE_NUMBER']
        },
        ncco: [{
          action: 'talk',
          language: params[:language],
          loop: params[:loop],
          style: params[:style],
          text: params[:text]
        }]
      )
      flash.now[:notice] = "Call request sent to #{params[:number]}!" if call[:status] == 'started'
    end
  rescue StandardError => e
    flash.now[:error] = e.message
  end
end
