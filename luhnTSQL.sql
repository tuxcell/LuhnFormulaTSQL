-- Name: UDF Luhn's formula-credit card number validation
-- Description:This UDF will validate a credit card number using Luhn's formula.For example 49927398716 will return 1:
-- print dbo.luhn('49927398716')
-- print dbo.luhn(49927398716)

-- based on:
-- Credit cards, validation and the Luhn formula
-- by
-- Eduardo Chaves
-- http://www.webdevelopersjournal.com/articles/validation.html

-- Coded in TSQL by: Jose Gama

CREATE FUNCTION luhn (@s varchar(20) )
--Luhn's formula-credit card number validation
RETURNS bit AS 
BEGIN 
declare @i int, @j int, @k int, @tmp int, @result bit
SET @result=0
IF @s is null 
	GOTO lblFail
IF len(@s)=0 
	GOTO lblFail
SET @i=1
while @i<=len(@s)
	BEGIN
	IF ISNUMERIC(substring(@s,@i,1))=0
		GOTO lblFail
	SET @i=@i+1
	END
SET @j=0
SET @k=0
SET @i=len(@s)
while @i>0
	BEGIN
	IF @i>1
		BEGIN
		SET @tmp=(ASCII(substring(@s,@i-1,1))-48)*2
		IF @tmp>9
			SET @j=@j+@tmp-9
		ELSE
			SET @j=@j+@tmp
		END
	SET @k=@k+(ASCII(substring(@s,@i,1))-48)
	SET @i=@i-2
	END
SET @j=(@j+@k) % 10
IF @j=0
	SET @result=1
lblFail:
return (@result)
END
