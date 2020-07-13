CREATE PROCEDURE get_employee_by_id @id INTEGER 
AS 
    SELECT * FROM Employee 
    WHERE ID = @id ;
GO ;

CREATE PROCEDURE get_employee_by_organ_id_and_personel_number @organ_id INTEGER, @personel_number NUMERIC(10,0)
AS  
    SELECT * FROM Employee
    WHERE organ_id=@organ_id and personel_number = @personel_number ;
GO ;



