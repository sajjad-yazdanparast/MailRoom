CREATE TABLE Employee (
    ID INTEGER IDENTITY(1,1) ,  -- auto increment primary key
    boss_id Integer ,
    name NVARCHAR(32) NOT NULL,
    personel_number NUMERIC(10,0) NOT NULL  ,

    PRIMARY KEY (ID) , 
    FOREIGN KEY (boss_id) REFERENCES Employee(ID) 
) ;

CREATE TABLE Position (
    ID INTEGER IDENTITY(1,1)  ,  -- auto increment primary key
    employee_id INTEGER NOT NULL ,          -- foreign key to employee
    name NVARCHAR(32) NOT NULL DEFAULT N'کارمند معمولی',
    level FLOAT NOT NULL DEFAULT 4,

    PRIMARY KEY (ID) ,
    FOREIGN KEY (employee_id) REFERENCES Employee (ID)
) ;





CREATE TABLE Organization (
    ID INTEGER IDENTITY(1,1) ,
    name NVARCHAR(64) NOT NULL UNIQUE ,

    PRIMARY KEY (ID) 
) ;

CREATE TABLE Interactor (
    ID INTEGER IDENTITY(1,1) ,  -- auto increment primary key 
    name NVARCHAR(64) NOT NULL ,
    address NVARCHAR(256) NOT NULL ,
    telephone NUMERIC(11,0) NOT NULL,   
    postal_code NUMERIC(11,0) NOT NULL ,

    employee_id INTEGER ,
    organ_id INTEGER ,

    PRIMARY KEY (ID) ,
    FOREIGN KEY (employee_id) REFERENCES Employee(ID) ,
    FOREIGN KEY (organ_id) REFERENCES Organization(ID) ,

    CONSTRAINT CK_emp_or_org CHECK (
        CASE WHEN employee_id IS NULL THEN 0 ELSE 1 END +
      CASE WHEN organ_id  IS NULL THEN 0 ELSE 1 END = 1
    ) ,

    CONSTRAINT CK_validate_name CHECK (dbo.validate_name(name,employee_id,organ_id)='TRUE')
);


CREATE TABLE Letter (
    ID INTEGER IDENTITY(1,1),    --auto increment primary key
    sender INTEGER ,
    reciever INTEGER ,
    text_l NVARCHAR(MAX) ,
    type_l INTEGER ,
    date_l DATE DEFAULT GETUTCDATE() ,


    PRIMARY KEY (ID) ,
    FOREIGN KEY (sender) REFERENCES Interactor(ID) ,
    FOREIGN KEY (reciever) REFERENCES Interactor(ID) 

) ;

CREATE TABLE Document (
    ID INTEGER IDENTITY(1,1),    --auto increment primary key
    owner_d INTEGER ,
    text_d NVARCHAR(MAX) ,
    type_d INTEGER ,
    date_d DATE DEFAULT GETUTCDATE() ,


    PRIMARY KEY (ID) ,
    FOREIGN KEY (owner_d) REFERENCES Interactor(ID) 
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
