USE targeted_marketing;
DELIMITER //
CREATE PROCEDURE bendover_driver()

BEGIN
-- each field from bendover_data_feed_table needed to store fetch from cursor data
DECLARE curr_primary_key					INT;
DECLARE curr_bendover_id					VARCHAR(200);
DECLARE curr_f_name							VARCHAR(45);
DECLARE curr_l_name							VARCHAR(45);
DECLARE curr_email							VARCHAR(45);
DECLARE curr_political_affil				VARCHAR(45);
DECLARE curr_political_intensity			INT;
DECLARE curr_religious_affil				VARCHAR(45);
DECLARE curr_religious_intensity			INT;
-- reminder : json object
DECLARE curr_social_issue_views				VARCHAR(200);
-- reminder : json object
DECLARE curr_social_issue_date				VARCHAR(200);
-- reminder : json object
DECLARE curr_social_issue_view_intensity	VARCHAR(200);
-- reminder : json object
DECLARE curr_social_mate_pref				VARCHAR(200);
DECLARE curr_gender							VARCHAR(3);
DECLARE curr_age							INT;
DECLARE curr_location						VARCHAR(45);
DECLARE curr_education						VARCHAR(144);
DECLARE curr_occupation						VARCHAR(144);
-- reminder : json object
DECLARE curr_hobbies						VARCHAR(200);

-- fields needed for inserts into tables
DECLARE platform_id						INT; # BENDOVER
DECLARE curr_opinion_type_id			INT; # POLITICS, CLIMATE-CHANGE, RELIGION, etc.
DECLARE curr_profile_id					INT; # CORE PROFILE PRIMARY KEY
DECLARE curr_opinion_id					INT; # OPINION ID TO BE USED IN PROFILE_OPINION SO AN INTENSITY CAN BE ASSOCIATED

DECLARE cur CURSOR FOR
SELECT *
FROM bendover_data_feed;
DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET @done = TRUE;

# intialize variables that will be used for scope of driver call
# todo: create a method that checks if platform exists, if not adds it then returns PK
SELECT id INTO platform_id
FROM social_media_platform
WHERE platform = "BENDOVER";

# populate core profile names first to generate needed primary keys for FK dependencies
-- todo: this method will handle duplicates and aliases ... eventually
CALL insert_bendover_names_into_core_profile();

OPEN cur;
insertion_loop: LOOP
	# for each row of bendover_data_feed parse data into appropriate table
	FETCH cur INTO 	curr_primary_key,
					curr_bendover_id,
					curr_f_name,
                    curr_l_name,
                    curr_email,
                    curr_political_affil,
                    curr_political_intensity,
                    curr_religious_affil,
                    curr_religious_intensity,
                    curr_social_issue_views,
                    curr_social_issue_date,
                    curr_social_issue_view_intensity,
                    curr_social_mate_pref,
                    curr_gender,
                    curr_age,
                    curr_location,
                    curr_education,
                    curr_occupation,
                    curr_hobbies;
                    
	####################################################################################################            
	# main work is done here at each pass through the loop will insert data into the appropriate table #
    ####################################################################################################
    
    -- retrieve current profile_id
    SELECT get_profile_id_by_name(curr_f_name, curr_l_name)
    INTO curr_profile_id;
    
    -- insert into email table from current bendover_data_feed record
    CALL insert_email(curr_profile_id, curr_email);
    
    -- insert political affiliation and political intensity into profile_opinion
    -- store the opinion type for the current political_affiliation in curr_opinion_type_id
    -- adds 'Politics' if not found then returns the id. (have to be really careful about typos)
    SELECT get_current_opinion_type_id('Politics')
    INTO curr_opinion_type_id;

    SELECT get_opinion_id(curr_opinion_type_id, curr_political_affil)
    INTO curr_opinion_id;

	-- fixme: transaction assignment - add some logic to see if there already is a profile opinion for this opinion_id
	--  if so transfer current record to transaction table and insert new intensity & date (even if intensity is the same)
    CALL insert_profile_opinion
    (
        curr_profile_id,
        curr_opinion_id,
        CURDATE(),
        curr_political_intensity
	);

    -- todo: insert religious affiliation data
	-- change to religion category
    SELECT get_current_opinion_type_id('Religion')
    INTO curr_opinion_type_id;

	-- get or create an id for the opinion on religion and store it in curr_opinion_id
	SELECT get_opinion_id(curr_opinion_type_id, curr_religious_affil)
    INTO curr_opinion_id;

	-- fixme: transaction assignment - add some logic to see if there already is a profile opinion for this opinion_id
	--  if so transfer current record to transaction table and insert new intensity & date (even if intensity is the same)
	CALL insert_profile_opinion
    (
        curr_profile_id,
        curr_opinion_id,
        CURDATE(),
        curr_religious_intensity
	);
    -- leave loop if next item is not found
    IF @done THEN
		LEAVE insertion_loop;
	END IF;
END LOOP;
END//

DELIMITER ;
CALL bendover_driver();