class CreateTags < ActiveRecord::Migration[6.1]
  def change
    return if table_exists? :tags

    create_table :tags do |t|
      t.string :title, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
