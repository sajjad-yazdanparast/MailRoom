INSERT INTO Organization (name,address,telephone) VALUES 
('Isfahan University','Hezar jerib',09136477484) ,
('Tehran University','koye daneshgah',09136477484)

select * from Organization

INSERT INTO Employee (organ_id,personel_number,Employee.rank,name,telephone)
VALUES (1,2123456789,1,'sajjad',09123456789);


INSERT INTO Employee (organ_id,personel_number,Employee.rank,name,boss_id,telephone)
VALUES (1,1123456789,3,'hossein',1,09123456789);

INSERT INTO Employee (organ_id,personel_number,Employee.rank,name,boss_id,telephone)
VALUES (2,3123456789,7,'mohammad',1,09123456789);

select * from Employee

INSERT INTO Interactor (employee_id,organ_id) VALUES 
(1,null) ,
(null,1) 

INSERT INTO Interactor (employee_id,organ_id) VALUES 
(2,null) ,
(null,2) ,
(3,null)

-- INSERT INTO Letter ()
-- VALUES () ;


select * from Interactor
-- 10000000001
-- 09136477484

INSERT INTO Letter (sender,reciever,type_l,text_l) 
VALUES (1000000,1000001,3,N'سلام نظر به فلان ، فلان کار را بکنید') 


INSERT INTO Letter (sender,reciever,type_l,text_l) 
VALUES (1000000,1000003,3,N'سلام نظر به فلان ، فلان کار را بکنید') 
-- rank to khodet bayead por koni sajjad 
select * from Letter

-- DECLARE @text NVARCHAR(MAX) ;
-- SET @text = 'الو سلام دوستت دارم'
-- DECLARE @SQLString nvarchar(500);
-- SET @SQLString = 'INSERT INTO Document (owner_d,type_d,text_d) VALUES(1000000,2,N''' + @text + ''')'

-- exec (@SQLString )

INSERT INTO Document (owner_d,type_d,text_d) VALUES
(1000000,2,N'یاااااااااااااااا علی')

SELECT * from Document

INSERT INTO Attachment (document_belong_to_id,letter_attached_id,file_a) VALUES
(1,1,'asffasfasfafafafaafa')
-- select 1,1, BulkColumn from Openrowset (Bulk '/home/sajjad/Documents/resume/*sajjad-yazdanparast.pdf', Single_Blob) as file_a

select * from Attachment

delete from Attachment