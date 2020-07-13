CREATE PROCEDURE update_employee_name_by_id @id INTEGER, @new_name NVARCHAR(32) 
AS 
    UPDATE Employee 
    SET name = @new_name 
    WHERE ID = @id ;
GO ;

CREATE PROCEDURE update_employee_name_by_organ_id_and_personel_number @organ_id INTEGER, @personel_number NUMERIC(10,0), @new_name NVARCHAR(32)
AS
    UPDATE Employee 
    SET name = @new_name 
    WHERE organ_id = @organ_id and personel_number = @personel_number ;