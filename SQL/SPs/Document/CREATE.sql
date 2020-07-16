CREATE PROCEDURE organization_create_doc @organ_id INTEGER, @type INTEGER, @text NVARCHAR(MAX), @letter_to_be_attached INTEGER, @doc_to_be_attached INTEGER , @file_to_be_attached NVARCHAR(MAX)
AS
    DECLARE @doc_id TABLE (ID INTEGER ); 
    INSERT INTO Document (owner_id,is_owner_organ,text_d,type_d)
    OUTPUT inserted.ID 
    INTO @doc_id 
    VALUES (@organ_id,1,@text,@type) ;

    IF( ( @doc_to_be_attached IS NOT NULL) OR (@letter_to_be_attached IS NOT NULL) OR (@file_to_be_attached IS NOT NULL ) )
    BEGIN
        DECLARE @id INTEGER ;
        SELECT @id = ID
        FROM @doc_id ;

        INSERT INTO Attachment (document_belong_to_id,letter_attached_id,document_attached_id,file_a) VALUES
        (@id,@letter_to_be_attached,@doc_to_be_attached,@file_to_be_attached) ;
    END 
GO ;

-- drop PROCEDURE organization_create_doc

-- EXEC organization_create_doc @organ_id=2 ,@type=1, @text=N'سلام', @letter_to_be_attached=NULL , @doc_to_be_attached=1 , @file_to_be_attached = NULL;
-- GO ;

CREATE PROCEDURE employee_create_doc @employee_id INTEGER, @type INTEGER, @text NVARCHAR(MAX), @letter_to_be_attached INTEGER, @doc_to_be_attached INTEGER , @file_to_be_attached NVARCHAR(MAX)
AS
    DECLARE @doc_id TABLE (ID INTEGER ); 
    INSERT INTO Document (owner_id,is_owner_organ,text_d,type_d)
    OUTPUT inserted.ID 
    INTO @doc_id 
    VALUES (@employee_id,0,@text,@type) ;


    IF @doc_to_be_attached IS NOT NULL OR @letter_to_be_attached IS NOT NULL OR @file_to_be_attached IS NOT NULL 
    BEGIN
        DECLARE @id INTEGER ;
        SELECT @id = ID
        FROM @doc_id ;

        INSERT INTO Attachment (document_belong_to_id,letter_attached_id,document_attached_id,file_a) VALUES
        (@id,@letter_to_be_attached,@doc_to_be_attached,@file_to_be_attached) ;
    END 
GO ;
-- -- drop PROCEDURE employee_create_doc
-- EXEC employee_create_doc @employee_id=2 ,@type=1, @text=N'سلام', @letter_to_be_attached=null , @doc_to_be_attached=null , @file_to_be_attached = 'mamad.jpg';


-- select * from Letter
-- select * from Interactor


-- SELECT * from Document 
-- SELECT * from Attachment
