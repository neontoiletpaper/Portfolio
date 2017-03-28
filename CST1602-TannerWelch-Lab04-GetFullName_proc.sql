USE classicmodels;
DROP PROCEDURE IF EXISTS GetFullName;
DELIMITER $$

CREATE PROCEDURE GetFullName(
	IN firstName varchar(16),
    IN lastName varchar(32),
	OUT FullName varchar(48))
    
BEGIN
 DECLARE C INT;
 
 SELECT firstName INTO C;
 -- check if orderNumber exists
	IF(C = null) THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'No first name was given.';
	else
		SET FullName = '[' + C + ' ' + lastName + ']';
	END IF;
 
 


	
END$$