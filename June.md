# 六月的雨
+ MySQL存储过程，据说可以取字符串的hashcode,可以应用到将varchar字段转为bigint字段上。

```SQL
DELIMITER $$
 
CREATE
    PROCEDURE `test`.`HashValue`(IN str CHAR(32))
    BEGIN
     
    SET @pos = 1;
    SET @hashValue = 0;
    SET @szHex = HEX(str);
    SET @size = LENGTH(@szHex);
    WHILE @pos<@size+1 DO
        SET @cCh = SUBSTRING(@szHex,@pos,2);
        SET @nCh =CAST(ASCII(UNHEX(@cCh)) AS UNSIGNED);
        SET @hashValue = @hashValue + @nCh;
        SET @pos = @pos + 2;
    END WHILE;
 
    SELECT @hashValue;
    END$$
 
DELIMITER ;
```
