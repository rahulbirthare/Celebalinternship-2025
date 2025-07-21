-- Procedure to create new version
DELIMITER //

CREATE PROCEDURE CreateFileVersion(
    IN p_file_id INT,
    IN p_user_id INT,
    IN p_size_bytes BIGINT,
    IN p_storage_path VARCHAR(255)
)
BEGIN
    DECLARE next_version INT;
    
    -- Get next version number
    SELECT COALESCE(MAX(VersionNumber), 0) + 1 INTO next_version
    FROM FileVersions
    WHERE FileID = p_file_id;
    
    -- Insert new version
    INSERT INTO FileVersions (FileID, VersionNumber, SizeBytes, ModifiedBy, StoragePath)
    VALUES (p_file_id, next_version, p_size_bytes, p_user_id, p_storage_path);
    
    -- Update file size
    UPDATE FileSystem
    SET SizeBytes = p_size_bytes, ModifiedAt = CURRENT_TIMESTAMP
    WHERE NodeID = p_file_id;
END //

DELIMITER ;