DELIMITER $$
CREATE PROCEDURE createNameList (
	INOUT nameList varchar(4000)
)
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE name varchar(100) DEFAULT "";

	-- declare cursor for employee email
	DEClARE curName 
		CURSOR FOR 
			SELECT Fname FROM COOK;

	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;

	OPEN curName;

	getName: LOOP
		FETCH curName INTO name;
		IF finished = 1 THEN 
			LEAVE getName;
		END IF;
		-- build email list
		SET NameList = CONCAT(name,";",NameList);
	END LOOP getName;
	CLOSE curName;

END$$
DELIMITER ;

SET @NameList = "";
CALL createNameList(@NameList);
SELECT @NameList;