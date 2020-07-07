CREATE FUNCTION emp_can_be_created (
    @employee_id INTEGER ,
    @rank FLOAT
)
RETURNS NVARCHAR(5) AS
BEGIN

    IF @rank >= 3   -- if this emp is not modir amel or ozve heat modire
    BEGIN
        DECLARE @boss_rank FLOAT ;
        SELECT @boss_rank = MIN(e2.rank) FROM
        Employee e1 INNER JOIN Employee e2 
        ON e1.boss_id = e2.ID
        WHERE e1.ID = @employee_id

        IF @boss_rank <= @rank
        BEGIN
            RETURN 'TRUE' ;
        END ;

        RETURN 'FALSE';
    END;
    RETURN 'TRUE' ;

END

-- drop FUNCTION can_be_created;