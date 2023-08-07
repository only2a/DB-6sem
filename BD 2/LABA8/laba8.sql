---1
drop tablespace blob_lab;
CREATE TABLESPACE blob_lab
    DATAFILE 'tbs_BLOB2.dbf'
    SIZE 1000 m
    AUTOEXTEND ON NEXT 500M
    MAXSIZE 2000M
    EXTENT MANAGEMENT LOCAL;

SELECT tablespace_name
FROM dba_tablespaces;

--2
create directory bfile_dir as '/opt/oracle/blobs';


drop directory bfile_dir;

select * from all_directories;

drop DIRECTORY bfile_dir;
--3
select * from V$PDBS;


alter session set container = XEPDB1;

CREATE USER lob_user IDENTIFIED BY 12345
    DEFAULT TABLESPACE blob_lab QUOTA UNLIMITED ON blob_lab
    ACCOUNT UNLOCK;

grant create table to lob_user;
grant create session, CREATE ANY DIRECTORY, DROP ANY DIRECTORY to lob_user;
grant all privileges to lob_user;
--5
drop table blob_t;
create table blob_t (
    id number primary key not null,
    foto blob,
    doc bfile
    );

--6
SELECT * FROM ALL_DIRECTORIES WHERE DIRECTORY_NAME = 'BFILE_DIR';
GRANT READ, WRITE ON DIRECTORY bfile_dir TO lob_user;



declare
fHnd bfile;
b blob;
srcOffset integer := 1;
dstOffset integer := 1;
begin
dbms_lob.CreateTemporary( b, true );
fHnd := BFilename( 'bfile_dir', 'Anne.jpg' );
dbms_lob.FileOpen( fHnd, DBMS_LOB.FILE_READONLY );
dbms_lob.LoadFromFile( b, fHnd, DBMS_LOB.LOBMAXSIZE, dstOffset, srcOffset );
insert into blob_t values(2, b, BFILENAME( 'bfile_dir', 'TEST.docx'));
commit;
dbms_lob.FileClose( fHnd );
end;

DECLARE
  l_blob BLOB;
  l_bfile BFILE;
BEGIN
  -- Insert the photo
  INSERT INTO blob_t (id, foto)
  VALUES (1, EMPTY_BLOB())
  RETURNING foto INTO l_blob;

  -- Open the BFILE and read its contents
  l_bfile := BFILENAME('BFILE_DIR', 'Anne.jpg');
  DBMS_LOB.OPEN(l_bfile, DBMS_LOB.LOB_READONLY);
  DBMS_LOB.LOADFROMFILE(l_blob, l_bfile, DBMS_LOB.LOBMAXSIZE);
  DBMS_LOB.CLOSE(l_bfile);

  -- Commit the transaction
  COMMIT;
END;

DECLARE
  l_bfile BFILE;
BEGIN
  -- Insert the document
  INSERT INTO blob_t (id, doc)
  VALUES (2, BFILENAME('BFILE_DIR', 'TEST.docx'));

  -- Commit the transaction
  COMMIT;
END;

--check
select * from blob_t;
select * from all_directories;
