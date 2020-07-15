CREATE PROCEDURE delete_employee_by_id @id INTEGER 
AS 
    DELETE FROM Employee 
    WHERE ID = @id ;
GO ;

-- EXEC delete_employee_by_id @id = 1 ;
CREATE PROCEDURE delete_employee_by_organ_id_and_personel_number @organ_id INTEGER, @personel_number NUMERIC(10,0)
AS 
    DELETE FROM Employee 
    WHERE organ_id = @organ_id and personel_number = @personel_number ;
GO ;

CREATE PROCEDURE delete_all_employees 
AS 
    DELETE FROM Employee ;
GO ;

CREATE PROCEDURE delete_all_employees_of_a_organization @organ_id INTEGER
AS 
    DELETE FROM Employee 
    WHERE organ_id = @organ_id ;
GO ;