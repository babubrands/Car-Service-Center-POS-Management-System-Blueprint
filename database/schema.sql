PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS Customers (
    CustomerID      INTEGER PRIMARY KEY AUTOINCREMENT,
    Name            TEXT NOT NULL,
    Phone           TEXT NOT NULL,
    Email           TEXT,
    Address         TEXT,
    CreatedAt       TEXT NOT NULL DEFAULT (datetime('now')),
    UpdatedAt       TEXT
);

CREATE TABLE IF NOT EXISTS Vehicles (
    VehicleID        INTEGER PRIMARY KEY AUTOINCREMENT,
    CustomerID       INTEGER NOT NULL,
    PlateNumber      TEXT NOT NULL UNIQUE,
    Model            TEXT NOT NULL,
    Year             INTEGER,
    EngineNumber     TEXT,
    ChassisNumber    TEXT,
    CreatedAt        TEXT NOT NULL DEFAULT (datetime('now')),
    UpdatedAt        TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Technicians (
    TechID           INTEGER PRIMARY KEY AUTOINCREMENT,
    Name             TEXT NOT NULL,
    Specialty        TEXT,
    Phone            TEXT,
    IsActive         INTEGER NOT NULL DEFAULT 1,
    CreatedAt        TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS ServiceJobs (
    JobID            INTEGER PRIMARY KEY AUTOINCREMENT,
    VehicleID        INTEGER NOT NULL,
    TechID           INTEGER,
    ServiceType      TEXT NOT NULL,
    Complaint        TEXT,
    InspectionNotes  TEXT,
    Status           TEXT NOT NULL CHECK (Status IN ('Pending','In Progress','Waiting for Parts','Completed','Delivered')),
    LabourCost       REAL NOT NULL DEFAULT 0,
    JobDate          TEXT NOT NULL DEFAULT (datetime('now')),
    CompletedDate    TEXT,
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID) ON DELETE RESTRICT,
    FOREIGN KEY (TechID) REFERENCES Technicians(TechID) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS ServiceCheckItems (
    CheckItemID      INTEGER PRIMARY KEY AUTOINCREMENT,
    JobID            INTEGER NOT NULL,
    ItemName         TEXT NOT NULL,
    IsChecked        INTEGER NOT NULL DEFAULT 0,
    Notes            TEXT,
    FOREIGN KEY (JobID) REFERENCES ServiceJobs(JobID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Parts (
    PartID           INTEGER PRIMARY KEY AUTOINCREMENT,
    Name             TEXT NOT NULL,
    Barcode          TEXT UNIQUE,
    Category         TEXT,
    Price            REAL NOT NULL,
    StockQty         INTEGER NOT NULL DEFAULT 0,
    ReorderLevel     INTEGER NOT NULL DEFAULT 5,
    CreatedAt        TEXT NOT NULL DEFAULT (datetime('now')),
    UpdatedAt        TEXT
);

CREATE TABLE IF NOT EXISTS JobParts (
    JobPartID        INTEGER PRIMARY KEY AUTOINCREMENT,
    JobID            INTEGER NOT NULL,
    PartID           INTEGER NOT NULL,
    Quantity         INTEGER NOT NULL CHECK (Quantity > 0),
    UnitPrice        REAL NOT NULL,
    FOREIGN KEY (JobID) REFERENCES ServiceJobs(JobID) ON DELETE CASCADE,
    FOREIGN KEY (PartID) REFERENCES Parts(PartID) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Payments (
    PaymentID        INTEGER PRIMARY KEY AUTOINCREMENT,
    JobID            INTEGER NOT NULL,
    Amount           REAL NOT NULL CHECK (Amount >= 0),
    PaymentMethod    TEXT NOT NULL CHECK (PaymentMethod IN ('Cash','Card','Mobile')),
    PaidAt           TEXT NOT NULL DEFAULT (datetime('now')),
    ReferenceNo      TEXT,
    FOREIGN KEY (JobID) REFERENCES ServiceJobs(JobID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Users (
    UserID           INTEGER PRIMARY KEY AUTOINCREMENT,
    Username         TEXT NOT NULL UNIQUE,
    PasswordHash     TEXT NOT NULL,
    Role             TEXT NOT NULL CHECK (Role IN ('Admin','Cashier','Advisor')),
    IsActive         INTEGER NOT NULL DEFAULT 1,
    CreatedAt        TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS Backups (
    BackupID         INTEGER PRIMARY KEY AUTOINCREMENT,
    FilePath         TEXT NOT NULL,
    CreatedByUserID  INTEGER,
    CreatedAt        TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (CreatedByUserID) REFERENCES Users(UserID) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS IX_Customers_Name ON Customers(Name);
CREATE INDEX IF NOT EXISTS IX_Customers_Phone ON Customers(Phone);
CREATE INDEX IF NOT EXISTS IX_Vehicles_CustomerID ON Vehicles(CustomerID);
CREATE INDEX IF NOT EXISTS IX_ServiceJobs_VehicleID ON ServiceJobs(VehicleID);
CREATE INDEX IF NOT EXISTS IX_ServiceJobs_TechID ON ServiceJobs(TechID);
CREATE INDEX IF NOT EXISTS IX_ServiceJobs_Status ON ServiceJobs(Status);
CREATE INDEX IF NOT EXISTS IX_JobParts_JobID ON JobParts(JobID);
CREATE INDEX IF NOT EXISTS IX_JobParts_PartID ON JobParts(PartID);
CREATE INDEX IF NOT EXISTS IX_Payments_JobID ON Payments(JobID);

-- Optional seed template
INSERT INTO Technicians (Name, Specialty, Phone)
SELECT 'Default Technician', 'General Service', 'N/A'
WHERE NOT EXISTS (SELECT 1 FROM Technicians);
