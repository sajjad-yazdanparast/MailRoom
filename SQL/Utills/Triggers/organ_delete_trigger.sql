CREATE TRIGGER organ_delete_trigger
ON Organization
AFTER DELETE 
AS
BEGIN 
    SET NOCOUNT OFF ;
    DECLARE @interaction_code INTEGER ;
    SELECT @interaction_code = ID 
    FROM deleted ;


    -- update his letters ==> set sender to null 
    UPDATE Letter 
    SET sender = NULL 
    WHERE is_sender_organ = 1 AND sender = @interaction_code ;

    -- update his letters ==> set reciever to null 
    UPDATE Letter 
    SET reciever = NULL 
    WHERE is_reciever_organ = 1 AND reciever = @interaction_code ;
    
    -- update his letters ==> set itnermediate_interactor to null 
    UPDATE Letter 
    SET intermediate_interactor = NULL 
    WHERE is_intermediate_interactor_organ = 1 AND intermediate_interactor = @interaction_code ;
    

    -- delete interactor 
    DELETE FROM Interactor 
    WHERE is_organ = 1 AND interaction_code = @interaction_code ;

    
    -- SELECT @interaction_code = interaction_code FROM
    -- Interactor 
    -- WHERE
    -- organ_id = (SELECT ID FROM deleted) ;


    -- DELETE FROM Letter 
    -- WHERE sender = @interaction_code OR reciever = @interaction_code ;


    -- DELETE FROM Interactor 
    -- WHERE interaction_code = @interaction_code ;

    PRINT 'Letters of this Organ has been deleted successfully!' ;


END 

-- drop Trigger organ_delete_trigger;