-- Steps to Create Vector Extension

-- 1.git clone https://github.com/pgvector/pgvector.git
-- 2. cd pgvector
-- 3. Search for x64 Native Tools Command Prompt for VS
-- 4. Navigate to te cloaned folder for pgvector
-- 5. Run the following command 
-- To run he nmake command, we need to set the path for PGROOT, so do the following
-- Run the following command from x64 Native Tools Command prompt for VS
-- set PGROOT=C:\Program Files\PostgreSQL\17 (or version of pgsql)
-- nmake /F Makefile.win install
-- This will create following files in the cloaned project folder
-- in 'lib' folder files created are, vector.dll, vector.contol
-- in the 'sql' folder file created is vector--*.sql
-- here the * is the versoin number, in our case it is vector--0.8.1.sql
-- the nmake command shall copy the generated files i.e. vector.dll, vector.control, and vector--*.sql to the 
-- :\Program Files\PostgreSQL\<version>\lib and C:\Program Files\PostgreSQL\<version>\share\extension paths
-- if not copied, then copy manually as follows

--From build folder (e.g., pgvector\)

--To PostgreSQL directories:

--vector.dll → C:\Program Files\PostgreSQL\<version>\lib

--vector.control and vector--*.sql → C:\Program Files\PostgreSQL\<version>\share\extension

-- An then finally run the following command to create vector extension

CREATE EXTENSION vector;

Create Extension hstore;

Create extension pg_trgm;


-- List of Extension 

SELECT * FROM pg_available_extensions;

