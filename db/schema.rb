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

ActiveRecord::Schema[7.0].define(version: 2023_05_27_225045) do
  create_table "claim_status_histories", force: :cascade do |t|
    t.integer "claim_id"
    t.string "transition_from"
    t.string "transition_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["claim_id"], name: "index_claim_status_histories_on_claim_id"
  end

  create_table "claims", force: :cascade do |t|
    t.string "amount"
    t.integer "person_id"
    t.integer "insurance_policy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.integer "health_report_id"
    t.datetime "date_of_service"
    t.string "diagnosis"
    t.string "procedure"
    t.string "provider"
    t.integer "paid_by_insurance"
    t.integer "out_of_pocket"
    t.integer "consultation_id"
    t.index ["health_report_id"], name: "index_claims_on_health_report_id"
    t.index ["insurance_policy_id"], name: "index_claims_on_insurance_policy_id"
    t.index ["person_id"], name: "index_claims_on_person_id"
  end

  create_table "consents", force: :cascade do |t|
    t.datetime "registered_on"
    t.string "requested_by"
    t.string "access_modules"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "consultation_id"
    t.index ["consultation_id"], name: "index_consents_on_consultation_id"
    t.index ["person_id"], name: "index_consents_on_person_id"
  end

  create_table "consultations", force: :cascade do |t|
    t.integer "health_report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["health_report_id"], name: "index_consultations_on_health_report_id"
  end

  create_table "health_reports", force: :cascade do |t|
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_health_reports_on_person_id"
  end

  create_table "insurance_policies", force: :cascade do |t|
    t.string "insurer"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "sum_insured"
    t.string "covers"
    t.integer "health_report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "coverage"
    t.index ["health_report_id"], name: "index_insurance_policies_on_health_report_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "amount"
    t.integer "health_report_id"
    t.integer "consultation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consultation_id"], name: "index_invoices_on_consultation_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "data"
    t.string "sender"
    t.string "type"
    t.integer "consultation_id"
    t.index ["person_id"], name: "index_notifications_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "health_id"
    t.string "email"
    t.string "phone"
    t.string "aadhar_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["health_id"], name: "index_people_on_health_id", unique: true
  end

  create_table "prescriptions", force: :cascade do |t|
    t.string "medicines"
    t.string "lab_tests"
    t.string "transcript"
    t.string "prescription_detail"
    t.integer "health_report_id"
    t.integer "consultation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consultation_id"], name: "index_prescriptions_on_consultation_id"
  end

  add_foreign_key "claim_status_histories", "claims"
  add_foreign_key "claims", "insurance_policies"
  add_foreign_key "claims", "people"
  add_foreign_key "consents", "people"
  add_foreign_key "consultations", "health_reports"
  add_foreign_key "health_reports", "people"
  add_foreign_key "insurance_policies", "health_reports"
  add_foreign_key "invoices", "consultations"
  add_foreign_key "notifications", "people"
  add_foreign_key "prescriptions", "consultations"
end
