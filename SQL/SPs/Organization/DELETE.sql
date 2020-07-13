CREATE PROCEDURE delete_organization_by_name @name NVARCHAR(64) 
AS 
    DELETE FROM Organization
    WHERE name = @name ;
GO ;


CREATE PROCEDURE delete_organization_by_id @id INTEGER 
AS 
    DELETE FROM Organization 
    WHERE id = @id ;
GO ;

CREATE PROCEDURE delete_all_organizations 
AS  
    DELETE FROM Organization ;
GO ;
