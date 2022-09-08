create table Country (Id int primary key identity,
CountryName nvarchar(70) not null, 
Code nvarchar(50))

create table City (Id int primary key identity,
CityName nvarchar(70) not null, 
CountryId int not null foreign key references Country(Id),
Code nvarchar(50))

create table District (Id int primary key identity,
DistrictName nvarchar(70) not null, 
CountryId int not null foreign key references Country(Id),
CityId int not null foreign key references City(Id),
Code nvarchar(50))

create table Town (Id int primary key identity,
TownName nvarchar(70) not null, 
CountryId int not null foreign key references Country(Id),
CityId int not null foreign key references City(Id),
DistrictId int not null foreign key references District(Id),
Code nvarchar(50))


