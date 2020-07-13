CREATE PROCEDURE update_position_name_by_rank @new_name NVARCHAR(64), @rank FLOAT 
AS 
    UPDATE Position 
    SET name = @new_name 
    WHERE rank = @rank ;
GO ;

CREATE PROCEDURE update_position_rank_by_name @name NVARCHAR(64), @new_rank FLOAT 
AS 
    UPDATE Position 
    SET rank = @new_rank 
    WHERE name = @name
GO ;