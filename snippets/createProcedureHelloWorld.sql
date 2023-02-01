USE targeted_marketing;
DELIMITER //
CREATE PROCEDURE `helloworld` ()
BEGIN
SELECT 'Hello World!' AS message;
END//
DELIMITER ;
CALL helloworld();
