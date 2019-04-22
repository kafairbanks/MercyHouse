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

ActiveRecord::Schema.define(version: 2019_04_16_173921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applicants", force: :cascade do |t|
    t.string "AName", limit: 40, null: false
    t.boolean "AMinor"
    t.integer "AAge"
    t.integer "CareGiverID"
    t.string "CGName", limit: 40
    t.string "CGHomePhone", limit: 15
    t.string "CGCellPhone", limit: 15
    t.string "CGAddress", limit: 100
    t.string "CGCity", limit: 40
    t.string "CGState", limit: 40
    t.string "CGZip", limit: 10
    t.string "CGEmail", limit: 20
    t.string "SPName", limit: 40
    t.string "SPHomePhone", limit: 15
    t.string "SPCellPhone", limit: 15
    t.string "SPAddress", limit: 100
    t.string "SPCity", limit: 40
    t.string "SPState", limit: 40
    t.string "SPZip", limit: 10
    t.string "SPEmail", limit: 20
    t.string "EC1Name", limit: 40
    t.string "EC1HomePhone", limit: 15
    t.string "EC1CellPhone", limit: 15
    t.string "EC1Address", limit: 100
    t.string "EC1City", limit: 40
    t.string "EC1State", limit: 10
    t.string "EC1Zip", limit: 10
    t.string "EC1Email", limit: 20
    t.string "EC2Name", limit: 40
    t.string "EC2HomePhone", limit: 15
    t.string "EC2CellPhone", limit: 15
    t.string "EC2Address", limit: 100
    t.string "EC2City", limit: 40
    t.string "EC2State", limit: 10
    t.string "EC2Zip", limit: 10
    t.string "EC2Email", limit: 20
    t.boolean "allowsUseOfName"
    t.boolean "redFlag", default: false, null: false
    t.string "AEmail", limit: 200, null: false
    t.boolean "BackgroundCheckCompleted", default: false
    t.date "BackgroundCheckDate"
    t.boolean "canSubmitApplication", default: false
    t.boolean "BCWaived", default: false
    t.string "BCReason"
    t.string "RedFlagReason"
  end

  create_table "applications", force: :cascade do |t|
    t.integer "applicants_id", null: false
    t.date "ApplicationDate"
    t.string "ApplicationStatus", limit: 40, default: "Submitted"
    t.string "HospitalName", limit: 100
    t.string "DoctorName", limit: 100
    t.string "TreatmentPlan", limit: 100
    t.boolean "appliedForLongTermHousing"
    t.string "whereLongTermHousing", limit: 100
    t.string "prayerRequests", limit: 200
    t.boolean "isFirstVisit"
    t.boolean "wantsInfo"
    t.boolean "insuranceCoversHousing"
    t.string "futureScheduledAppts", limit: 200
    t.date "ArrivalDate"
    t.date "DepartureDate"
    t.boolean "lockApplication", default: true, null: false
    t.boolean "booked", default: false, null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "applicants_id", null: false
    t.integer "mercyrooms_id", null: false
    t.date "StartDate"
    t.date "EndDate"
    t.integer "application_id", null: false
  end

  create_table "coordinators", force: :cascade do |t|
    t.string "HCName", limit: 40, null: false
    t.string "HCPhone", limit: 15
    t.string "HCEmail", limit: 100
  end

  create_table "mercyhomes", force: :cascade do |t|
    t.string "HouseName", limit: 100, null: false
    t.string "HouseAddress", limit: 100
    t.string "HouseCity", limit: 40
    t.string "HouseState", limit: 40
    t.string "HouseZip", limit: 10
    t.integer "coordinators_id", null: false
    t.string "color"
  end

  create_table "mercyrooms", force: :cascade do |t|
    t.integer "mercyhomes_id", null: false
    t.string "RoomName", limit: 100, null: false
    t.string "RoomDesc", limit: 200
    t.boolean "firstfloor"
  end

  create_table "reports", force: :cascade do |t|
    t.integer "mhomeid"
    t.string "mhomename", limit: 100
    t.date "dstart"
    t.date "dend"
    t.datetime "created_on", default: -> { "CURRENT_TIMESTAMP" }
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "oauth_tok"
    t.datetime "oauth_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", limit: 10, default: "user"
    t.integer "applicantid", default: -1
    t.string "email"
  end

end
