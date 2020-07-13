CREATE PROCEDURE insert_position @name NVARCHAR(64), @rank FLOAT 
AS 
    INSERT INTO Position (rank,name) 
    VALUES (@rank,@name) ;
GO ;
