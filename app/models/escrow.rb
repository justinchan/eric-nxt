class Escrow < ActiveRecord::Base
  # attr_accessible :title, :body
  	attr_accessible :coin_or_asset, :coin, :asset, :amount
  	attr_accessible :wanted_coin_or_asset, :wanted_coin, :wanted_asset, :wanted_amount
  	attr_accessible :username_to_trade_with, :account_to_receive
  	attr_accessible :deadline, :cancellation
	validates :amount, :numericality => :true
	validates :wanted_amount, :numericality => :true
	validates :coin_or_asset, :amount, :wanted_coin_or_asset, :wanted_amount, :account_to_receive, :deadline, :cancellation, :presence => :true
	belongs_to :user
	belongs_to :initiator, :class_name => "User"
end
