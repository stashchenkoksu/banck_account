class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    return if table_exists? :accounts

    create_table :accounts do |t|
      t.string :currency, null: false
      t.integer :amount, default: 0

      t.references :user, foreign_key: { on_delete: :cascade }

      t.index %i[currency user_id], unique: true

      t.timestamps
    end
  end
end
