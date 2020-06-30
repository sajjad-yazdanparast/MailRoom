CREATE TABLE Employee (
    ID INTEGER IDENTITY(1,1) ,  -- auto increment primary key
    name NVARCHAR(32) NOT NULL,
    personel_number NUMERIC(10,0) NOT NULL  ,

    PRIMARY KEY (ID) 
) ;

CREATE TABLE Dignity (
    ID INTEGER IDENTITY(1,1)  ,  -- auto increment primary key
    employee_id INTEGER NOT NULL ,          -- foreign key to emplyee
    name NVARCHAR(32) NOT NULL ,
    level INTEGER NOT NULL ,

    PRIMARY KEY (ID) ,
    FOREIGN KEY (employee_id) REFERENCES Employee (ID)
) ;

CREATE TABLE Organization (
    ID INTEGER IDENTITY(1,1) ,
    name NVARCHAR(64) NOT NULL ,

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

);