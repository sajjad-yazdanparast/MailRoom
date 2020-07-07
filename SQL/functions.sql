CREATE FUNCTION validate_name (
    @name NVARCHAR(64) ,
    @emp_id INTEGER ,
    @org_id INTEGER 
) RETURNS NVARCHAR(5) AS
BEGIN
    IF EXISTS (SELECT * from Employee WHERE Employee.name = @name and Employee.ID = @emp_id)
        RETURN 'TRUE'
    IF EXISTS (SELECT * from Organization WHERE Organization.name = @name and Organization.ID = @org_id)
        RETURN 'TRUE'
    RETURN 'FALSE'
END
