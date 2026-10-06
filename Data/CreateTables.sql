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
if object_id('PlayerStats', 'U') is not null drop table PlayerStats;
if object_id('QBStats', 'U') is not null drop table QBStats;
if object_id('RBStats', 'U') is not null drop table RBStats;
if object_id('DefenderStats', 'U') is not null drop table DefenderStats;
if object_id('KickerStats', 'U') is not null drop table KickerStats;
if object_id('PunterStats', 'U') is not null drop table PunterStats
if object_id('ReturnerStats', 'U') is not null drop table ReturnerStats;
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
/*
go
create table AppUser(
    UserId int identity(1,1) not null,
    UserName char(50) not null,
    UserDOB date not null,
    UserEmail varchar(50) not null,
    UserPassword varchar(50) not null,
    CONSTRAINT UQ_UserEmail unique (UserEmail),
    constraint PK_AppUser primary key (UserId),
);*/
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
go
create table PlayerStats(
    PlayerStatsId int identity(1,1) not null,
    PlayerId int not null,
    RosterId int not null,
    PassingYards int null,
    RushingYards int null,
    ReceivingYards int null,
    Touchdowns int null,
    foreign key (PlayerId) references Player(PlayerId),
    foreign key (RosterId) references Roster(RosterId),
    constraint PK_PlayerStats primary key (PlayerStatsId),
);
go
create table QBStats(
    QBStatsId int identity(1,1) not null,
    PlayerId int not null,
    RosterId int not null,
    PassingAttempts int null,
    PassingCompletions int null,
    PassingYards int null,
    PassingTouchdowns int null,
    Interceptions int null,
    foreign key (PlayerId) references Player(PlayerId),
    foreign key (RosterId) references Roster(RosterId),
    constraint PK_QBStats primary key (QBStatsId),
);
go
create table RBStats(
    RBStatsId int identity(1,1) not null,
    PlayerId int not null,
    RosterId int not null,
    RushingAttempts int null,
    RushingYards int null,
    RushingTouchdowns int null,
    LongestRush int null,
    Fumbles int null,
    foreign key (PlayerId) references Player(PlayerId),
    foreign key (RosterId) references Roster(RosterId),
    constraint PK_RBStats primary key (RBStatsId),
);
go
create table DefenderStats(
    DefenderStatsId int identity(1,1) not null,
    PlayerId int not null,
    RosterId int not null,
    Tackles int null,
    Sacks int null,
    Interceptions int null,
    ForcedFumbles int null,
    DefensiveTouchdowns int null,
    foreign key (PlayerId) references Player(PlayerId),
    foreign key (RosterId) references Roster(RosterId),
    constraint PK_DefenderStats primary key (DefenderStatsId),
);
GO
create table KickerStats(
    KickerStatsId int identity(1,1) not null,
    PlayerId int not null,
    RosterId int not null,
    FieldGoalsMade int null,
    FieldGoalsAttempted int null,
    ExtraPointsMade int null,
    ExtraPointsAttempted int null,
    LongestFieldGoal int null,
    foreign key (PlayerId) references Player(PlayerId),
    foreign key (RosterId) references Roster(RosterId),
    constraint PK_KickerStats primary key (KickerStatsId),
);
GO
create table PunterStats(
    PunterStatsId int identity(1,1) not null,
    PlayerId int not null,
    RosterId int not null,
    Punts int null,
    PuntYards int null,
    LongestPunt int null,
    foreign key (PlayerId) references Player(PlayerId),
    foreign key (RosterId) references Roster(RosterId),
    constraint PK_PunterStats primary key (PunterStatsId),
);
GO
create table ReturnerStats(
    ReturnerStatsId int identity(1,1) not null,
    PlayerId int not null,
    RosterId int not null,
    KickReturns int null,
    KickReturnYards int null,
    KickReturnLong int null,
    KickReturnTouchdowns int null,
    PuntReturns int null,
    PuntReturnYards int null,
    PuntReturnTouchdowns int null,
    PuntReturnLong int null,
    foreign key (PlayerId) references Player(PlayerId),
    foreign key (RosterId) references Roster(RosterId),
    constraint PK_ReturnerStats primary key (ReturnerStatsId),
);

