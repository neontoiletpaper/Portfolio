USE classicmodels;
DROP PROCEDURE IF EXISTS BalanceDue;
DELIMITER $$

CREATE PROCEDURE BalanceDue(
	IN p_customerNumber int(11),
    OUT p_HasBalanceDue varchar(3),
	OUT p_AmountDue DOUBLE)
    
    BEGIN
		DECLARE totalAmountDue DOUBLE;
        DECLARE totalPayments DOUBLE;
        #SET totalPayments = 0;
        #SET totalAmountDue = 0;
        
		SELECT CONVERT(SUM(quantityOrdered * priceEach),DECIMAL(8,2)) INTO totalAmountDue
		FROM orderdetails
        INNER JOIN orders USING(orderNumber)
        WHERE customerNumber = p_customerNumber;
        
        SELECT CONVERT(SUM(amount),DECIMAL(8,2)) INTO totalPayments
        From payments
        WHERE customerNumber = p_customerNumber;
        
        SELECT CONVERT(SUM(totalAmountDue - totalPayments),DECIMAL(8,2)) INTO p_AmountDue;
        
		IF totalAmountDue > totalPayments THEN
			SET p_HasBalanceDue = 'YES';
		ELSE
			SET p_HasBalanceDue = 'NO';
        END IF;
        @cn AS 'Customer Number', customerName, @hasBalanceDue AS 'Has Balance Due', @AmountDue AS 'Amount Due'
	END$$

    

