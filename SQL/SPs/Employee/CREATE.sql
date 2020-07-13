CREATE PROCEDURE insert_high_level_employee @organ_id INTEGER ,@personel_number NUMERIC(10,0), @name NVARCHAR(32), @rank FLOAT
AS 
    INSERT INTO Employee (organ_id,personel_number,rank,name)
    VALUES (@organ_id,@personel_number,@rank,@name);
GO ;

CREATE PROCEDURE insert_low_level_employee @organ_id INTEGER, @personel_number NUMERIC(10,0), @name NVARCHAR(32), @rank FLOAT, @boss_id INTEGER
AS 
    INSERT INTO Employee (organ_id,personel_number,rank,name,boss_id)
    VALUES (@organ_id,@personel_number,@rank,@name,@boss_id);
GO ;

