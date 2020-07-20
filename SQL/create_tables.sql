

CREATE TABLE Organization (
    ID INTEGER IDENTITY(1,1) ,
    name NVARCHAR(64) NOT NULL UNIQUE ,
    address NVARCHAR(256) NOT NULL , -- --> give it to each organization
    telephone NUMERIC(11,0) NOT NULL,  
    PRIMARY KEY (ID) 
) ;


CREATE TABLE Position (
    rank FLOAT ,
    name NVARCHAR(64) NOT NULL UNIQUE,

    PRIMARY KEY (rank) ,
) ;
-- Initializing Positions 
INSERT INTO Position (rank,name) VALUES 
(1,N'مدیر عامل')
INSERT INTO Position (rank,name) VALUES 
(2,N'عضو هیئت مدیره')
INSERT INTO Position (rank,name) VALUES 
(3,N'معاون')
INSERT INTO Position (rank,name) VALUES 
(4,N'کارشناس ارشد')
INSERT INTO Position (rank,name) VALUES 
(5,N'کارشناس پایه')
INSERT INTO Position (rank,name) VALUES 
(6,N'کارمند ارشد')
INSERT INTO Position (rank,name) VALUES 
(7,N'کارمند پایه')
INSERT INTO Position (rank,name) VALUES 
(8,N'خدمتکار')


CREATE TABLE Employee (
    -- ID INTEGER IDENTITY(1,1) ,  -- auto increment primary key
    organ_id INTEGER ,          -- foreign key to Organization
    personel_number NUMERIC(10,0)  , -- unique in each organization


    name NVARCHAR(32) NOT NULL,
    telephone NUMERIC(11,0) NOT NULL,   
    rank FLOAT DEFAULT 7 ,               -- Foreign key to Position
    
    boss_personel_number NUMERIC(10,0) ,           -- Forein key to Employee




    PRIMARY KEY (organ_id,personel_number) , 
    FOREIGN KEY (rank) REFERENCES Position(rank) ON DELETE SET DEFAULT ,
    FOREIGN KEY (organ_id) REFERENCES Organization(ID) ON DELETE CASCADE,

    CONSTRAINT CK_has_boss_except_levels_below_3 CHECK (
        CASE WHEN rank <3  THEN 1 ELSE 0 END +
        CASE WHEN boss_personel_number  IS NULL THEN 0 ELSE 1 END = 1
    ) ,
    CONSTRAINT CK_emp_can_be_created CHECK (dbo.emp_can_be_created(personel_number,organ_id,rank)='TRUE'),
    
    -- At first , every employee is being added as a basic employee 
) ;




CREATE TABLE EmployeePosition (
    employee_personel_number NUMERIC(10,0) ,
    organ_id INTEGER ,
    rank FLOAT DEFAULT 7,

    PRIMARY KEY (organ_id,employee_personel_number,rank) ,
    FOREIGN KEY (organ_id,employee_personel_number) REFERENCES Employee (organ_id,personel_number) ON DELETE CASCADE ,
    FOREIGN KEY (rank) REFERENCES Position(rank) ON DELETE SET DEFAULT
)


CREATE TABLE Interactor (
    ID INTEGER IDENTITY(1,1) ,

    organ_id INTEGER , 
    personel_number NUMERIC(10,0) ,

    UNIQUE(organ_id,personel_number) ,

    PRIMARY KEY (ID) ,
    FOREIGN KEY (organ_id,personel_number) REFERENCES Employee(organ_id,personel_number) ON DELETE CASCADE 
)


CREATE TABLE Letter (
    ID INTEGER IDENTITY(1,1),    --auto increment primary key

    text_l NVARCHAR(MAX) ,
    date_l DATE DEFAULT GETUTCDATE() ,
    type_l INTEGER ,



    PRIMARY KEY (ID) ,
    
    CONSTRAINT CK_type_l_in_range CHECK (type_l in (1,2,3,4)) ,
    -- type | name 
    -- 1    | varede
    -- 2    | sadere
    -- 3    | dakheli 
    -- 4    | khareji

    -- CONSTRAINT CK_only_in_type_4_intermediate_interactor_should_be_valid CHECK (
    --     CASE WHEN intermediate_interactor IS NULL THEN 0 ELSE 1 END +
    --     CASE WHEN type_l = 4 THEN 0 ELSE 1 END = 1
    --   ) ,
    -- CONSTRAINT CK_type_interactor_validation CHECK (dbo.type_interactor_validator(type_l,sender,reciever,is_sender_organ,is_reciever_organ)='TRUE')

) ;

CREATE TABLE InteractorLetter (
    letter_id INTEGER ,
    sender INTEGER ,
    reciever INTEGER ,
    intermediate_interactor INTEGER ,

    date_l DATE DEFAULT GETUTCDATE() ,

    UNIQUE(letter_id,sender,intermediate_interactor,reciever) ,

    -- FOREIGN KEY (letter_id) REFERENCES Letter(ID) ON DELETE CASCADE,
    -- FOREIGN KEY (sender) REFERENCES Interactor (ID) ON DELETE SET NULL ,
    -- FOREIGN KEY (reciever) REFERENCES Interactor (ID) ON DELETE SET NULL ,
    -- FOREIGN KEY (intermediate_interactor) REFERENCES Interactor (ID) ON DELETE SET NULL ,

)
CREATE TABLE Document (
    ID INTEGER IDENTITY(1,1),    --auto increment primary key
    text_d NVARCHAR(MAX) ,
    type_d INTEGER ,

    owner_id INTEGER ,
    date_d DATE DEFAULT GETUTCDATE() ,


    PRIMARY KEY (ID) ,
    FOREIGN KEY (owner_id) REFERENCES Interactor(ID) ON DELETE SET NULL ,

    CONSTRAINT CK_type_d_in_range CHECK (type_d in (1,2,3,4,5)) 
    -- type | name 
    -- 1    | adi 
    -- 2    | mahramane 
    -- 3    | kheyli mahramane 
    -- 4    | serri 
    -- 5    | be koli serri 
) ;


CREATE TABLE Attachment (
    ID INTEGER IDENTITY(1,1) ,
    letter_belong_to_id INTEGER , -- belong to which letter
    document_belong_to_id INTEGER ,   -- belong to which document
    letter_attached_id INTEGER ,     -- which letter is attached to this attachment
    document_attached_id INTEGER ,   -- which document is attached to this attachment
    file_a NVARCHAR(MAX) ,   -- files such as images, voices, ...

    PRIMARY KEY(ID) ,
    FOREIGN KEY (letter_belong_to_id) REFERENCES Letter(ID) ON DELETE NO ACTION ,
    FOREIGN KEY (document_belong_to_id) REFERENCES Document(ID) ON DELETE NO ACTION ,
    FOREIGN KEY (letter_attached_id) REFERENCES Letter(ID) ON DELETE SET NULL  ,
    FOREIGN KEY (document_attached_id) REFERENCES Document(ID) ON DELETE SET NULL ,

    CONSTRAINT CK_not_self_attachment CHECK (
        letter_belong_to_id <> letter_attached_id 
        and 
        document_belong_to_id <> document_attached_id
    )
);
