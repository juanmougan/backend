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

ActiveRecord::Schema.define(version: 20151007220647) do

  create_table "assignments", force: :cascade do |t|
    t.integer  "year"
    t.integer  "professor_id"
    t.integer  "subject_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "assignments", ["professor_id"], name: "index_assignments_on_professor_id"
  add_index "assignments", ["subject_id"], name: "index_assignments_on_subject_id"

  create_table "careers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "code"
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer  "year"
    t.integer  "student_id"
    t.integer  "subject_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "professorship"
    t.string   "shift"
  end

  add_index "enrollments", ["student_id"], name: "index_enrollments_on_student_id"
  add_index "enrollments", ["subject_id"], name: "index_enrollments_on_subject_id"

  create_table "flat_students", force: :cascade do |t|
    t.integer  "csv_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "file_number"
    t.string   "career"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "title"
    t.string   "message"
    t.datetime "sent_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "subscription_list_id"
  end

  add_index "notifications", ["subscription_list_id"], name: "index_notifications_on_subscription_list_id"

  create_table "professors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "file_number"
    t.string   "regid"
    t.string   "email"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "csv_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "file_number"
    t.integer  "career_id"
    t.string   "regid"
    t.string   "email"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "students", ["career_id"], name: "index_students_on_career_id"

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.integer  "career_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "code"
  end

  add_index "subjects", ["career_id"], name: "index_subjects_on_career_id"

# Could not dump table "subjects_raw" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "subscription_lists", force: :cascade do |t|
    t.string   "name"
    t.integer  "student_id"
    t.integer  "notification_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "subscription_lists", ["notification_id"], name: "index_subscription_lists_on_notification_id"
  add_index "subscription_lists", ["student_id"], name: "index_subscription_lists_on_student_id"

end
