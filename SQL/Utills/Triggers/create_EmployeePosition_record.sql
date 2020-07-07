CREATE TRIGGER EmployeePosition_creational_trigger
ON Employee
AFTER INSERT 
AS
BEGIN 
    SET NOCOUNT ON ;
    DECLARE @employee_id INTEGER ;
    DECLARE @rank FLOAT ;

    SELECT @employee_id = i.ID , @rank = i.rank FROM inserted i ;
    INSERT INTO EmployeePosition (employee_id,rank) 
    VALUES (@employee_id,@rank) ;

    PRINT 'EmployeePosition added ;'


END 
