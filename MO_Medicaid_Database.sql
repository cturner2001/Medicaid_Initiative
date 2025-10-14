-- Updated Applicant
-- Updated Employment
-- Updated Application
-- Updated RequiredDocuments
-- Updated SumbittedDocuments
-- Updated AuditLog
-- Added LegalStatus
-- Fixed invalid Attribute Types
-- Updated by Cindy Turner on 10/14/2025

CREATE TABLE Applicant (
	UserID               INT             PRIMARY Key,
	FirstName            VARCHAR(50),
	LastName             VARCHAR(50),
	DateOfBirth          DATE,
	Address              VARCHAR(100),
	City                 VARCHAR(50),
	USState              VARCHAR(50),
	ZipCode              VARCHAR(10),
	MOCounty             VARCHAR(30),
);

CREATE TABLE Staff (
	StaffID              INT             PRIMARY Key,
	FirstName            VARCHAR(50),
	LastName             VARCHAR(50),
	Role                 VARCHAR(20)
);

CREATE TABLE Demographics (
	UserID               INT             PRIMARY Key,
	IsDisabled           TINYINT(1),
	IsVeteran            TINYINT(1),
	IsChild              TINYINT(1),
	IsElderly            TINYINT(1),
	IsPregnant           TINYINT(1),
	IsTribal             TINYINT(1),
	IsCaregiver          TINYINT(1),
	
	FOREIGN KEY (UserID)         REFERENCES Applicant(UserID)
);

CREATE TABLE Employment (
	EmploymentID         INT             PRIMARY KEY,
	UserID               INT,
	EmploymentStatus     VARCHAR(20),
	EmployerName         VARCHAR(100),
	HoursPerWeek         INT,
	DateVerified         DATE,
	IsRecurringVerify    TINYINT(1),
	
	FOREIGN KEY (UserID)           REFERENCES Applicant(UserID)
);

CREATE TABLE Unemployment (
	UnemploymentID       INT             PRIMARY KEY,
	UserID               INT,
	ApplicationDate      DATE,
	CompanyName          VARCHAR(100),
	JobTitle             VARCHAR(100),
	StaffID              INT,
	DateVerified         DATE,
	VerificationStatus   VARCHAR(20),
	VerificationNotes    TEXT,
	
	FOREIGN KEY (UserID)           REFERENCES Applicant(UserID),
	FOREIGN KEY (StaffID)          REFERENCES Staff(StaffID)
);

CREATE TABLE Application (
	ApplicationID        INT             PRIMARY KEY,
	UserID               INT,
	SubmissionDate       DATETIME,
	Status               VARCHAR(20),
	CaseWorkerID         INT,
	MedicaidNumber       VARCHAR(20),
	VerifyDueDate        DATE,
	
	FOREIGN KEY (UserID)           REFERENCES Applicant(UserID),
	FOREIGN KEY (CaseWorkerID)     REFERENCES Staff(StaffID),
);

CREATE TABLE RequiredDocuments (
	DocID                INT             PRIMARY KEY,
	DocName              VARCHAR(100),
	IsRecurring          TINYINT(1),
	AppliesTo            VARCHAR(50),
	SecurityLevel        VARCHAR(50),
	Description          TEXT
):

CREATE TABLE SubmittedDocuments (
	SubmissionID         INT             PRIMARY KEY,
	ApplicationID        INT,
	DocID                INT,
	DateSubmitted        DATE,
	IsVerified           TINYINT(1),
	VerifiedBy           INT,
	LastReviewed         DATE,
	
	FOREIGN KEY (ApplicationID)    REFERENCES Application(ApplicationID),
	FOREIGN KEY (DocID)            REFERENCES RequiredDocuments(DocID),
	FOREIGN Key (VerifiedBy)       REFERENCES Staff(StaffID)
);

CREATE TABLE AuditLog (
	LogID                INT             PRIMARY KEY,
	ApplicationID        INT,
	StaffID              INT,
	ChangeDate           DATE,
	Description          TEXT,
	ActionType           VARCHAR(50),
	
	FOREIGN KEY (ApplicationID)    REFERENCES Application(ApplicationID),
	FOREIGN KEY (StaffID)          REFERENCES Staff(StaffID)
);

CREATE TABLE LegalStatus (
	UserID               INT             PRIMARY KEY,
	CitizenshipStatus    VARCHAR(30),
	LegalIDType          VARCHAR(50),
	LegalIDNumber        VARCHAR(50),
	
	FOREIGN KEY (UserID)           REFERENCES Applicant(UserID)
);