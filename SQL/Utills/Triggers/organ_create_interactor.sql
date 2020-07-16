CREATE TRIGGER organ_create_interactor
ON Organization
AFTER INSERT 
AS
BEGIN 
    SET NOCOUNT OFF ;
    
    INSERT INTO Interactor (is_organ,interaction_code)
    SELECT 1 , ID 
    FROM inserted 

END 

-- drop Trigger organ_create_interactor;