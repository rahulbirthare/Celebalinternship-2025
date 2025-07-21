-- Performance optimization indexes
CREATE INDEX idx_filesystem_parent ON FileSystem(ParentID);
CREATE INDEX idx_filesystem_owner ON FileSystem(OwnerID);
CREATE INDEX idx_filesystem_type ON FileSystem(NodeType);
CREATE INDEX idx_permissions_node_user ON Permissions(NodeID, UserID);
CREATE INDEX idx_fileversions_file ON FileVersions(FileID);
CREATE INDEX idx_trash_expires ON Trash(ExpiresAt);