CREATE FUNCTION type_interactor_validator (
    @type INTEGER , 
    @sender INTEGER ,
    @reciever INTEGER ,
    @is_sender_organ BIT ,
    @is_reciever_organ BIT 
) RETURNS NVARCHAR(5) AS 
BEGIN 

    IF @sender = NULL OR @reciever = NULL 
    BEGIN 
        RETURN 'TRUE' ;
    END 
    -- DECLARE @sender_emp_id INTEGER ;
    DECLARE @sender_org_id INTEGER ;
    -- DECLARE @reciever_emp_id INTEGER ;
    DECLARE @reciever_org_id INTEGER ;

    -- SELECT @sender_emp_id = employee_id , @sender_org_id = organ_id 
    -- FROM Interactor 
    -- WHERE interaction_code = @sender ;

    -- IF @sender_emp_id IS NOT NULL 
    -- BEGIN 
    --     SELECT @sender_org_id = organ_id 
    --     FROM Employee 
    --     WHERE ID = @sender_emp_id ;
    -- END 

    -- SELECT @reciever_emp_id = employee_id , @reciever_org_id = organ_id 
    -- FROM Interactor 
    -- WHERE interaction_code = @reciever ;

    -- IF @reciever_emp_id IS NOT NULL 
    -- BEGIN 
    --     SELECT @reciever_org_id = organ_id 
    --     FROM Employee 
    --     WHERE ID = @reciever_emp_id ;
    -- END 







    SET @sender_org_id = @sender ;
    IF @is_sender_organ = 0 
    BEGIN 
        SELECT @sender_org_id = organ_id 
        FROM Employee 
        WHERE ID = @sender ;
    END

    SET @reciever_org_id = @reciever ;
    IF @is_reciever_organ = 0 
    BEGIN 
        SELECT @reciever_org_id = organ_id 
        FROM Employee 
        WHERE ID = @reciever ;
    END 

    IF @type = 1  or @type = 2  -- varede or sadere 
    BEGIN
        IF @reciever_org_id <> @sender_org_id 
            RETURN 'TRUE' ;
        RETURN 'FALSE' ;
    END 

    IF @type = 3    -- dakheli 
    BEGIN 
        IF @reciever_org_id = @sender_org_id 
            RETURN 'TRUE' ;
        RETURN 'FALSE' ;
    END 

    RETURN 'FALSE' ;

END 


-- drop FUNCTION type_interactor_validator 