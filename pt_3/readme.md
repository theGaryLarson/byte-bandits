
# Todo:
fix profile_hobby  table: add pk</br>
create hobby_transaction table

* Get procedures and functions functioning so pipeline works as expected.
* Create transactions that make use of our transaction tables. (logs data when not inserted as expected / moves records when intensity changes)
* Extra credit: Checking if opinion changes via a VIEW or a TRIGGER.

## Byte Bandits: Part 3 of 6

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

### Transaction Tables

* *political_transaction* - stores change in intensity based on political lean
* *religious_transaction* - stores change in intensity based on religious lean
* *social_issue_view_transaction* - stores change in intensity based on social issue view intensity
* *sm_transaction* - social media purchases: tracks date and price from given seller
* *hobby_transaciton* - tracks a change in a profile's given hobbies

> Now using your design, add a means to support logging the transactions, so if a problem were to be found with the data it can be traced back to the transaction that caused it. At this point you should be thinking “I am going to have to be date tagging the transactions”
<hr></hr>
We would alter our pipeline so that each procedure that insert data into these tables that are tied to a transaction table. There would be a branching condition that would load the data into the transaction table based on the individual table requirements.