SHOW VARIABLES LIKE 'secure_file_priv';
SET GLOBAL local_infile = '1';
SELECT @@global.local_infile;
set @@global.secure_file_priv="";
show variables like 'log_error';

GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;


