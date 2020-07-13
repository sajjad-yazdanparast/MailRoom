CREATE PROCEDURE get_all_ranks @order VARCHAR(4)
AS 
    IF @order = 'ASC'
    BEGIN
        SELECT *
        FROM Position 
        ORDER BY rank ASC ;
    END 

    ELSE 
    BEGIN
        SELECT *
        FROM Position 
        ORDER BY rank DESC ;
    END 
GO ;

CREATE PROCEDURE get_position_by_rank @rank FLOAT 
AS 
    SELECT * 
    FROM Position
    WHERE rank = @rank ;
GO ;

CREATE PROCEDURE get_position_by_name @name NVARCHAR(64) 
AS 
    SELECT * 
    FROM Position
    WHERE name = @name ;
GO ;
