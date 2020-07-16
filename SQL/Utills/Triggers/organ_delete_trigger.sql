CREATE TRIGGER organ_delete_trigger
ON Organization
AFTER DELETE 
AS
BEGIN 
    SET NOCOUNT OFF ;

    ALTER TABLE Letter NOCHECK CONSTRAINT CK_type_interactor_validation ;
    ALTER TABLE Letter NOCHECK CONSTRAINT CK_only_in_type_4_intermediate_interactor_should_be_valid ;

    -- update his letters ==> set sender to null 
    UPDATE Letter 
    SET sender = NULL 
    WHERE is_sender_organ = 1 AND sender IN
    (

    SELECT  ID 
    FROM deleted 
    ) ;

    -- update his letters ==> set reciever to null 
    UPDATE Letter 
    SET reciever = NULL 
    WHERE is_reciever_organ = 1 AND reciever IN 
    (

    SELECT  ID 
    FROM deleted 
    ) ;
    
    -- update his letters ==> set itnermediate_interactor to null 
    UPDATE Letter 
    SET intermediate_interactor = NULL 
    WHERE is_intermediate_interactor_organ = 1 AND intermediate_interactor IN 
    (

    SELECT  ID 
    FROM deleted 
    ) ;
    

    -- delete interactor 
    DELETE FROM Interactor 
    WHERE is_organ = 1 AND interaction_code IN 
    (
    SELECT  ID 
    FROM deleted 
    ) ;

    
    ALTER TABLE Letter CHECK CONSTRAINT CK_type_interactor_validation ;
    ALTER TABLE Letter CHECK CONSTRAINT CK_only_in_type_4_intermediate_interactor_should_be_valid ;


    PRINT 'Letters of this Organ has been deleted successfully!' ;


END 

-- drop Trigger organ_delete_trigger;