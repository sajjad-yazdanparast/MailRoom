CREATE PROCEDURE delete_position_by_rank @rank FLOAT 
AS 
    DELETE FROM Position 
    WHERE rank = @rank ;
GO ;

CREATE PROCEDURE delete_position_by_name @name NVARCHAR(64)
AS 
    DELETE FROM Position
    WHERE name = @name ;
GO ;

CREATE PROCEDURE delete_all_positions 
AS 
    DELETE FROM Position ;
GO ;