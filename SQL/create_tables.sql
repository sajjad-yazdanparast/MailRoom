

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
    ID INTEGER IDENTITY(1,1) ,  -- auto increment primary key
    organ_id INTEGER ,          -- foreign key to Organization
    personel_number NUMERIC(10,0) NOT NULL  ,
    telephone NUMERIC(11,0) NOT NULL,   
    rank FLOAT ,               -- Foreign key to Position
    boss_id Integer ,           -- Forein key to Employee
    name NVARCHAR(32) NOT NULL,

    
    UNIQUE(organ_id,personel_number) ,

    PRIMARY KEY (ID) , 
    FOREIGN KEY (rank) REFERENCES Position(rank) ,


    CONSTRAINT CK_has_boss_except_levels_below_3 CHECK (
        CASE WHEN rank <3  THEN 1 ELSE 0 END +
        CASE WHEN boss_id  IS NULL THEN 0 ELSE 1 END = 1
    ) ,
    CONSTRAINT CK_emp_can_be_created CHECK (dbo.emp_can_be_created(ID,rank)='TRUE'),
    
    -- At first , every employee is being added as a basic employee 
) ;




CREATE TABLE EmployeePosition (
    employee_id INTEGER ,
    rank FLOAT ,

    PRIMARY KEY (employee_id,rank) ,
    FOREIGN KEY (employee_id) REFERENCES Employee (ID),
    FOREIGN KEY (rank) REFERENCES Position(rank)
)


CREATE TABLE Interactor (
    -- ID INTEGER IDENTITY(1,1) ,  -- auto increment primary key 
    -- name NVARCHAR(64) NOT NULL , -- delete it 
    -- address NVARCHAR(256) NOT NULL , -- --> give it to each organization
    -- telephone NUMERIC(11,0) NOT NULL,   -- --> give it to each employee
    interaction_code NUMERIC(11,0) IDENTITY(10000000000,1) , -- --> make this as primary key

    employee_id INTEGER ,
    organ_id INTEGER ,

    PRIMARY KEY (interaction_code) ,
    FOREIGN KEY (employee_id) REFERENCES Employee(ID) ,
    FOREIGN KEY (organ_id) REFERENCES Organization(ID) ,

    CONSTRAINT CK_emp_or_org CHECK (
        CASE WHEN employee_id IS NULL THEN 0 ELSE 1 END +
      CASE WHEN organ_id  IS NULL THEN 0 ELSE 1 END = 1
    ) ,

    -- CONSTRAINT CK_validate_name CHECK (dbo.validate_name(name,employee_id,organ_id)='TRUE')
);


CREATE TABLE Letter (
    ID INTEGER IDENTITY(1,1),    --auto increment primary key
    sender INTEGER ,                -- foreign key to interactor 
    reciever INTEGER ,              -- foreign key to interactor 
    intermediate_interactor INTEGER , -- foreign key to interactor 
    text_l NVARCHAR(MAX) ,
    type_l INTEGER ,
    date_l DATE DEFAULT GETUTCDATE() ,


    PRIMARY KEY (ID) ,
    FOREIGN KEY (sender) REFERENCES Interactor(interaction_code) ,
    FOREIGN KEY (reciever) REFERENCES Interactor(interaction_code) ,
    FOREIGN KEY (intermediate_interactor) REFERENCES Interactor(interaction_code) ,

    CONSTRAINT CK_type_l_in_range CHECK (type_l in (1,2,3,4)) ,
    -- type | name 
    -- 1    | varede
    -- 2    | sadere
    -- 3    | dakheli 
    -- 4    | khareji
    CONSTRAINT CK_only_in_type_4_intermediate_interactor_should_be_valid CHECK (
        CASE WHEN intermediate_interactor IS NULL THEN 0 ELSE 1 END +
        CASE WHEN type_l = 4 THEN 0 ELSE 1 END = 1
      ) ,
    CONSTRAINT CK_type_interactor_validation CHECK (dbo.type_interactor_validator(type_l,sender,reciever)='TRUE')

) ;

CREATE TABLE Document (
    ID INTEGER IDENTITY(1,1),    --auto increment primary key
    owner_d INTEGER ,
    text_d NVARCHAR(MAX) ,
    type_d INTEGER ,
    date_d DATE DEFAULT GETUTCDATE() ,


    PRIMARY KEY (ID) ,
    FOREIGN KEY (owner_d) REFERENCES Interactor(interaction_code) ,

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
    file_a VARBINARY(MAX) ,   -- files such as images, voices, ...

    PRIMARY KEY(ID) ,
    FOREIGN KEY (letter_belong_to_id) REFERENCES Letter(ID) ,
    FOREIGN KEY (document_belong_to_id) REFERENCES Document(ID) ,
    FOREIGN KEY (letter_attached_id) REFERENCES Letter(ID) ,
    FOREIGN KEY (document_attached_id) REFERENCES Document(ID) ,

    CONSTRAINT CK_not_self_attachment CHECK (
        letter_belong_to_id <> letter_attached_id 
        and 
        document_belong_to_id <> document_attached_id
    )
);
