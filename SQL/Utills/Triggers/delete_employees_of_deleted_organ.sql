-- CREATE TRIGGER delete_employees_of_deleted_organ
-- ON Organization
-- AFTER DELETE 
-- AS
-- BEGIN 
--     SET NOCOUNT ON ;
--     DELETE FROM Employee
--     WHERE organ_id = (SELECT ID from deleted)
--     PRINT 'Letters of this Employee has been deleted successfully!' ;


-- END 

-- -- drop Trigger delete_letters_of_deleted_employee;