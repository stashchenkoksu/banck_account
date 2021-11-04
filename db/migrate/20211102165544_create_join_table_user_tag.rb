class CreateJoinTableUserTag < ActiveRecord::Migration[6.1]
  def change
    create_join_table :users, :tags do |t|
      t.index %i[user_id tag_id], unique: true
    end
  end
end
