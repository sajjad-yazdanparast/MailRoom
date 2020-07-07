CREATE TRIGGER EmployeePosition_creational_trigger
ON Employee
AFTER INSERT 
AS
BEGIN 
    SET NOCOUNT ON ;
    DECLARE @employee_id INTEGER ;
    DECLARE @rank FLOAT ;

    SELECT @employee_id = i.ID , @rank = i.rank FROM inserted i ;
    INSERT INTO EmployeePosition (employee_id,rank) 
    VALUES (@employee_id,@rank) ;

    PRINT 'EmployeePosition added ;'


END 

-- CREATE FUNCTION employee_position_creation_signal (
--     @employee_id INTEGER ,
--     @level FLOAT
-- ) RETURNS NVARCHAR(5) as 
-- BEGIN

--     DECLARE @boss_level FLOAT ;

--     IF @level >= 3   -- if this emp is not modir amel or ozve heat modire
--     BEGIN
--         SELECT @boss_level = MIN(e2.rank) FROM
--         Employee e1 INNER JOIN Employee e2 
--         ON e1.boss_id = e2.ID
--         WHERE e1.ID = @employee_id

--         IF @boss_level <= @level
--         BEGIN
--             INSERT INTO EmployeePosition (employee_id,rank)  VALUES
--             (@employee_id,@level) ;
--             RETURN 'TRUE'
--         END
--         RETURN 'FALSE' ;
--     END
--     -- this emp is modir amel or ozve heiat modire
--     INSERT INTO EmployeePosition (employee_id,rank)  VALUES
--     (@employee_id,@level) ;
--     RETURN 'TRUE' ;

-- END 


