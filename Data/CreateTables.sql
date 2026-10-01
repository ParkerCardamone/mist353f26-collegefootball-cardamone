/*CREATE USER NandaSurendra
FOR LOGIN NandaSurendra;

ALTER ROLE db_owner
ADD MEMBER NandaSurendra;
alter role db_owner add member NandaSurendra;

SELECT IS_ROLEMEMBER('db_owner', 'NandaSurendra') AS IsDbOwner;
*/
if object_id('Team', 'U') is not null drop table Team;
if object_id('Stadium', 'U') is not null drop table Stadium;    
if object_id('Game', 'U') is not null drop table Game;
if object_id('AppUser', 'U') is not null drop table AppUser;
if object_id('Roster', 'U') is not null drop table Roster;
if object_id('Player', 'U') is not null drop table Player;
go
create table Team(
    TeamId int identity(1,1) not null,
    TeamName char(50) not null,
    UniversityName varchar(50) not null,
    CurrentTeamRecord varchar(10) null,
    CONSTRAINT UQ_TeamName unique (TeamName),
    constraint PK_Team primary key (TeamId),
);
go
create table Stadium(
    StadiumId int identity(1,1) not null,
    StadiumName char(50) not null,
    StadiumAddress varchar(50) not null,
    StadiumCapacity int not null,
    StadiumGrassType char(20) not null,
    TeamId int not null,
    foreign key (TeamId) references Team(TeamId),
    CONSTRAINT UQ_StadiumName unique (StadiumName),
    constraint PK_Stadium primary key (StadiumId),
    constraint CK_TypeOfGrass check (StadiumGrassType in ('Artificial Turf', 'Grass'))
);
go
create table Game(
    GameId int identity(1,1) not null,
    GameDate date not null,
    GameTime time not null,
    HomeScore int null,
    AwayScore int null,
    HomeTeamId int not null,
    AwayTeamId int not null,
    StadiumId int null,
    foreign key (HomeTeamId) references Team(TeamId),
    foreign key (AwayTeamId) references Team(TeamId),
    foreign key (StadiumId) references Stadium(StadiumId),
    CONSTRAINT FK_GameHomeTeam foreign key (HomeTeamId) references Team(TeamId),
    CONSTRAINT FK_GameAwayTeam foreign key (AwayTeamId) references Team(TeamId),
    constraint UQ_GameDateTime unique (HomeTeamId, GameDate, GameTime),
    constraint PK_Game primary key (GameId),
);
go
create table AppUser(
    UserId int identity(1,1) not null,
    UserName char(50) not null,
    UserDOB date not null,
    UserEmail varchar(50) not null,
    UserPassword varchar(50) not null,
    CONSTRAINT UQ_UserEmail unique (UserEmail),
    constraint PK_AppUser primary key (UserId),
);
go
create table Roster(
    RosterId int identity(1,1) not null,
    TeamId int not null,
    RosterYear int not null,
    RosterWins int null,
    RosterLosses int null,
    RosterTies int null,
    foreign key (TeamId) references Team(TeamId),
    constraint PK_Roster primary key (RosterId),
);
go
create table Player(
    PlayerId int identity(1,1) not null,
    PlayerName char(50) not null,
    PlayerPosition char(20) not null,
    PlayerHeight varchar(10) not null,
    PlayerWeight int not null,
    PlayerDOB date not null,
    RosterId int not null,
    foreign key (RosterId) references Roster(RosterId),
    constraint PK_Player primary key (PlayerId),
);

