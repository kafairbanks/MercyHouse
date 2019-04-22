# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

coordinators = [{HCName:'Isaac\'s Dad', HCPhone: '979-123-4567', HCEmail: 'HC@mercyhouse.org'},
                {HCName:'Brian\'s Mom', HCPhone: '979-345-3456', HCEmail: 'HC2@mercyhouse.org'}]

coordinators.each do |coordinator|
  Coordinator.create!(coordinator)
end

reports = [{mhomeid: '1',
            dstart: '2019-03-01',
            dend: '2019-04-01'}]

reports.each do |report|
  Report.create!(report)
end

mercyhomes = [{HouseName: 'Mercy House 1', HouseAddress: '123 Houston Street', HouseCity: 'Houston', HouseState: 'TX', HouseZip: '77832', coordinators_id: 1},
              {HouseName: 'Mercy House 2', HouseAddress: '234 Houston Street', HouseCity: 'Houston', HouseState: 'TX', HouseZip: '77832', coordinators_id: 1},
              {HouseName: 'Mercy House 3', HouseAddress: '345 Houston Street', HouseCity: 'Houston', HouseState: 'TX', HouseZip: '77832', coordinators_id: 2},
              {HouseName: 'Mercy House 4', HouseAddress: '456 Houston Street', HouseCity: 'Houston', HouseState: 'TX', HouseZip: '77832', coordinators_id: 2}]


mercyhomes.each do |mercyhome|
  Mercyhome.create!(mercyhome)
end

mercyrooms = [{mercyhomes_id: 1, RoomName: 'Downstairs Bedroom', RoomDesc: 'Queen Bed, 1 bath, TV included.', firstfloor: true},
              {mercyhomes_id: 1, RoomName: 'Upstairs Bedroom', RoomDesc: '2 Full Beds, 1 bath, Radio included.', firstfloor: false},
              {mercyhomes_id: 1, RoomName: 'Basement Bedroom', RoomDesc: 'Full Bed, 1 bath, No windows.', firstfloor: false},
              {mercyhomes_id: 2, RoomName: 'Downstairs Bed 1', RoomDesc: 'King Bed, Master bath, TV included.', firstfloor: true},
              {mercyhomes_id: 2, RoomName: 'Upstairs Bed 1', RoomDesc: 'Full Bed, Jack and Jill.', firstfloor: false},
              {mercyhomes_id: 2, RoomName: 'Upstairs Bed 2', RoomDesc: 'Full Bed, Jack and Jill.', firstfloor: false},
              {mercyhomes_id: 3, RoomName: 'Upstairs Bed 1', RoomDesc: 'King Bed, full bath, TV included.', firstfloor: false},
              {mercyhomes_id: 3, RoomName: 'Upstairs Bed 2', RoomDesc: 'Queen Bed, half bath.', firstfloor: false},
              {mercyhomes_id: 4, RoomName: 'Guest house Bed', RoomDesc: 'King Bed, full bath, TV included.', firstfloor: true},
              {mercyhomes_id: 4, RoomName: 'Basement Bedroom', RoomDesc: 'King bed, full bath, TV included.', firstfloor: false}]


mercyrooms.each do |mercyroom|
  Mercyroom.create!(mercyroom)
end

applicants = [
    {AName: 'Alex Davis', AMinor: false, AAge: 19, SPName: 'Parent Smith', SPHomePhone: '979-867-5309', AEmail: 'name@example.com', BackgroundCheckCompleted: true, BackgroundCheckDate: "2019-04-08"},
    {AName: 'Brian McNaughton', AMinor: true, AAge: 12, SPName: 'Parent McNaughton', SPHomePhone: '979-867-5209', AEmail: 'name2@example.com', redFlag: true},
    {AName: 'Katie Fairbanks', AMinor: false, AAge: 21, SPName: 'Parent Fairbanks', SPHomePhone: '979-867-5309', AEmail: 'name3@example.com', BackgroundCheckCompleted: true, BackgroundCheckDate: "2019-04-08"},
    {AName: 'Austin Miller', AMinor: false, AAge: 21, SPName: 'Parent Miller', SPHomePhone: '979-867-5409', AEmail: 'name4@example.com', BackgroundCheckCompleted: true, BackgroundCheckDate: "2019-04-08"},
    {AName: 'Isaac Oviedo', AMinor: true, AAge: 15, SPName: 'Parent Oviedo', SPHomePhone: '979-867-5509', AEmail: 'name5@example.com', BackgroundCheckCompleted: true, BackgroundCheckDate: "2019-03-08"},
    {AName: 'Nick Nelson', AMinor: false, AAge: 21, SPName: 'Parent Nelson', SPHomePhone: '979-867-5609', AEmail: 'name6@example.com', BackgroundCheckCompleted: true, BackgroundCheckDate: "2017-02-08"},
    {AName: 'Dillon Busker', AMinor: false, AAge: 21, SPName: 'Parent Busker', SPHomePhone: '979-867-5709', AEmail: 'name7@example.com'}]


applicants.each do |applicant|
  Applicant.create!(applicant)
end

applications = [{applicants_id: 1, ApplicationDate: "2019-01-01", booked: true, ArrivalDate: "2019-01-03", DepartureDate: "2019-01-07", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 2, ApplicationDate: "2019-02-05", ArrivalDate: "2019-01-06", DepartureDate: "2019-01-10", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 3, ApplicationDate: "2019-02-06", booked: true, ArrivalDate: "2019-01-12", DepartureDate: "2019-01-18", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 4, ApplicationDate: "2019-02-07", booked: true, ArrivalDate: "2019-01-15", DepartureDate: "2019-01-17", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 4, ApplicationDate: "2019-02-08", booked: true, ArrivalDate: "2019-01-22", DepartureDate: "2019-01-24", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},

                {applicants_id: 1, ApplicationDate: "2019-01-01", booked: true, ArrivalDate: "2019-02-03", DepartureDate: "2019-02-07", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 2, ApplicationDate: "2019-02-05", ArrivalDate: "2019-02-06", DepartureDate: "2019-02-10", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 3, ApplicationDate: "2019-02-06", booked: true, ArrivalDate: "2019-02-12", DepartureDate: "2019-02-18", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 4, ApplicationDate: "2019-02-07", booked: true, ArrivalDate: "2019-02-15", DepartureDate: "2019-02-17", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 4, ApplicationDate: "2019-02-08", booked: true, ArrivalDate: "2019-02-22", DepartureDate: "2019-02-24", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},

                {applicants_id: 1, ApplicationDate: "2019-01-01", booked: true, ArrivalDate: "2019-03-03", DepartureDate: "2019-03-07", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 2, ApplicationDate: "2019-02-05", ArrivalDate: "2019-03-06", DepartureDate: "2019-03-10", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 3, ApplicationDate: "2019-02-06", booked: true, ArrivalDate: "2019-03-12", DepartureDate: "2019-03-18", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 4, ApplicationDate: "2019-02-07", booked: true, ArrivalDate: "2019-03-15", DepartureDate: "2019-03-17", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 4, ApplicationDate: "2019-02-08", booked: true, ArrivalDate: "2019-03-22", DepartureDate: "2019-03-24", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},

                {applicants_id: 1, ApplicationDate: "2019-01-01", booked: true, ArrivalDate: "2019-04-03", DepartureDate: "2019-04-07", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 2, ApplicationDate: "2019-02-05", ArrivalDate: "2019-04-06", DepartureDate: "2019-04-10", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 3, ApplicationDate: "2019-02-06", booked: true, ArrivalDate: "2019-04-12", DepartureDate: "2019-04-18", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 4, ApplicationDate: "2019-02-07", booked: true, ArrivalDate: "2019-04-15", DepartureDate: "2019-04-17", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 4, ApplicationDate: "2019-02-08", booked: true, ArrivalDate: "2019-04-22", DepartureDate: "2019-04-24", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},

                {applicants_id: 1, ApplicationDate: "2019-01-01", booked: true, ArrivalDate: "2019-05-03", DepartureDate: "2019-05-07", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 2, ApplicationDate: "2019-02-05", ArrivalDate: "2019-05-06", DepartureDate: "2019-05-10", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 3, ApplicationDate: "2019-02-06", booked: true, ArrivalDate: "2019-05-12", DepartureDate: "2019-05-18", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 4, ApplicationDate: "2019-02-07", booked: true, ArrivalDate: "2019-05-15", DepartureDate: "2019-05-17", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 4, ApplicationDate: "2019-02-08", booked: true, ArrivalDate: "2019-05-22", DepartureDate: "2019-05-24", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},

                {applicants_id: 1, ApplicationDate: "2019-01-01", booked: true, ArrivalDate: "2019-06-03", DepartureDate: "2019-06-07", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 2, ApplicationDate: "2019-02-05", ArrivalDate: "2019-06-06", DepartureDate: "2019-06-10", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 3, ApplicationDate: "2019-02-06", booked: true, ArrivalDate: "2019-06-12", DepartureDate: "2019-06-18", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 4, ApplicationDate: "2019-02-07", booked: true, ArrivalDate: "2019-06-15", DepartureDate: "2019-06-17", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'},
                {applicants_id: 4, ApplicationDate: "2019-02-08", booked: true, ArrivalDate: "2019-06-22", DepartureDate: "2019-06-24", HospitalName: 'Memorial Hermann', DoctorName: 'Dr. Pepper'}]

applications.each do |application|
  Application.create!(application)
end

bookings = [{applicants_id: 1, application_id: 1, mercyrooms_id: 1, StartDate: "2019-01-03", EndDate: "2019-01-07"},
            {applicants_id: 3, application_id: 3, mercyrooms_id: 4, StartDate: "2019-01-12", EndDate: "2019-01-18"},
            {applicants_id: 4, application_id: 4, mercyrooms_id: 7, StartDate: "2019-01-15", EndDate: "2019-01-17"},
            {applicants_id: 4, application_id: 5, mercyrooms_id: 7, StartDate: "2019-01-22", EndDate: "2019-01-24"},

            {applicants_id: 1, application_id: 6, mercyrooms_id: 1, StartDate: "2019-02-03", EndDate: "2019-02-07"},
            {applicants_id: 3, application_id: 8, mercyrooms_id: 4, StartDate: "2019-02-12", EndDate: "2019-02-18"},
            {applicants_id: 4, application_id: 9, mercyrooms_id: 7, StartDate: "2019-02-15", EndDate: "2019-02-17"},
            {applicants_id: 4, application_id: 10, mercyrooms_id: 7, StartDate: "2019-02-22", EndDate: "2019-02-24"},

            {applicants_id: 1, application_id: 11, mercyrooms_id: 1, StartDate: "2019-03-03", EndDate: "2019-03-07"},
            {applicants_id: 3, application_id: 13, mercyrooms_id: 4, StartDate: "2019-03-12", EndDate: "2019-03-18"},
            {applicants_id: 4, application_id: 14, mercyrooms_id: 7, StartDate: "2019-03-15", EndDate: "2019-03-17"},
            {applicants_id: 4, application_id: 15, mercyrooms_id: 7, StartDate: "2019-03-22", EndDate: "2019-03-24"},

            {applicants_id: 1, application_id: 16, mercyrooms_id: 1, StartDate: "2019-04-03", EndDate: "2019-04-07"},
            {applicants_id: 3, application_id: 18, mercyrooms_id: 4, StartDate: "2019-04-12", EndDate: "2019-04-18"},
            {applicants_id: 4, application_id: 19, mercyrooms_id: 7, StartDate: "2019-04-15", EndDate: "2019-04-17"},
            {applicants_id: 4, application_id: 20, mercyrooms_id: 7, StartDate: "2019-04-22", EndDate: "2019-04-24"},

            {applicants_id: 1, application_id: 21, mercyrooms_id: 1, StartDate: "2019-05-03", EndDate: "2019-05-07"},
            {applicants_id: 3, application_id: 23, mercyrooms_id: 4, StartDate: "2019-05-12", EndDate: "2019-05-18"},
            {applicants_id: 4, application_id: 24, mercyrooms_id: 7, StartDate: "2019-05-15", EndDate: "2019-05-17"},
            {applicants_id: 4, application_id: 25, mercyrooms_id: 7, StartDate: "2019-05-22", EndDate: "2019-05-24"},

            {applicants_id: 1, application_id: 26, mercyrooms_id: 1, StartDate: "2019-06-03", EndDate: "2019-06-07"},
            {applicants_id: 3, application_id: 28, mercyrooms_id: 4, StartDate: "2019-06-12", EndDate: "2019-06-18"},
            {applicants_id: 4, application_id: 29, mercyrooms_id: 7, StartDate: "2019-06-15", EndDate: "2019-06-17"},
            {applicants_id: 4, application_id: 30, mercyrooms_id: 7, StartDate: "2019-06-22", EndDate: "2019-06-24"}]

bookings.each do |booking|
  Booking.create!(booking)
end

# Add your facebook UIDs here.
# I wasn't able to test with google because I kept getting a client error. Not sure what was wrong there.
users = [{provider: "facebook", uid: 1929629563814075, role: "admin"}, # Brian
         {provider: "facebook", uid: 2058231404232400, role: "admin"}, # Isaac
         {provider: "facebook", uid: 2166141013450945, role: "admin"}, # Alex
         {provider: "facebook", uid: 2199416776801814, role: "admin"}, # Nick
         {provider: "facebook", uid: 10220265053162365, role: "admin"}, # Katie
         {provider: "facebook", uid: 110786523432741, role: "admin"}, # Test Admin
         {provider: "facebook", uid: 107809997065654, role: "", applicantid: Applicant.first.id}, # Test User
         {provider: "facebook", uid: 178099970645654, role: ""}, # Test User
         {provider: "facebook", uid: 1780999705655654, role: ""}, # Test User
         {provider: "facebook", uid: 1780999740656654, role: ""}, # Test User
         {provider: "facebook", uid: 108099970656574, role: ""}, # Test User
         {provider: "facebook", uid: 107099970656548, role: ""}, # Test User
         {provider: "facebook", uid: 107809970656594, role: ""}, # Test User
         {provider: "facebook", uid: 107809990656504, role: ""}, # Test User
         {provider: "facebook", uid: 107809970661514, role: ""}, # Test User

]

users.each do |u|
  User.create!(u)
end
