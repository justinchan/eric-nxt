class DashboardController < ApplicationController
	before_filter :authenticate_user!

	def index
	end

	def post
		require 'net/https'
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
			http = Net::HTTP.new(the_url.host, the_url.port)
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			request = Net::HTTP::Get.new(the_url.request_uri)
			resp_unparsed = http.request(request)
			@resp = JSON.parse(resp_unparsed.body)
			@transaction = @resp[:transaction]

		end
	end
end
