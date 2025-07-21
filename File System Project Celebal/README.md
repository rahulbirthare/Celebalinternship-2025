📌 Overview
A SQL-based hierarchical file system that stores files and folders, calculates folder sizes recursively, manages user permissions, tracks file versions, and includes a trash system for safe deletions.

✨ Features
✔ File & Folder Management – Store, organize, and query files in a tree structure.
✔ Recursive Size Calculation – Computes total size of folders (including subfolders).
✔ User Permissions – Control access with read/write/delete permissions.
✔ Version History – Track changes and restore previous file versions.
✔ Trash System – Recover deleted files before permanent removal.
✔ Metadata Tracking – File types, extensions, checksums, and timestamps.

⚙️ Setup Instructions
1. Database Setup
Run the SQL scripts in this order:

bash
1. database_schema.sql    # Creates tables & relationships  
2. sample_data.sql       # Inserts test data  
3. indexes.sql           # Adds performance optimizations  





2. Key Scripts
File	Purpose
folder_size_calculator.sql	Computes folder sizes recursively
permission_manager.sql	Handles user access controls
file_versioning.sql	Manages file history & rollbacks
trash_system.sql	Implements safe file deletion




📂 Sample Queries
Get Folder Sizes
sql
WITH RECURSIVE FolderSizes AS (...)
SELECT NodeID, NodeName, SizeBytes FROM FileSystem;
Check User Permissions
sql
SELECT CheckPermission(1, 5, 'read'); -- Returns TRUE/FALSE



View File Versions
sql
SELECT * FROM FileVersions WHERE FileID = 3 ORDER BY VersionNumber DESC;



📊 Example Output
Folder Sizes:

NodeID	NodeName	SizeBytes
1	Documents	1550
2	Pictures	1450



File Versions:

VersionID	FileID	Size	ModifiedAt
1	3	500	2025-07-22 10:00:00



🚀 Future Improvements
🔹 File Search – Add full-text search for file contents.
🔹 Sharing – Allow users to share files with others.
🔹 Compression – Support for compressed file storage.

📜 License
MIT License - Free for personal and commercial use.


Name: Rahul Birthare
Batch: 02/06/2025-03/08/2025(SQL)
StudentId:  CT_CSI_SQ_4733
📧 Contact: [0173cs221097@gmail.com]
Mobile no,: 7566301524