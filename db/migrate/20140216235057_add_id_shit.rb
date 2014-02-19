class AddIdShit < ActiveRecord::Migration
  def change
  	add_column :escrows, :user_id, :integer
  	add_column :escrows, :initiator_id, :integer
  end
end
