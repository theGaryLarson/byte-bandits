## Byte Bandits: Part 3 of 6
<hr></hr>

### Look-up Tables
 * political_affiliation_look_up - a unique list of political affiliations.
 * political_intensity_look_up - *We didn't create this because it's redundant. It would take the same amount of space as our likert scale*
 * religious_affiliation_look_up - a unique list of religious affiliations.
 * religious_intensity_look_up - *We didn't create this because it's redundant. It would take the same amount of space as our likert scale*
 * social_issue_view_look_up - a unique list of views on social issues.
 * social_issue_view_intensity_look_up - *We didn't create this because it's redundant. It would take the same amount of space as our likert scale*
 * social_mate_preference_look_up - *we just use the gender_look_up table*
 * gender_look_up - lists the various gender identities. VARCHAR(4) to include room for more. Recognizing gender fluidity in our design.
 * hobby_look_up - A list of distinct hobbies.
 * time_spent_on_hobby_look_up - a list of frequencies indicating amount of time spent on a hobby. (e.g  "daily", "twice weekly", "once a week", "weekends", "at least once a month", etc.)
<hr></hr>
 
### Transaction Tables

* *political_transaction* - stores change in intensity based on political lean
* *religious_transaction* - stores change in intensity based on religious lean
* *social_issue_view_transaction* - stores change in intensity based on social issue view intensity
* *sm_transaction* - social media purchases: tracks date and price from given seller
* *hobby_transaction* - tracks a change in a profile's given hobbies

> Now using your design, add a means to support logging the transactions, so if a problem were to be found with the data it can be traced back to the transaction that caused it. At this point you should be thinking “I am going to have to be date tagging the transactions”

We would alter our pipeline so that each procedure that insert data into these tables that are tied to a transaction table. There would be a branching condition that would load the data into the transaction table based on the individual table requirements.

**Q:** *Is it expected to refactor all our procedures and functions so the pipeline loads the data correctly? It seems like a lot of work that isn't intended.*
<hr></hr>

### Extra credit
> For extra credit, add "opinion change transaction detection" to your database schema 


* We have transaction tables listed above in our transaction tables. These would be used to track the change in intensity of the opinions (political, religious, social_issue_views). A view would be created where we could compare previous changes in intensity. We can filter by dates with BETWEEN and/or look for variance in intensity fairly easily with some basic subtraction.

<hr></hr>

### Todo:
~~fix profile_hobby  table: add pk~~</br>
~~create hobby_transaction table~~</br>

**Q: Are these expected?**
* Get procedures and functions refactored so pipeline works as expected. 
* Create transactions that make use of our transaction tables. (logs data when not inserted as expected / moves records when intensity changes)
  * Uses COMMIT and ROLLBACK keywords. Wouldn't necessarily need to rollback if we are logging in another table, right?
* Checking if opinion changes via a VIEW or a TRIGGER?
<hr></hr>



