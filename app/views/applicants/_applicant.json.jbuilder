json.extract! applicant, :id, :AName, :AMinor, :AAge, :CareGiverID, :CGName, :CGHomePhone, :CGCellPhone, :CGAddress, :CGCity, :CGState, :CGZip, :CGEmail, :SPName, :SPHomePhone, :SPCellPhone, :SPAddress, :SPCity, :SPState, :SPZip, :SPEmail, :EC1Name, :EC1HomePhone, :EC1CellPhone, :EC1Address, :EC1City, :EC1State, :EC1Zip, :EC1Email, :EC2Name, :EC2HomePhone, :EC2CellPhone, :EC2Address, :EC2City, :EC2State, :EC2Zip, :EC2Email, :allowsUseOfName, :redFlag, :created_at, :updated_at
json.url applicant_url(applicant, format: :json)
