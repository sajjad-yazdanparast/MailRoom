CREATE TRIGGER employee_create_interactor
ON Employee
AFTER INSERT 
AS
BEGIN 
    SET NOCOUNT OFF ;
    
    INSERT INTO Interactor (is_organ,interaction_code)
    SELECT 0 , ID 
    FROM inserted 

END 

-- drop Trigger employee_create_interactor;