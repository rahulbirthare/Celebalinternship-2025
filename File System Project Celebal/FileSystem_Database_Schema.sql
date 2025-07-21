-- Create database
CREATE DATABASE FileSystemDB;
USE FileSystemDB;

-- Users table
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    LastLogin DATETIME
);

-- FileSystem table (expanded)
CREATE TABLE FileSystem (
    NodeID INT PRIMARY KEY AUTO_INCREMENT,
    NodeName VARCHAR(255) NOT NULL,
    ParentID INT,
    NodeType ENUM('file', 'folder') NOT NULL,
    SizeBytes BIGINT,
    OwnerID INT NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    ModifiedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    IsHidden BOOLEAN DEFAULT FALSE,
    IsSystem BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (ParentID) REFERENCES FileSystem(NodeID),
    FOREIGN KEY (OwnerID) REFERENCES Users(UserID),
    CHECK ((NodeType = 'file' AND SizeBytes IS NOT NULL) OR 
           (NodeType = 'folder' AND SizeBytes IS NULL))
);

-- File metadata table
CREATE TABLE FileMetadata (
    FileID INT PRIMARY KEY,
    MimeType VARCHAR(100),
    FileExtension VARCHAR(20),
    Checksum VARCHAR(64),
    FOREIGN KEY (FileID) REFERENCES FileSystem(NodeID)
);

-- Permissions table
CREATE TABLE Permissions (
    PermissionID INT PRIMARY KEY AUTO_INCREMENT,
    NodeID INT NOT NULL,
    UserID INT NOT NULL,
    CanRead BOOLEAN DEFAULT FALSE,
    CanWrite BOOLEAN DEFAULT FALSE,
    CanExecute BOOLEAN DEFAULT FALSE,
    CanDelete BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (NodeID) REFERENCES FileSystem(NodeID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    UNIQUE KEY (NodeID, UserID)
);

-- Version history
CREATE TABLE FileVersions (
    VersionID INT PRIMARY KEY AUTO_INCREMENT,
    FileID INT NOT NULL,
    VersionNumber INT NOT NULL,
    SizeBytes BIGINT NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL,
    StoragePath VARCHAR(255) NOT NULL,
    FOREIGN KEY (FileID) REFERENCES FileSystem(NodeID),
    FOREIGN KEY (ModifiedBy) REFERENCES Users(UserID)
);

-- Trash/recycle bin
CREATE TABLE Trash (
    TrashID INT PRIMARY KEY AUTO_INCREMENT,
    NodeID INT NOT NULL,
    OriginalPath TEXT NOT NULL,
    DeletedBy INT NOT NULL,
    DeletedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    ExpiresAt DATETIME,
    FOREIGN KEY (NodeID) REFERENCES FileSystem(NodeID),
    FOREIGN KEY (DeletedBy) REFERENCES Users(UserID)
);