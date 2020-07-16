CREATE FUNCTION type_interactor_validator (
    @type INTEGER , 
    @sender INTEGER ,
    @reciever INTEGER ,
    @is_sender_organ BIT ,
    @is_reciever_organ BIT 
) RETURNS NVARCHAR(5) AS 
BEGIN 

    DECLARE @sender_org_id INTEGER ;



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

    RETURN 'TRUE' ;

END 


-- drop FUNCTION type_interactor_validator 