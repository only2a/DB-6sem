-- 1. Показать и объяснить, какой режим аутентификации используется для экземпляра SQL Server.

-- 2. Создать необходимые учетные записи, роли и пользователей. Объяснить назначение привилегий.
create login default_login with password = 'default_login';
create user default_user for login default_login;	
create user user_without_login without login;	
create role default_role;								

-- привилегии:
select * from users;
INSERT INTO Users ( first_name, last_name, email, created_at)
VALUES ( 'Don', 'Don', 'don@example.com', '2020-04-01 12:00:00');

update Users set first_name = 'updated' where id = 11;

grant select, insert, update, delete on users to default_role;
revoke update on users from default_role;
EXEC sp_addrolemember @rolename = 'default_role', @membername = 'default_user';

-- 3. Продемонстрируйте заимствование прав для любой процедуры в базе данных.
create login login1 with password = 'login1';
create login login2 with password = 'login2';
create user user1 for login login1;
create user user2 for login login2;

exec sp_addrolemember 'db_datareader', 'user1';
exec sp_addrolemember 'db_ddladmin', 'user1';
deny select on users to user2;

go
create or alter procedure users_select 
with execute as 'user1'
	as select * from users;
go

alter authorization on users_select to user1;
grant execute on users_select to user2;

setuser 'user2';
exec users_select;
select * from users;
setuser;

-- 4. Создать для экземпляра SQL Server объект аудита.
use master;

create server audit Audit 
	to file(
		filepath = 'C:\My\DB',
		maxsize = 10 mb,
		max_rollover_files = 0,
		reserve_disk_space = off
	) with ( queue_delay = 1000, on_failure = continue);

create server audit PAudit to application_log;
create server audit AAudit to security_log;

select * from sys.server_audits;

drop server audit PAudit;
drop server audit AAudit;
drop server audit Audit;

-- 5. Задать для серверного аудита необходимые спецификации.
create server audit specification ServerAuditSpecification
for server audit Audit
add (database_change_group)
with (state=on)

DROP SERVER AUDIT SPECIFICATION [ServerAuditSpecification];

-- 6. Запустить серверный аудит, продемонстрировать журнал аудита.
alter server audit Audit with (state=on);

create database some_db;
drop database some_db;

select statement from 
	fn_get_audit_file('C:\My\DB\Audit_4E6D10B0-AD7A-4258-97C1-DB1D9042E924_0_133301339999130000.sqlaudit', 
	null, null);	

-- 7. Создать необходимые объекты аудита.
-- 8. Задать для аудита необходимые спецификации.
-- 9. Запустить аудит БД, продемонстрировать журнал аудита.

use SocialNetwork;

go
create database audit specification DatabaseAuditSpecification
for server audit Audit
add (insert on SocialNetwork.dbo.Users by dbo)
with (state=on);

select * from SocialNetwork.dbo.Users;
insert into  SocialNetwork.dbo.Users(first_name) values ('NewDep');
go

select statement from 
	fn_get_audit_file('C:\My\DB\Audit_4E6D10B0-AD7A-4258-97C1-DB1D9042E924_0_133301339999130000.sqlaudit', 
	null, null);

--10. Остановить аудит БД и сервера
use master;
alter server audit Audit with (state=off);
alter server audit PAudit with (state=off);
alter server audit AAudit with (state=off);

-- 11. Создать для экземпляра SQL Server ассиметричный ключ шифрования
use SocialNetwork;

create asymmetric key asymmetric_key
with algorithm = rsa_2048
encryption by password = 'secret_string';

-- 12. Зашифровать и расшифровать данные при помощи этого ключа.
declare @content nvarchar(16);
declare @encrypted_content nvarchar (256);
declare @decrypted_content nvarchar(16);

set @content = 'Some message';
set @encrypted_content = EncryptByAsymKey(AsymKey_ID('asymmetric_key'), @content);
set @decrypted_content = DecryptByAsymKey(AsymKey_ID('asymmetric_key'), @encrypted_content, N'secret_string');

print @encrypted_content;
print @decrypted_content;

-- 13. Создать для экземпляра SQL Server сертификат.
create certificate _certificate
encryption by password = N'secret_string'
with subject = N'Sample Certificate',
expiry_date = N'20231231';

DROP DATABASE ENCRYPTION KEY;
DROP CERTIFICATE _certificate;

-- 14. Зашифровать и расшифровать данные при помощи этого сертификата.
go
declare @content nvarchar(16);
declare @encrypted_content nvarchar (256);
declare @decrypted_content nvarchar(16);

set @content = 'Some message';
set @encrypted_content = EncryptByCert(Cert_ID('_certificate'), @content);
set @decrypted_content = CAST(DecryptByCert(Cert_ID('_certificate'), @encrypted_content, N'secret_string')
	as nvarchar(16));

print @encrypted_content;
print @decrypted_content;
go

-- 15. Создать для экземпляра SQL Server симметричный ключ шифрования данных.
create symmetric key symmetric_key
with algorithm = AES_256
encryption by password = N'secret_string';


create symmetric key DKey
with algorithm = AES_256
encryption by symmetric key EKey;

open symmetric key DKey
decryption by symmetric key EKey;


-- 16. Зашифровать и расшифровать данные при помощи этого ключа.
go
open symmetric key symmetric_key
decryption by password = N'secret_string';

declare @content nvarchar(16);
declare @encrypted_content nvarchar (256);
declare @decrypted_content nvarchar(16);

set @content = 'Some message';
set @encrypted_content = EncryptByKey(Key_GUID('symmetric_key'), @content);
set @decrypted_content = CAST(DecryptByKey(@encrypted_content) as nvarchar(16));

print @encrypted_content;
print @decrypted_content;

close symmetric key symmetric_key;
go

-- 17. Продемонстрировать прозрачное шифрование базы данных.
use master;

create master key encryption 
by password = 'secret_string';

create certificate transparent_key
with subject = 'Certificate to encrypt [SocialNetwork] DB', 
expiry_date = '20231231';

use SocialNetwork;

create database encryption key
with algorithm = AES_256
encryption by server certificate transparent_key;

alter database SocialNetwork set encryption on;

select encryption_state from sys.dm_database_encryption_keys;

alter database SocialNetwork set encryption off;

-- 18. Продемонстрировать применение хэширования.
select HashBytes('MD4', 'qwertyuiopasdfghjklzxcvbnmQERTYUIOPASDFGHJKLZXCVBNM1234567890') as MD4;
select HashBytes('MD4', 'q') as MD4;
select HashBytes('MD5', 'qwertyuiopasdfghjklzxcvbnmQERTYUIOPASDFGHJKLZXCVBNM1234567890') as MD5;
select HashBytes('MD5', 'q') as MD5;
select HashBytes('SHA1', 'qwertyuiopasdfghjklzxcvbnmQERTYUIOPASDFGHJKLZXCVBNM1234567890') as SHA1;
select HashBytes('SHA1', 'q') as SHA1;

-- 19. Продемонстрировать применение ЭЦП при помощи сертификата.
select * from sys.certificates;

select SIGNBYCERT(256, N'default_login', N'secret_string') as ЭЦП;

select VERIFYSIGNEDBYCERT(256, 'default_login', 0x0100050204000000D1CD9D445A6813FFB7ACC6A8B86FA77AA1E0DE2B693D260B729168286E4AC0F1DA24C288F44EC4F762303F2053EDA9B133194EC4FE284DC40662AB9EDE9165782922D8FF08FABD6976B10BC9EE22310552B8EBAB223E8BA8850043B8BC301A523858A3AF6E886B1B93CA61723F151649039412F0387E9043B7D72331596AA48A367BAF31FFDC924DB355DF186DB6BAF11E9EF43905AC990FEBFED1E9D6F6DC82287A057BB6CC659A72EB9A3BA5BB2A9E9C753B2D76DBB6FA46367B99AE645A248BE9AABE4E6C8D9D2F48A90B931490366C855CB9A8994F4BAA0491EBCCA1544D3FD364B320A12E5BBA85F0BDCE8D19DC53140D60D966CACEF3B89AA2F693ABA9);

-- 20. Сделать резервную копию необходимых ключей и сертификатов.
backup certificate _certificate
to file = N'C:\My\DB\сertificate_backup.cer'
with private key
(
	file = N'C:\My\DB\certificate_backup.pvk',
	encryption by password = N'secret_string',
	decryption by password = N'secret_string'
);

use master;

BACKUP MASTER KEY TO FILE = 'C:\My\DB\master_database_backup.key'
ENCRYPTION BY PASSWORD = 'p@secret_string';