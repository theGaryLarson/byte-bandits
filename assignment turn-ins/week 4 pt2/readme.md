## Loading Instructions

### Open Folder: *Schema_and_inserts*
1. run the files in numbered order
2. load the views (there to make it easier to see data is loaded correctly)

    The driver.sql file creates and calls the driver method that runs all the <u>working</u> stored procedures in the correct order.</br>
<u><em>All are not created.</em></u> 

Does not load the following data because it is json and after our discussion we thought we would wait until we cover it in class.

    # todo: social issue views       (json)  ---
	# todo: social issue post date   (json)    --> all 3 associated
	# todo: social issue intensity   (json)  ---

	# todo: social mate preference   (json) - has its own table
	# todo: hobbies                  (json) - hobby table, profile_hobby table

* *Above is copy and pasted from the driver.sql todos*</br>

The rest of the files and folders have some minor updates. The sql files are broken up but included all the working ones within the main numbered files.

# LOAD DATA INFILE ISSUES

We all spent quite some time looking it up. Monday we have a study group and hoping we have the time to work on it more
However, after extensive research we learned a lot about:
* my.ini/my.cnf files
* The order mysql searches for .ini/.cnf files in the directory
* option files and why they are not preloaded (using installer doesn't create them)
* headers such as [mysqld] and [client]
* user permissions and how to change them
* file/folder read and write permissions

Exploring all these still left us with no solution. The work around was to load five feeds manually with insert statements
Which is why it is provided in the numbered files to validate our stored procedures and function calls.