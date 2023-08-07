

sp_configure 'clr enabled', 1;
RECONFIGURE;





ALTER DATABASE master SET TRUSTWORTHY ON

drop procedure CopyFileProc

CREATE PROCEDURE CopyFileProc
    @sourcePath NVARCHAR(MAX),
    @destinationPath NVARCHAR(MAX)
AS EXTERNAL NAME CopyFileAssembly.[StoredProcedures].CopyFileProc;
GO



EXEC CopyFileProc 'D:\3C_2S\·‰\labs\lab3\file1.txt', 'D:\3C_2S\·‰\labs\lab3\test\file2.txt';



CREATE TYPE UserCredentials EXTERNAL NAME CopyFileAssembly.[stored_proc.UserCredentials];

drop type UserCredentials

drop type Task

drop table SocialMediaCredentials

declare @a dbo.UserCredentials;

set @a = 'aaaa,bbbbb';

print @a.Username;


-----------------------------------------------------------
create  type Task
EXTERNAL NAME  CopyFileAssembly.[SqlUserDefinedType1];

declare @task as Task
set @task ='Task1 Description1 2023-01-01 Petrov'
print @task.ToString()

------------------------------------------------























select * from sys.assemblies;


CREATE ASSEMBLY CopyFileAssembly FROM 'D:\3C_2S\·‰\labs\lab3\stored-proc\stored-proc\bin\Debug\stored-proc.dll' WITH PERMISSION_SET = UNSAFE;

 DROP ASSEMBLY CopyFileAssembly


drop procedure SendEmailOnUpdate;

CREATE PROCEDURE SendEmailOnUpdate
    @objectName NVARCHAR(MAX)
AS EXTERNAL NAME CopyFileAssembly.StoreProcedure.SendEmailOnUpdate;
GO

exec SendEmailOnUpdate 'wasd';

drop table Warehouses;

CREATE TABLE Warehouses
(
    id          INT PRIMARY KEY IDENTITY (1,1),
    name        NVARCHAR(50)               not null,
    location    NVARCHAR(100)              not null,
    total_space INT                        not null,
    updated_at  DATETIME DEFAULT GETDATE() not null,
    created_at  DATETIME DEFAULT GETDATE() not null
);

drop trigger Warehouse_DDLTrigger;

CREATE or ALter TRIGGER Warehouse_DDLTrigger2
ON DATABASE
FOR ALTER_TABLE
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM sys.objects
        WHERE object_id = EVENTDATA().value('(/EVENT_INSTANCE/ObjectID)[1]', 'int')
            AND type = 'U'
            AND name = 'Warehouses'
    )
    BEGIN
        DECLARE @objectName NVARCHAR(255);
        SET @objectName = 'Warehouse table object changed';

        EXEC SendEmailOnUpdate @objectName;
    END
END



CREATE TRIGGER Warehouse_UpdateTrigger123
ON Warehouses
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @objectName NVARCHAR(255);
    SET @objectName = 'Warehouse table changed';

    EXEC SendEmailOnUpdate @objectName;
END


INSERT INTO Warehouses ( name, location, total_space ) VALUES ( N'Warehouse1', N'Pinsk', 200);

ALTER TABLE Warehouses ADD NewColumn6 INT NULL;





--------------------
SELECT * FROM sys.types;

drop type MyType;
CREATE TYPE MyType EXTERNAL NAME CopyFileAssembly.[stored_proc.Structure];


declare @task as MyType
set @task ='3,ÃËÌÒÍ';
print @task.ToString()