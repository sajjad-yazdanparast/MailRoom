INSERT INTO Organization VALUES 
('Isfahan University')

INSERT INTO Organization VALUES 
('Tehran University')


INSERT INTO Employee (organ_id,personel_number,Employee.rank,name)
VALUES (1,2123456789,1,'sajjad');


INSERT INTO Employee (organ_id,personel_number,Employee.rank,name,boss_id)
VALUES (1,1123456789,3,'hossein',1);

INSERT INTO Interactor (name,address,telephone,postal_code,organ_id)
VALUES ('Isfahan University','hezar jerib',09136477484,09123456789,1)


INSERT INTO Interactor (name,address,telephone,postal_code,organ_id)
VALUES ('Tehran University','Daneshgah Street',09136477484,09123456789,2)

-- INSERT INTO Letter ()
-- VALUES () ;