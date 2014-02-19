class AttributesEscrow < ActiveRecord::Migration
  def change
  	remove_column :escrows, :username_to_trade_with
  	add_column :escrows, :coin_or_asset, :string
  	add_column :escrows, :coin, :string
  	add_column :escrows, :asset, :string
  	add_column :escrows, :amount, :float
  end
end
