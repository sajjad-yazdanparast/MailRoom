CREATE TRIGGER employee_delete_trigger
ON Employee
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
    WHERE is_sender_organ = 0 AND sender = @interaction_code ;

    -- update his letters ==> set reciever to null 
    UPDATE Letter 
    SET reciever = NULL 
    WHERE is_reciever_organ = 0 AND reciever = @interaction_code ;
    
    -- update his letters ==> set itnermediate_interactor to null 
    UPDATE Letter 
    SET intermediate_interactor = NULL 
    WHERE is_intermediate_interactor_organ = 0 AND intermediate_interactor = @interaction_code ;
    

    -- delete interactor 
    DELETE FROM Interactor 
    WHERE is_organ = 0 AND interaction_code = @interaction_code ;


    -- DECLARE @interaction_code NUMERIC(11,0) ;
    
    -- SELECT @interaction_code = interaction_code FROM
    -- Interactor 
    -- WHERE
    -- employee_id = (SELECT ID FROM deleted) ;

    -- DELETE FROM Letter 
    -- WHERE sender = @interaction_code OR reciever = @interaction_code ;


    -- DELETE FROM Interactor 
    -- WHERE interaction_code = @interaction_code ;

    PRINT 'Letters of this deleted Employee has been updated successfully!' ;


END 

-- drop Trigger employee_delete_trigger;

select * from Interactor