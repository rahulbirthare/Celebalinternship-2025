WITH RECURSIVE FolderHierarchy AS (
    -- Base case: all folders
    SELECT NodeID, ParentID, NodeName, 0 AS SizeBytes
    FROM FileSystem
    WHERE NodeType = 'folder'
    
    UNION ALL
    
    -- Recursive case: files contribute to parent folders
    SELECT fh.NodeID, fh.ParentID, fh.NodeName, fs.SizeBytes
    FROM FolderHierarchy fh
    JOIN FileSystem fs ON fs.ParentID = fh.NodeID
    WHERE fs.NodeType = 'file'
)

SELECT 
    f.NodeID,
    f.NodeName,
    f.NodeType,
    COALESCE(SUM(fh.SizeBytes), 0) AS TotalSizeBytes,
    COUNT(DISTINCT CASE WHEN fs.NodeType = 'file' THEN fs.NodeID END) AS FileCount,
    COUNT(DISTINCT CASE WHEN fs.NodeType = 'folder' THEN fs.NodeID END) AS FolderCount
FROM FileSystem f
LEFT JOIN FolderHierarchy fh ON fh.NodeID = f.NodeID
LEFT JOIN FileSystem fs ON fs.ParentID = f.NodeID
WHERE f.NodeType = 'folder'
GROUP BY f.NodeID, f.NodeName, f.NodeType
ORDER BY f.NodeID;