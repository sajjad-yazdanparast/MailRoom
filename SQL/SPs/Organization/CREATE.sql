CREATE PROCEDURE insert_organization @name NVARCHAR(64) , @address NVARCHAR(256), @telephone NUMERIC(11,0)
AS 
    INSERT INTO Organization (name,address,telephone) VALUES
    (@name,@address,@telephone) ;
GO ;

-- drop PROCEDURE insert_organization