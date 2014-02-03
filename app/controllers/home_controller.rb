class HomeController < ApplicationController
	def index
	end

	def post
		require 'net/http'
		info = params[:nxt]
		secret_phrase = info[:secret_phrase]
		recipient = info[:recipient]
		amount = info[:amount]
		fee = info[:fee]
		deadline = info[:deadline]
		proceed = true
		nil_check = [secret_phrase, recipient, amount, fee, deadline]
		nil_check.each do |not_nil|
			if not_nil.nil?
				proceed = false
			end
		end

		@url = ''
		if proceed
			@transaction = 'derp'
			@url = "https://holms.cloudapp.net:6875/nxt?requestType=sendMoney&secretPhrase=" + secret_phrase + '&recipient=' + recipient + '&amount=' + amount + '&fee=' + fee + '&deadline=' + deadline
			the_url = URI.parse(@url)
			resp_unparsed = Net::HTTP.get_response(the_url)
			resp = JSON.parse(resp_unparsed.body)
			@transaction = resp[:transaction]

		end
	end
end
