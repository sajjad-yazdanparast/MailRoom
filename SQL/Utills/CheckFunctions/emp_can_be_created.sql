CREATE FUNCTION emp_can_be_created (
    @employee_id INTEGER ,
    @organ_id INTEGER ,
    @rank FLOAT
)
RETURNS NVARCHAR(5) AS
BEGIN

    IF @rank >= 3   -- if this emp is not modir amel or ozve heat modire
    BEGIN
        DECLARE @boss_rank FLOAT ;
        SELECT @boss_rank = MIN(e2.rank) FROM
        Employee e1 INNER JOIN Employee e2 
        ON e1.organ_id = @organ_id AND e1.boss_personel_number = e2.personel_number
        WHERE e1.personel_number = @employee_id

        IF @boss_rank <= @rank
        BEGIN
            RETURN 'TRUE' ;
        END ;

        RETURN 'FALSE';
    END;
    RETURN 'TRUE' ;

END

-- drop FUNCTION emp_can_be_created;