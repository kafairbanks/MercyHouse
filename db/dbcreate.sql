PRAGMA foreign_keys = ON;

CREATE TABLE applicants (
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	AName varchar(40) NOT NULL,
	AEmail varchar(200) NOT NULL,
	AMinor boolean,
	AAge int,
	CareGiverID int,
	CGName varchar(40),
	CGHomePhone varchar(15),
	CGCellPhone varchar(15),
	CGAddress varchar(100),
	CGCity varchar(40),
	CGState varchar(40),
	CGZip varchar(10),
	CGEmail varchar(20),   
	SPName varchar(40),
	SPHomePhone varchar(15),
	SPCellPhone varchar(15),
	SPAddress varchar(100),
	SPCity varchar(40),
	SPState varchar(40),
	SPZip varchar(10),
	SPEmail varchar(20),
	EC1Name varchar(40),
	EC1HomePhone varchar(15),
	EC1CellPhone varchar(15),
	EC1Address varchar(100),
	EC1City varchar(40),
	ECIState varchar(10),
	EC1Zip varchar(10),
	EC1Email varchar(20),
	EC2Name varchar(40),
	EC2HomePhone varchar(15),
	EC2CellPhone varchar(15),
	EC2Address varchar(100),
	EC2City varchar(40),    
	EC2State varchar(10),
	EC2Zip varchar(10),
	EC2Email varchar(20),
	allowsUseOfName boolean,
	redFlag boolean NOT NULL DEFAULT FALSE
);

CREATE TABLE applications (
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	applicants_id INTEGER NOT NULL,
	ApplicationDate datetime,
	ApplicationStatus varchar(40) DEFAULT 'Submitted',
	HospitalName varchar(100),
	DoctorName varchar(100),
	TreatmentPlan varchar(100),
	appliedForLongTermHousing boolean,
	whereLongTermHousing varchar(100),
	prayerRequests varchar(200),
	isFirstVisit boolean,
	wantsInfo boolean,
	insuranceCoversHousing boolean,
	futureScheduledAppts varchar(200),
	ArrivalDate datetime,
	DepartureDate datetime,
	lockApplication boolean NOT NULL DEFAULT TRUE,
	FOREIGN KEY (applicants_id) REFERENCES applicants(id)
);

CREATE TABLE mercyrooms (
	id  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	mercyhomes_id int NOT NULL,
	RoomName varchar(100) NOT NULL,
	RoomDesc varchar(200),
	FOREIGN KEY (mercyhomes_id) REFERENCES mercyhomes(id)                    
);

CREATE TABLE mercyhomes (
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	HouseName varchar(100) NOT NULL,
	HouseAddress varchar(100),
	HouseCity varchar(40),
	HouseState varchar(40),
	HouseZip varchar(10),
	coordinators_id INTEGER NOT NULL,
	FOREIGN KEY (coordinators_id) REFERENCES coordinators(id)
);

CREATE TABLE coordinators (
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	HCName varchar(40) NOT NULL,
	HCPhone varchar(15),
	HCEmail varchar(100)
);

CREATE TABLE bookings (
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	applicants_id INTEGER NOT NULL,
	mercyrooms_id INTEGER NOT NULL,    
	StartDate datetime,
	EndDate datetime,    
	FOREIGN KEY (applicants_id) REFERENCES applicants(id)
	FOREIGN KEY (mercyrooms_id) REFERENCES mercyrooms(id)
);

CREATE TABLE admins (
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	AdminUsername INTEGER NOT NULL,
	AdminPass varchar(200)
);
