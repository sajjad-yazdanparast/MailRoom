CREATE PROCEDURE insert_high_level_employee @organ_id INTEGER ,@personel_number NUMERIC(10,0), @name NVARCHAR(32), @rank FLOAT, @telephone NUMERIC(11,0)
AS 
    INSERT INTO Employee (organ_id,personel_number,rank,name,telephone)
    VALUES (@organ_id,@personel_number,@rank,@name,@telephone);
GO ;

CREATE PROCEDURE insert_low_level_employee @organ_id INTEGER, @personel_number NUMERIC(10,0), @name NVARCHAR(32), @rank FLOAT, @boss_id INTEGER, @telephone NUMERIC(11,0)
AS 
    INSERT INTO Employee (organ_id,personel_number,rank,name,boss_id,telephone)
    VALUES (@organ_id,@personel_number,@rank,@name,@boss_id,@telephone);
GO ;

-- DROP PROCEDURE insert_low_level_employee ;
