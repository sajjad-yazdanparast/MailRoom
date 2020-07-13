CREATE PROCEDURE update_organization_by_name @old_name NVARCHAR(64), @new_name NVARCHAR(64)
AS 
    UPDATE Organization 
    SET name = @new_name
    WHERE name = @old_name ;
GO ;

CREATE PROCEDURE update_organization_by_id @id INTEGER , @new_name NVARCHAR(64) 
AS 
    UPDATE Organization 
    SET name = @new_name
    WHERE ID = @id  ;
GO ;
