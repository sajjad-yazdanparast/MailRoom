INSERT INTO Organization (name,address,telephone) VALUES 
('Isfahan University','Hezar jerib',09136477484) ,
('Tehran University','koye daneshgah',09136477484)


INSERT INTO Employee (organ_id,personel_number,Employee.rank,name,telephone)
VALUES (1,2123456789,1,'sajjad',09123456789);


INSERT INTO Employee (organ_id,personel_number,Employee.rank,name,boss_id,telephone)
VALUES (1,1123456789,3,'hossein',1,09123456789);

INSERT INTO Interactor (employee_id,organ_id) VALUES 
(1,null) ,
(null,1) 

-- INSERT INTO Letter ()
-- VALUES () ;

select * from Interactor