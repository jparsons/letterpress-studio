# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100214223925) do

  create_table "artists", :force => true do |t|
    t.string   "name",       :default => "",    :null => false
    t.text     "summary",    :default => "",    :null => false
    t.text     "body",       :default => "",    :null => false
    t.boolean  "is_active",  :default => false
    t.boolean  "full_page",  :default => true
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "artists_exhibitions", :id => false, :force => true do |t|
    t.integer "artist_id",     :default => 0, :null => false
    t.integer "exhibition_id", :default => 0, :null => false
  end

  create_table "authors", :force => true do |t|
    t.string "name",            :default => "", :null => false
    t.string "hashed_password", :default => "", :null => false
    t.string "display_name",    :default => "", :null => false
    t.string "salt",            :default => "", :null => false
  end

  create_table "exhibitions", :force => true do |t|
    t.string   "name",            :default => "",    :null => false
    t.text     "summary",         :default => "",    :null => false
    t.text     "body",            :default => "",    :null => false
    t.boolean  "is_active",       :default => false
    t.text     "opening",         :default => "",    :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.datetime "event_start_at",                     :null => false
    t.datetime "event_finish_at",                    :null => false
  end

  create_table "holidays", :force => true do |t|
    t.datetime "date"
    t.text     "note"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "icons", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.text     "summary",    :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "image",      :default => "", :null => false
    t.integer  "position"
    t.integer  "static_id",  :default => 1,  :null => false
  end

  add_index "icons", ["static_id"], :name => "fk_static"

  create_table "no_shows", :force => true do |t|
    t.integer  "user_id"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.string   "name",               :default => "",    :null => false
    t.text     "summary",            :default => "",    :null => false
    t.text     "body",               :default => "",    :null => false
    t.boolean  "is_active",          :default => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "image_file_name",    :default => "",    :null => false
    t.text     "additional",         :default => "",    :null => false
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "photos", :force => true do |t|
    t.string   "name",               :default => "", :null => false
    t.text     "summary",            :default => "", :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "image_file_name",    :default => "", :null => false
    t.integer  "position"
    t.integer  "exhibition_id",      :default => 1,  :null => false
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "photos", ["exhibition_id"], :name => "fk_exhibition"

  create_table "pictures", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.text     "summary",    :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "image",      :default => "", :null => false
    t.integer  "position"
    t.integer  "artist_id",  :default => 1,  :null => false
  end

  add_index "pictures", ["artist_id"], :name => "fk_artist"

  create_table "planes", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.text     "summary",    :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "image",      :default => "", :null => false
    t.integer  "position"
    t.integer  "product_id", :default => 1,  :null => false
  end

  add_index "planes", ["product_id"], :name => "fk_product"

  create_table "presses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name",       :default => "",    :null => false
    t.text     "artist",     :default => "",    :null => false
    t.text     "dimensions", :default => "",    :null => false
    t.text     "medium",     :default => "",    :null => false
    t.text     "size",       :default => "",    :null => false
    t.text     "summary",    :default => "",    :null => false
    t.text     "body",       :default => "",    :null => false
    t.boolean  "is_active",  :default => false
    t.text     "price",      :default => "",    :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "reservations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "press_id"
    t.datetime "date"
    t.integer  "hour"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"

  create_table "statics", :force => true do |t|
    t.string "name",    :default => "", :null => false
    t.text   "summary", :default => "", :null => false
    t.text   "body",    :default => "", :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name",        :default => "", :null => false
    t.text   "description", :default => "", :null => false
  end

  create_table "tags_notes", :id => false, :force => true do |t|
    t.integer "tag_id",  :default => 0, :null => false
    t.integer "note_id", :default => 0, :null => false
  end

  create_table "urlnames", :force => true do |t|
    t.string  "nameable_type"
    t.integer "nameable_id"
    t.string  "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "persistence_token"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
  end

  create_table "work_days", :force => true do |t|
    t.string   "name"
    t.integer  "start_hour"
    t.integer  "end_hour"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
