# 六月的雨
+ MySQL存储过程，可以取字符串的hashcode,实际可以应用到将varchar字段转为bigint字段上。

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

+ layer.open 中右上角关闭按钮触发的回调用 `cancel `
   + 调.Net系统的页面，当数据发生变化时，希望可以点右上角的叉在关闭当前页面时刷新父级的列表页面数据。 

```javascript
 function openWinFullBzhjc(url, title, w, h) {
    var index = layer.open({
        type: 2,
        title: title,
        shade: 0.5,
        maxmin: false,
        area: ['300px', '150px'],
        content: url,
        cancel: function (index, layero) {
            closeLayerWindow();
            window.location.href="/sop?pindex=bzhjcList";
        }
    });
    layer.full(index);
}
```
