CREATE PROCEDURE insert_record @name NVARCHAR(64) 
AS 
    INSERT INTO Organization (name) VALUES
    (@name) ;
GO ;
