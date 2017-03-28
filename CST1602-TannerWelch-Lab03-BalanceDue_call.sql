USE classicmodels;

Set @cn = 114;
CALL BalanceDue(@cn,@HasBalanceDue,@amountDue);	
SELECT @cn AS 'Customer Number', customerName, @hasBalanceDue AS 'Has Balance Due', @AmountDue AS 'Amount Due'
FROM customers
WHERE customerNumber = @cn
