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

ActiveRecord::Schema.define(version: 20160602105524) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_drafts", force: :cascade do |t|
    t.string   "app_icon"
    t.string   "app_name"
    t.string   "categories"
    t.string   "about_us"
    t.string   "privacy_policy"
    t.integer  "top_bar_colour"
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

  create_table "app_pages", force: :cascade do |t|
    t.string   "page"
    t.integer  "app_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "drafts", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.text     "previous_draft"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "drafts", ["created_at"], name: "index_drafts_on_created_at", using: :btree
  add_index "drafts", ["event"], name: "index_drafts_on_event", using: :btree
  add_index "drafts", ["item_id"], name: "index_drafts_on_item_id", using: :btree
  add_index "drafts", ["item_type"], name: "index_drafts_on_item_type", using: :btree
  add_index "drafts", ["updated_at"], name: "index_drafts_on_updated_at", using: :btree
  add_index "drafts", ["whodunnit"], name: "index_drafts_on_whodunnit", using: :btree

  create_table "monetizes", force: :cascade do |t|
    t.string   "platform"
    t.integer  "phone_ad_unit"
    t.string   "add_unit_id"
    t.integer  "interval"
    t.integer  "app_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string   "customer_id"
    t.integer  "app_id"
    t.float    "amount"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "appcategories", "apps"
  add_foreign_key "appcolours", "apps"
  add_foreign_key "apps", "authors"
  add_foreign_key "monetizes", "apps"
  add_foreign_key "payments", "apps"
end
