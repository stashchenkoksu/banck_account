class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    return if table_exists? :users

    create_table :users do |t|
      t.string :first_name, null: false
      t.string :middle_name
      t.string :last_name, null: false
      t.string :identify_number, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
