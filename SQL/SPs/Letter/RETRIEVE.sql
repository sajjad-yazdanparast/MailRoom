CREATE PROCEDURE organization_get_its_sent_letters @organ_id INTEGER
AS 
    SELECT * FROM 
    Letter  
    WHERE sender = @organ_id AND is_sender_organ = 1 ;
GO ;

CREATE PROCEDURE organization_get_its_recieved_letters @organ_id INTEGER
AS 
    SELECT * FROM 
    Letter  
    WHERE reciever = @organ_id AND is_sender_organ = 1 ;
Go;    


CREATE PROCEDURE employee_get_its_sent_letters @employee_id INTEGER
AS 
    SELECT * FROM 
    Letter  
    WHERE sender = @employee_id AND is_sender_organ = 0 ;
GO ;

CREATE PROCEDURE employee_get_its_recieved_letters @employee_id INTEGER
AS 
    SELECT * FROM 
    Letter  
    WHERE reciever = @employee_id AND is_sender_organ = 1 ;
Go;    

CREATE PROCEDURE filter_letters @sender INTEGER = -1, @reciever INTEGER = -1 ,@type INTEGER = -1 , @date NVARCHAR(10) = '%'
AS
    SELECT * FROM Letter l WHERE 
    (sender = @sender OR @sender = -1 ) AND
    (reciever = @reciever OR @reciever =-1) AND 
    (type_l = @type OR @type = -1) AND
    (date_l = @date OR @date = '%')

-- drop PROCEDURE filter_letters

SELECT * from Letter 
EXEC filter_letters @sender=2 , @reciever =1 , @type=3 , @date = '2020-07-16'
EXEC filter_letters @sender=2 , @reciever =1 , @date = '2020-07-16'
EXEC filter_letters @sender=1 , @reciever =1 , @type=3 , @date = '2020-07-16'
-- SELECT * from Letter 
