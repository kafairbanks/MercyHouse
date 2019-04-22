require 'csv'

class Report < ApplicationRecord
    has_many :applicants
    has_many :mercyhomes
    has_many :mercyrooms
    has_many :bookings
    
    def self.get_all_homes
        rHash = Hash.new
        Mercyhome.all.each do |h|
            key = h.HouseName
            rHash[key] = h.id
        end
        return rHash
    end

    def self.generate_report(hash)
        hash[:mhomename] = Mercyhome.find(hash[:mhomeid].to_i).HouseName
        return Report.new(hash)
    end

    def self.to_csv(id)

        report = Report.find(id)
        hid, sd, ed = report[:mhomeid].to_i, report[:dstart], report[:dend]

        CSV.generate do |csv|
            csv << ['MercyHouseName', 'MercyRoomName', 'ApplicantName', 'ApplicantEmail', 'StartDate', 'EndDate']
            Mercyroom.where('mercyhomes_id = ?', hid).each do |r|
                rid = r.id
                Booking.where('? <= "EndDate" and ? >= "StartDate" and mercyrooms_id = ?', sd, ed, rid).each do |b|

                    # pull the necessary info
                    mercyroom = Mercyroom.find(rid)
                    mercyhouse = Mercyhome.find(hid)
                    applicant = Applicant.find(b.applicants_id)

                    rname = mercyroom.RoomName
                    hname = mercyhouse.HouseName
                    aname = applicant.AName
                    aemail = applicant.AEmail
                    bstart = b.StartDate
                    bend = b.EndDate

                    row = [rname, hname, aname, aemail, bstart, bend]
                    csv << row
                end
            end
        end
    end
end
