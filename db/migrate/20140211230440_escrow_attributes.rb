class EscrowAttributes < ActiveRecord::Migration
  def change
  	add_column :escrows, :wanted_coin_or_asset, :string
  	add_column :escrows, :wanted_coin, :string
  	add_column :escrows, :wanted_amount, :float
  	add_column :escrows, :wanted_asset, :string
  	add_column :escrows, :username_to_trade_with, :string
  	add_column :escrows, :account_to_receive, :string
  	add_column :escrows, :deadline, :datetime
  	add_column :escrows, :cancellation, :datetime
  end
end
