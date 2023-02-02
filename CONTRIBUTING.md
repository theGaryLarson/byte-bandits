# How to Contribute 

### Schema changes
1. Any changes to the schema should only be done in your section of the byte_bandits_schema.sql file
unless discussed with other team members.
2. When making changes be sure to also adjust the insert statements in the byte_bandits_inserts.sql file to reflect your changes.
3. Once you are satisfied with your changes.
4. Rerun the byte_bandits_schema.sql file to rebuild the database.
5. Then run the byte_bandits_inserts.sql file
6. If there are no errors push the changes to the main branch.
7. If there are errors there are two options.
   1. Correct them so everything loads correctly or
   2. Create a branch prefixed with your initials so we can help troubleshoot.


### Adding data
* I dont think any additional data will need to be added manually. From this point on only use our stored procedures to insert data.
* The exception would be if there was need to redesign a section completely. In that case, adding some new data manually would be good practice to show it works as expected.

### Adding Stored Procedures
1. create a sql file to store each stored procedure.
2. The file name should represent the action the method is performing.</br>
&nbsp; * Long names are preferred over abbreviated names.
3. Be sure the procedures run as expected and create them only for your section unless communicating with a team member.
4. Once it runs as expected be sure it is saved in the stored_procedures folder of the repo.
5. Make sure the repo is up-to-date (git status | git pull). Push changes to the main branch of the respository
6. If there are issues create a branch prefixed with your initials so we can work as a team to troubleshoot.

    
    Once, everything is running as expected push changes to main.
    Always ensure you are up to date by doing a git pull prior to pushing upstream.


