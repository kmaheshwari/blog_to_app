# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160604082406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_drafts", force: :cascade do |t|
    t.string   "app_icon"
    t.string   "app_name"
    t.string   "categories"
    t.string   "about_us"
    t.string   "privacy_policy"
    t.string   "top_bar_colour"
    t.string   "contact_email"
    t.string   "brand_colour"
    t.string   "article_colour"
    t.string   "accent_colour"
    t.string   "article_writer_colour"
    t.integer  "author_id"
    t.integer  "app_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "appcategories", force: :cascade do |t|
    t.string   "category_name"
    t.integer  "app_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "appcolours", force: :cascade do |t|
    t.integer  "app_id"
    t.string   "top_bar_colour"
    t.string   "brand_colour"
    t.string   "accent_colour"
    t.string   "article_colour"
    t.string   "background_colour"
    t.string   "article_writer_colour"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "apps", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "app_icon"
    t.string   "app_name"
    t.string   "featured_image"
    t.string   "app_url"
    t.string   "apk_url"
    t.integer  "author_id"
    t.string   "contact_email"
    t.string   "access_token"
    t.string   "about_us"
    t.string   "privacy_policy"
    t.string   "app_logo"
  end

  create_table "authors", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "author_active",          default: false
  end

  add_index "authors", ["email"], name: "index_authors_on_email", unique: true, using: :btree
  add_index "authors", ["reset_password_token"], name: "index_authors_on_reset_password_token", unique: true, using: :btree

  create_table "google_analytics", force: :cascade do |t|
    t.string   "analytics_id"
    t.integer  "app_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "google_analytics", ["app_id"], name: "index_google_analytics_on_app_id", using: :btree

  create_table "monetizes", force: :cascade do |t|
    t.string   "platform"
    t.integer  "phone_ad_unit"
    t.string   "add_unit_id"
    t.integer  "interval"
    t.integer  "app_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "order_states", force: :cascade do |t|
    t.string   "app_version_name"
    t.string   "app_status"
    t.date     "generated_date"
    t.string   "download_link"
    t.integer  "author_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string   "customer_id"
    t.integer  "app_id"
    t.float    "amount"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string   "stripe_card_token"
    t.string   "app_id"
    t.string   "plan_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_foreign_key "appcategories", "apps"
  add_foreign_key "appcolours", "apps"
  add_foreign_key "apps", "authors"
  add_foreign_key "google_analytics", "apps"
  add_foreign_key "monetizes", "apps"
  add_foreign_key "order_states", "authors"
  add_foreign_key "payments", "apps"
end
