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


INSERT INTO Interactor (interaction_code,is_organ) VALUES 
(1,1) ,
(2,1) 


INSERT INTO Interactor (interaction_code,is_organ) VALUES 
(1,0)  ,
(2,0) ,
(3,0)

-- INSERT INTO Letter ()
-- VALUES () ;

-- delete from Employee where ID =1  ;

-- select * from Employee

-- select * from Interactor
-- delete from Employee WHERE ID = 15 ;
-- select * from Interactor

-- 10000000001
-- 09136477484

INSERT INTO Letter (sender,reciever,is_sender_organ,is_reciever_organ,type_l,text_l) 
VALUES (1,2,0,0,3,N'سلام نظر به فلان ، فلان کار را بکنید') 


INSERT INTO Letter (sender,reciever,is_sender_organ,is_reciever_organ,type_l,text_l) 
VALUES (1,3,0,0,2,N'سلام نظر به فلان ، فلان کار را بکنید') 


INSERT INTO Letter (sender,reciever,is_sender_organ,is_reciever_organ,type_l,text_l) 
VALUES (1,3,1,0,2,N'سلام نظر به فلان ، فلان کار را بکنید') 
-- rank to khodet bayead por koni sajjad 

select * from Letter

-- DECLARE @text NVARCHAR(MAX) ;
-- SET @text = 'الو سلام دوستت دارم'
-- DECLARE @SQLString nvarchar(500);
-- SET @SQLString = 'INSERT INTO Document (owner_d,type_d,text_d) VALUES(1000000,2,N''' + @text + ''')'

-- exec (@SQLString )

INSERT INTO Document (owner_id,is_owner_organ,type_d,text_d) VALUES
(1,0,2,N'یاااااااااااااااا علی')

SELECT * from Document

INSERT INTO Attachment (document_belong_to_id,letter_attached_id,file_a) VALUES
(1,1,'asffasfasfafafafaafa')
-- select 1,1, BulkColumn from Openrowset (Bulk '/home/sajjad/Documents/resume/*sajjad-yazdanparast.pdf', Single_Blob) as file_a

select * from Attachment

-- delete from Attachment



SELECT * from Organization

select * from Letter
select * from Employee
DELETE from Organization where Id = 1 ;
select * from Employee
SELECT * from Letter

SELECT * from Organization
