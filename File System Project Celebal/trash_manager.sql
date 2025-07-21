-- Procedure to move to trash
DELIMITER //

CREATE PROCEDURE MoveToTrash(
    IN p_node_id INT,
    IN p_user_id INT,
    IN p_expiry_days INT
)
BEGIN
    DECLARE original_path TEXT;
    
    -- Get original path
    WITH RECURSIVE PathCTE AS (
        SELECT NodeID, ParentID, NodeName
        FROM FileSystem
        WHERE NodeID = p_node_id
        
        UNION ALL
        
        SELECT fs.NodeID, fs.ParentID, fs.NodeName
        FROM FileSystem fs
        JOIN PathCTE p ON fs.NodeID = p.ParentID
    )
    SELECT GROUP_CONCAT(NodeName ORDER BY NodeID SEPARATOR '/') INTO original_path
    FROM PathCTE;
    
    -- Insert into trash
    INSERT INTO Trash (NodeID, OriginalPath, DeletedBy, ExpiresAt)
    VALUES (p_node_id, original_path, p_user_id, 
            DATE_ADD(CURRENT_TIMESTAMP, INTERVAL p_expiry_days DAY));
    
    -- Remove from filesystem (cascade will handle permissions/metadata)
    DELETE FROM FileSystem WHERE NodeID = p_node_id;
END //

DELIMITER ;