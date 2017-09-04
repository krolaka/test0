class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :tx_user_id
      t.integer :rx_user_id
      t.string :subject
      t.string :message
      t.boolean :read, default: false
      t.timestamps
    end
  end
end
