CREATE PROCEDURE send_letter @sender INTEGER, @reciever INTEGER, @intermediate_interactor INTEGER , @is_sender_organ BIT, @is_reciever_organ BIT, @is_intermediate_interactor_organ BIT, @text NVARCHAR(MAX), @type INTEGER,  @letter_to_be_attached INTEGER, @doc_to_be_attached INTEGER , @file_to_be_attached NVARCHAR(MAX)
AS
    DECLARE @let_id TABLE (ID INTEGER ); 
    INSERT INTO Letter (sender,reciever,intermediate_interactor,is_sender_organ,is_reciever_organ,is_intermediate_interactor_organ,text_l,type_l)
    OUTPUT inserted.ID 
    INTO @let_id 
    VALUES (@sender,@reciever,@intermediate_interactor,@is_sender_organ,@is_reciever_organ,@is_intermediate_interactor_organ,@text,@type) ;
    
    IF( ( @doc_to_be_attached IS NOT NULL) OR (@letter_to_be_attached IS NOT NULL) OR (@file_to_be_attached IS NOT NULL ) )
    BEGIN
        DECLARE @id INTEGER ;
        SELECT @id = ID
        FROM @let_id ;

        INSERT INTO Attachment (letter_belong_to_id,letter_attached_id,document_attached_id,file_a) VALUES
        (@id,@letter_to_be_attached,@doc_to_be_attached,@file_to_be_attached) ;
    END 

go ;

-- drop procedure send_letter_to_employee;

EXEC send_letter @sender = 1 , @reciever = 1 , @intermediate_interactor=NULL , @is_sender_organ=1 , @is_reciever_organ = 0 , @is_intermediate_interactor_organ= 0 , @text = N'نامه شماره ۱' , @type=3, @letter_to_be_attached = Null , @doc_to_be_attached = Null , @file_to_be_attached = NULL ;

-- delete from Letter where ID = 1002 
-- select * from Interactor 
-- select * from Letter
-- select * from Attachment