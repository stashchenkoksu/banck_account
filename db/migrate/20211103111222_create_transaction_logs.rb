class CreateTransactionLogs < ActiveRecord::Migration[6.1]
  def change
    return if table_exists? :transaction_logs

    create_table :transaction_logs do |t|
      t.integer :sum
      t.references :account, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
