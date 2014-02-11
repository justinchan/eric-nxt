class CreateEscrows < ActiveRecord::Migration
  def change
    create_table :escrows do |t|

      t.timestamps
    end
  end
end
