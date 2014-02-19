class EscrowController < ApplicationController
	before_filter :authenticate_user!

	def initiate
	end

	def show
		@escrow_to_display = Escrow.find_by_id(params[:id])
	end


	def post
		initiate = params[:initiate]
		escrow = Escrow.new
		escrow.coin_or_asset = initiate[:coin_or_asset]
		if escrow.coin_or_asset == "Coin"
			escrow.coin = initiate[:coin]
		else
			escrow.asset = initiate[:asset]
		end
		escrow.amount = initiate[:amount]
		escrow.wanted_coin_or_asset = initiate[:wanted_coin_or_asset]
		if escrow.wanted_coin_or_asset == "Coin"
			escrow.wanted_coin = initiate[:wanted_coin]
		else
			escrow.wanted_asset = initiate[:wanted_asset]
		end
		escrow.wanted_amount = initiate[:wanted_amount]
		escrow.account_to_receive = initiate[:account_to_receive]
		escrow.initiator = current_user
		username = initiate[:username_to_trade_with]
		to_trade_with = User.find_by_username(username)
		if not to_trade_with.nil?
			escrow.user = to_trade_with
		else
			flash[:error] = "User to trade with could not be found."
			redirect_to initiate_escrow_path
			return
		end
		t1 = initiate["deadline(1i)"].to_i
		t2 = initiate["deadline(2i)"].to_i
		t3 = initiate["deadline(3i)"].to_i
		t4 = initiate["deadline_time(4i)"].to_i
		t5 = initiate["deadline_time(5i)"].to_i

		tt1 = initiate[:cancellation]
		tt2 = initiate[:cancellation_time]
		if tt2 == "Minutes"
			d2 = DateTime.now + tt1.minutes
		elsif tt2 == "Hours"
			d2 = DateTime.now + tt1.hours
	    elsif tt2 == "Days"
	    	d2 = DateTime.now + tt1.days
	    else #Default catch all
	    	d2 = DateTime.now
	    end
		d1 = DateTime.new(t1, t2, t3, t4, t5, 0, '-8')

		escrow.deadline = d1
		escrow.cancellation = d2

		if escrow.save
			flash[:notice] = "Escrow created."
		else
			flash[:error] = escrow.errors.full_messages.join(". ") + "."
		end
		redirect_to initiate_escrow_path



	end

	def respond
	end
end
