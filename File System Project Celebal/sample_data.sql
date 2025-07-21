-- Insert sample users
INSERT INTO Users (Username, Email, PasswordHash) VALUES
('admin', 'admin@example.com', '$2y$10$examplehash'),
('user1', 'user1@example.com', '$2y$10$examplehash'),
('user2', 'user2@example.com', '$2y$10$examplehash');

-- Insert root folders
INSERT INTO FileSystem (NodeName, ParentID, NodeType, OwnerID) VALUES
('Root', NULL, 'folder', 1),
('Users', 1, 'folder', 1),
('System', 1, 'folder', 1);

-- Insert user home directories
INSERT INTO FileSystem (NodeName, ParentID, NodeType, OwnerID) VALUES
('admin', 3, 'folder', 1),
('user1', 3, 'folder', 2),
('user2', 3, 'folder', 3);

-- Insert sample documents
INSERT INTO FileSystem (NodeName, ParentID, NodeType, SizeBytes, OwnerID) VALUES
('Documents', 4, 'folder', NULL, 1),
('Pictures', 4, 'folder', NULL, 1),
('File1.txt', 7, 'file', 500, 1),
('Folder1', 7, 'folder', NULL, 1),
('Image.jpg', 8, 'file', 1200, 1),
('Subfolder1', 10, 'folder', NULL, 1),
('File2.txt', 10, 'file', 750, 1),
('File3.txt', 12, 'file', 300, 1),
('Folder2', 8, 'folder', NULL, 1),
('File4.txt', 14, 'file', 250, 1);

-- Insert file metadata
INSERT INTO FileMetadata (FileID, MimeType, FileExtension) VALUES
(9, 'text/plain', 'txt'),
(11, 'image/jpeg', 'jpg'),
(13, 'text/plain', 'txt'),
(15, 'text/plain', 'txt'),
(16, 'text/plain', 'txt');

-- Set permissions
INSERT INTO Permissions (NodeID, UserID, CanRead, CanWrite, CanExecute) VALUES
(1, 1, TRUE, TRUE, TRUE),  -- Admin has full access to root
(7, 1, TRUE, TRUE, TRUE),  -- Admin's Documents
(8, 1, TRUE, TRUE, TRUE),  -- Admin's Pictures
(7, 2, TRUE, FALSE, TRUE); -- User1 can read admin's Documents