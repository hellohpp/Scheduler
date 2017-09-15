USE otsystem
GO
DROP TABLE System_Log
DROP TABLE User_Credentials;
DROP TABLE User_Questions;
DROP TABLE User_Events;
DROP TABLE User_Communications;
DROP TABLE States;
DROP TABLE System_Events;
DROP TABLE Communcation_Method
DROP TABLE Password_Questions;
DROP TABLE Pages;
DROP TABLE Users;
GO
CREATE TABLE System_Events (
  Id int NOT NULL IDENTITY(1,1),
  Name nvarchar(45) NOT NULL unique,
  Abbr nvarchar(15) NOT NULL unique,
  PRIMARY KEY (Id)
)
GO
CREATE TABLE Pages (
  Id int NOT NULL IDENTITY(1,1),
  Name nvarchar(45) NOT NULL unique,
  Abbr nvarchar(15) NOT NULL unique,
  PRIMARY KEY (Id)
) 
GO
CREATE TABLE Communcation_Method (
  Id int NOT NULL IDENTITY(1,1),
  Name nvarchar(45) NOT NULL UNIQUE,
  Abbr nvarchar(15) NOT NULL UNIQUE,
  PRIMARY KEY (Id)
)
GO
CREATE TABLE Password_Questions (
  Id int NOT NULL IDENTITY(1,1),
  Name nvarchar(255) NOT NULL unique,
  Abbr nvarchar(8) NOT NULL unique,
  PRIMARY KEY (Id)
) 
GO
CREATE TABLE States (
  Id int NOT NULL,
  Name nvarchar(45) NOT NULL,
  Abbr nvarchar(15) NOT NULL,
  PRIMARY KEY (Id)
) 
GO
CREATE TABLE Users (
  Id int NOT NULL IDENTITY(1,1),
  FirstName nvarchar(45) NOT NULL,
  MiddleName nvarchar(45) DEFAULT '',
  LastName nvarchar(45) NOT NULL,
  Address nvarchar(45) DEFAULT '',
  City nvarchar(45) DEFAULT '',
  StateId int,
  IsActive bit DEFAULT 1,
  CreatedBy int NOT NULL,
  CreatedDate datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedBy int NOT NULL,
  UpdatedDate datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (Id),
  FOREIGN KEY (CreatedBy) REFERENCES Users (Id),
  FOREIGN KEY (UpdatedBy) REFERENCES Users (Id)
)
GO
CREATE TABLE User_Communications (
  Id int NOT NULL IDENTITY(1,1),
  UserId int NOT NULL,
  CommunicationId int DEFAULT NULL,
  Priority int DEFAULT 0,
  CreatedBy int NOT NULL,
  CreatedDate datetime DEFAULT CURRENT_TIMESTAMP,
  UpdatedBy int DEFAULT NULL,
  UpdatedDate datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (Id),
  FOREIGN KEY (CommunicationId) REFERENCES Communcation_Method (Id),
  FOREIGN KEY (CreatedBy) REFERENCES Users (Id),
  FOREIGN KEY (UpdatedBy) REFERENCES Users (Id)
)
GO
CREATE TABLE User_Events (
  Id int NOT NULL IDENTITY(1,1),
  UserId int NOT NULL,
  PageId int NOT NULL,
  EventId int NOT NULL,
  CreatedBy int NOT NULL,
  CreatedDate datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedBy int DEFAULT NULL,
  UpdatedDate datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (Id),
  FOREIGN KEY (CreatedBy) REFERENCES Users (Id),
  FOREIGN KEY (UpdatedBy) REFERENCES Users (Id),
  FOREIGN KEY (EventId) REFERENCES System_Events (Id),
  FOREIGN KEY (PageId) REFERENCES Pages (Id),
  FOREIGN KEY (UserId) REFERENCES Users (Id)
) 
GO
CREATE TABLE User_Questions (
  Id int NOT NULL IDENTITY(1,1),
  UserId int NOT NULL,
  QuestionId int NOT NULL,
  Answer nvarchar(255) NOT NULL,
  SortOrder int DEFAULT NULL,
  IsActive bit NOT NULL,
  CreatedBy int NOT NULL,
  CreatedOn datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedBy int NOT NULL,
  UpdatedOn datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (Id),
  FOREIGN KEY (CreatedBy) REFERENCES Users (Id),
  FOREIGN KEY (QuestionId) REFERENCES Password_Questions (Id),
  FOREIGN KEY (UpdatedBy) REFERENCES users (Id),
  FOREIGN KEY (UserId) REFERENCES users (Id)
)
GO
CREATE TABLE User_Credentials (
  Id int NOT NULL IDENTITY(1,1),
  UserName nvarchar(225) NOT NULL UNIQUE,
  Password nvarchar(225) NOT NULL,
  UserId int NOT NULL,
  IsActive bit DEFAULT NULL,
  CreatedBy int NOT NULL,
  CreatedDate datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedBy int NOT NULL,
  UpdateDate datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (Id),
  FOREIGN KEY (UserId) REFERENCES users (Id),
  FOREIGN KEY (CreatedBy) REFERENCES users (Id),
  FOREIGN KEY (UpdatedBy) REFERENCES users (Id)
)
GO
CREATE TABLE System_Log(
	Id				int				not null  IDENTITY(1,1),
	EventTime		datetime		not null,
	UserId			int,
	Code			int				not null,
	Description		nvarchar(255),
	Severity		int,
	ProcedureName	nvarchar(50),
	LineNumber		int
	Primary Key (Id),
	Foreign Key (UserId) References Users (Id)
)
GO

INSERT INTO Users VALUES ('Jon','Raymond','Wilson','3481 Park Avenue','Fairfield',7,1,1,'2016-06-16 15:45:06',1,'2016-06-16 15:45:06'),('Jeff','','Bloch','100 Reef Road','Fairfield ',7,1,1,'2016-06-16 15:46:52',1,'2016-06-16 15:46:52');
INSERT INTO Password_Questions VALUES ('What is your childhood street?','street'),('What is the name of your first pet?','pet'),('What is your mother''s maiden name?','mother');
INSERT INTO User_Questions VALUES (1,1,'Monroe',1,1,1,'2016-07-01 20:53:20',1,'2016-07-01 20:53:20'),(1,2,'Pepper',2,0,1,'2016-07-01 20:56:58',1,'2016-07-01 20:56:58'),(1,3,'Blewitt',3,1,1,'2016-07-01 20:56:58',1,'2016-07-01 20:56:58'),(1,2,'Sammy',2,1,1,'2016-07-01 20:56:58',1,'2016-07-01 20:56:58');
INSERT INTO Pages VALUES ('Login','login'),('Reset Password','reset'),('Dashboard','dashboard')
INSERT INTO System_Events VALUES ('Login','Login'),('Reset Questions','ResetQuestions'),('Validate Answers','ValidateAnswers'),('Reset Password','ResetPassword');
INSERT INTO User_Credentials VALUES ('jwilson0206@gmail.com','Wilson13',1,1,1,'2016-06-20 22:40:01',1,'2016-06-20 22:40:01');
INSERT INTO States VALUES (1,'Alabama','AL'),(2,'Alaska','AK'),(3,'Arizona','AZ'),(4,'Arkansas','AR'),(5,'California','CA'),(6,'Colorado','CO'),(7,'Connecticut','CT'),(8,'Delaware','DE'),(9,'District of Columbia','DC'),(10,'Florida','FL'),(11,'Georgia','GA'),(12,'Hawaii','HI'),(13,'Idaho','ID'),(14,'Illinois','IL'),(15,'Indiana','IN'),(16,'Iowa','IA'),(17,'Kansas','KS'),(18,'Kentucky','KY'),(19,'Louisiana','LA'),(20,'Maine','ME'),(21,'Maryland','MD'),(22,'Massachusetts','MA'),(23,'Michigan','MI'),(24,'Minnesota','MN'),(25,'Mississippi','MS'),(26,'Missouri','MO'),(27,'Montana','MT'),(28,'Nebraska','NE'),(29,'Nevada','NV'),(30,'New Hampshire','NH'),(31,'New Jersey','NJ'),(32,'New Mexico','NM'),(33,'New York','NY'),(34,'North Carolina','NC'),(35,'North Dakota','ND'),(36,'Ohio','OH'),(37,'Oklahoma','OK'),(38,'Oregon','OR'),(39,'Pennsylvania','PA'),(40,'Rhode Island','RI'),(41,'South Carolina','SC'),(42,'South Dakota','SD'),(43,'Tennessee','TN'),(44,'Texas','TX'),(45,'Utah','UT'),(46,'Vermont','VT'),(47,'Virginia','VA'),(48,'Washington','WA'),(49,'West Virginia','WV'),(50,'Wisconsin','WI'),(51,'Wyoming','WY');