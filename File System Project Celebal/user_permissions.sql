DELIMITER //

CREATE FUNCTION CheckPermission(
    p_user_id INT,
    p_node_id INT,
    p_permission VARCHAR(10)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE result BOOLEAN;
    
    -- Check direct permissions
    SELECT CASE p_permission
        WHEN 'read' THEN CanRead
        WHEN 'write' THEN CanWrite
        WHEN 'execute' THEN CanExecute
        WHEN 'delete' THEN CanDelete
    END INTO result
    FROM Permissions
    WHERE UserID = p_user_id AND NodeID = p_node_id;
    
    -- If no direct permissions, check parent folder permissions
    IF result IS NULL THEN
        SELECT CheckPermission(
            p_user_id, 
            (SELECT ParentID FROM FileSystem WHERE NodeID = p_node_id),
            p_permission
        ) INTO result;
    END IF;
    
    RETURN COALESCE(result, FALSE);
END //

DELIMITER ;