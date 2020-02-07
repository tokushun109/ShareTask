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

ActiveRecord::Schema.define(version: 2020_02_07_073244) do

  create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "leader_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["leader_user_id"], name: "index_groups_on_leader_user_id"
  end

  create_table "pictures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.index ["record_id"], name: "index_pictures_on_record_id"
  end

  create_table "records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "progress"
    t.string "supplement"
    t.bigint "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_records_on_task_id"
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_relationships_on_group_id"
    t.index ["user_id", "group_id"], name: "index_relationships_on_user_id_and_group_id", unique: true
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "tasks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "post_user_id"
    t.bigint "post_group_id"
    t.string "in_charge"
    t.datetime "time_limit"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_group_id"], name: "index_tasks_on_post_group_id"
    t.index ["post_user_id"], name: "index_tasks_on_post_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "user_name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_foreign_key "groups", "users", column: "leader_user_id"
  add_foreign_key "pictures", "records"
  add_foreign_key "records", "tasks"
  add_foreign_key "relationships", "groups"
  add_foreign_key "relationships", "users"
  add_foreign_key "tasks", "groups", column: "post_group_id"
  add_foreign_key "tasks", "users", column: "post_user_id"
end
