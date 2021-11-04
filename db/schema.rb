# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_211_103_111_222) do
  create_table 'accounts', force: :cascade do |t|
    t.string 'currency', null: false
    t.integer 'amount', default: 0
    t.integer 'user_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[currency user_id], name: 'index_accounts_on_currency_and_user_id', unique: true
    t.index ['user_id'], name: 'index_accounts_on_user_id'
  end

  create_table 'tags', force: :cascade do |t|
    t.string 'title', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['title'], name: 'index_tags_on_title', unique: true
  end

  create_table 'tags_users', id: false, force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'tag_id', null: false
    t.index %w[user_id tag_id], name: 'index_tags_users_on_user_id_and_tag_id', unique: true
  end

  create_table 'transaction_logs', force: :cascade do |t|
    t.integer 'sum'
    t.integer 'account_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['account_id'], name: 'index_transaction_logs_on_account_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'first_name', null: false
    t.string 'middle_name'
    t.string 'last_name', null: false
    t.string 'identify_number', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['identify_number'], name: 'index_users_on_identify_number', unique: true
  end

  add_foreign_key 'accounts', 'users', on_delete: :cascade
  add_foreign_key 'transaction_logs', 'accounts', on_delete: :cascade
end
