require 'dotenv/load'
require 'vonage'

class InsightsController < ApplicationController
  def initialize
    super
    @client = Vonage::Client.new(
      api_key: ENV['VONAGE_API_KEY'],
      api_secret: ENV['VONAGE_API_SECRET']
    )
  end

  def index
    if request.method == 'POST'
      insight = @client.number_insight.standard(number: params[:number])
      flash.now[:notice] = "Registered with #{insight[:current_carrier][:name]} in #{insight[:country_name]}!"
    end
  rescue StandardError => e
    flash.now[:error] = e.message
  end
end
