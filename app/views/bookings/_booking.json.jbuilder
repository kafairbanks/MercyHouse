json.extract! booking, :id, :applicants_id, :mercyrooms_id, :StartDate, :EndDate, :created_at, :updated_at
json.url booking_url(booking, format: :json)
