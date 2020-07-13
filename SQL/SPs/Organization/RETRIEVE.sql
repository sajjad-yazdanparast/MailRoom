CREATE PROCEDURE get_all_organizations 
AS
    SELECT name FROM Organization ;
GO ;

CREATE PROCEDURE get_organization_by_name @name NVARCHAR(64) 
AS
    SELECT * FROM Organization 
    WHERE name = @name ;
GO ;

CREATE PROCEDURE get_organization_by_id @id INTEGER 
AS 
    SELECT * FROM Organization 
    WHERE ID = @id ;
GO;