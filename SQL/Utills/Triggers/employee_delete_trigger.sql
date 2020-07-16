CREATE TRIGGER employee_delete_trigger
ON Employee
AFTER DELETE 
AS
BEGIN 
    SET NOCOUNT OFF ;
    
    ALTER TABLE Letter NOCHECK CONSTRAINT CK_type_interactor_validation ;
    ALTER TABLE Letter NOCHECK CONSTRAINT CK_only_in_type_4_intermediate_interactor_should_be_valid ;


    -- update his letters ==> set sender to null 
    UPDATE Letter 
    SET sender = NULL 
    WHERE is_sender_organ = 0 AND sender IN 
    (
    SELECT  ID 
    FROM deleted 
    ) ;

    -- update his letters ==> set reciever to null 
   
    UPDATE Letter 
    SET reciever = NULL 
    WHERE is_reciever_organ = 0 AND reciever IN 
    (
    SELECT  ID 
    FROM deleted 
    );
    
    -- update his letters ==> set itnermediate_interactor to null 
    UPDATE Letter 
    SET intermediate_interactor = -1 
    WHERE is_intermediate_interactor_organ = 0 AND intermediate_interactor IN
    (
        SELECT  ID 
        FROM deleted 
    ) ;
    

    -- delete interactor 
    DELETE FROM Interactor 
    WHERE is_organ = 0 AND interaction_code IN
    (
        SELECT  ID 
        FROM deleted 
    );


    ALTER TABLE Letter CHECK CONSTRAINT CK_type_interactor_validation ;
    ALTER TABLE Letter CHECK CONSTRAINT CK_only_in_type_4_intermediate_interactor_should_be_valid ;

    PRINT 'Letters of this deleted Employee has been updated successfully!' ;


END 

-- drop Trigger employee_delete_trigger;
