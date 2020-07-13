CREATE PROCEDURE insert_organization @name NVARCHAR(64) 
AS 
    INSERT INTO Organization (name) VALUES
    (@name) ;
GO ;
