-- Øàã 0 ñîçäàíèå ÁÄ
use [master];
go

if db_id('Academy') is not null
begin
	drop database [Academy];
end
go

create database [Academy];
go

use [Academy];
go

create table [Assistants]
(
	[Id] int not null identity(1, 1) primary key,
	[TeacherId] int not null
);
go

create table [Curators]
(
	[Id] int not null identity(1, 1) primary key,
	[TeacherId] int not null
);
go

create table [Deans]
(
	[Id] int not null identity(1, 1) primary key,
	[TeacherId] int not null
);
go

create table [Departments]
(
	[Id] int not null identity(1, 1) primary key,
	[Building] int not null check ([Building] between 1 and 5),
	[Name] nvarchar(100) not null unique check ([Name] <> N''),
	[FacultyId] int not null,
	[HeadId] int not null
);
go

create table [Faculties]
(
	[Id] int not null identity(1, 1) primary key,
	[Building] int not null check ([Building] between 1 and 5),
	[Name] nvarchar(100) not null unique check ([Name] <> N''),
	[DeanId] int not null
);
go

create table [Groups]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(10) not null unique check ([Name] <> N''),
	[Year] int not null check ([Year] between 1 and 5),
	[DepartmentId] int not null
);
go

create table [GroupsCurators]
(
	[Id] int not null identity(1, 1) primary key,
	[CuratorId] int not null,
	[GroupId] int not null
);
go

create table [GroupsLectures]
(
	[Id] int not null identity(1, 1) primary key,
	[GroupId] int not null,
	[LectureId] int not null
);
go

create table [Heads]
(
	[Id] int not null identity(1, 1) primary key,
	[TeacherId] int not null
);
go

create table [LectureRooms]
(
	[Id] int not null identity(1, 1) primary key,
	[Building] int not null check ([Building] between 1 and 5),
	[Name] nvarchar(10) not null unique check ([Name] <> N'')
);
go

create table [Lectures]
(
	[Id] int not null identity(1, 1) primary key,
	[SubjectId] int not null,
	[TeacherId] int not null
);
go

create table [Schedules]
(
	[Id] int not null identity(1, 1) primary key,
	[Class] int not null check ([Class] between 1 and 8),
	[DayOfWeek] int not null check ([DayOfWeek] between 1 and 7),
	[Week] int not null check ([Week] between 1 and 52),
	[LectureId] int not null,
	[LectureRoomId] int not null
);
go

create table [Subjects]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check ([Name] <> N'')
);
go

create table [Teachers]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(max) not null check ([Name] <> N''),
	[Surname] nvarchar(max) not null check ([Surname] <> N'')
);
go

alter table [Assistants]
add foreign key ([TeacherId]) references [Teachers]([Id]);
go

alter table [Curators]
add foreign key ([TeacherId]) references [Teachers]([Id]);
go

alter table [Deans]
add foreign key ([TeacherId]) references [Teachers]([Id]);
go

alter table [Departments]
add foreign key ([FacultyId]) references [Faculties]([Id]);
go

alter table [Departments]
add foreign key ([HeadId]) references [Heads]([Id]);
go

alter table [Faculties]
add foreign key ([DeanId]) references [Deans]([Id]);
go

alter table [Groups]
add foreign key ([DepartmentId]) references [Departments]([Id]);
go

alter table [GroupsCurators]
add foreign key ([CuratorId]) references [Curators]([Id]);
go

alter table [GroupsCurators]
add foreign key ([GroupId]) references [Groups]([Id]);
go

alter table [GroupsLectures]
add foreign key ([GroupId]) references [Groups]([Id]);
go

alter table [GroupsLectures]
add foreign key ([LectureId]) references [Lectures]([Id]);
go

alter table [Heads]
add foreign key ([TeacherId]) references [Teachers]([Id]);
go

alter table [Lectures]
add foreign key ([SubjectId]) references [Subjects]([Id]);
go

alter table [Lectures]
add foreign key ([TeacherId]) references [Teachers]([Id]);
go

alter table [Schedules]
add foreign key ([LectureId]) references [Lectures]([Id]);
go

alter table [Schedules]
add foreign key ([LectureRoomId]) references [LectureRooms]([Id]);
go

--Øàã 1 äîáàâëåíèå çíà÷åíèé

-- Äîáàâëåíèå ïðåïîäàâàòåëåé
INSERT INTO Teachers (Name, Surname) VALUES
('Edward', 'Hopper'),
('Alex', 'Carmack'),
('John', 'Doe'),
('Jane', 'Smith'),
('Emma', 'Stone'),
('William', 'Turner'),
('Olivia', 'Brown'),
('Lucas', 'Davis'),
('Mia', 'Wilson'),
('Ethan', 'Miller');

Select * FROM Teachers 

-- Äîáàâëåíèå àññèñòåíòîâ
INSERT INTO Assistants (TeacherId) 
SELECT Id FROM Teachers 
WHERE Surname IN 
('Doe', 
'Smith', 
'Hopper', 
'Carmack', 
'Stone', 
'Turner', 
'Brown', 
'Davis', 
'Wilson', 
'Miller');

Select * FROM Assistants

-- Äîáàâëåíèå êóðàòîðîâ
INSERT INTO Curators (TeacherId) 
SELECT Id FROM Teachers
WHERE Surname IN 
('Smith', 
'Doe', '
Hopper', 
'Carmack', 
'Stone', 
'Turner', 
'Brown', 
'Davis', 
'Wilson', 
'Miller');

Select * FROM Curators

-- Äîáàâëåíèå äåêàíîâ
INSERT INTO Deans (TeacherId) 
SELECT Id FROM Teachers 
WHERE Surname IN 
('Smith', 
'Doe', 
'Hopper', 
'Carmack', 
'Stone', 
'Turner', 
'Brown', 
'Davis', 
'Wilson', 
'Miller');

Select * FROM Deans

-- Äîáàâëåíèå çàâåäóþùèõ
INSERT INTO Heads (TeacherId) 
SELECT Id FROM Teachers 
WHERE Surname IN 
('Smith', 
'Doe', 
'Hopper', 
'Carmack', 
'Stone', 
'Turner', 
'Brown', 
'Davis', 
'Wilson', 
'Miller');


Select * FROM Heads

-- Äîáàâëåíèå ôàêóëüòåòîâ
INSERT INTO Faculties (Building, Name, DeanId) VALUES
(1, 'Arts and Sciences', (SELECT Id FROM Deans WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Hopper'))),
(2, 'Engineering', (SELECT Id FROM Deans WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Carmack'))),
(3, 'Business', (SELECT Id FROM Deans WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Doe'))),
(4, 'Education', (SELECT Id FROM Deans WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Smith'))),
(1, 'Computer Science', (SELECT Id FROM Deans WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Stone'))),
(2, 'Humanities', (SELECT Id FROM Deans WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Turner'))),
(3, 'Law', (SELECT Id FROM Deans WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Brown'))),
(4, 'Medicine', (SELECT Id FROM Deans WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Davis'))),
(1, 'Natural Sciences', (SELECT Id FROM Deans WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Wilson'))),
(2, 'Social Sciences', (SELECT Id FROM Deans WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Miller')));

Select * FROM Faculties

-- Äîáàâëåíèå êàôåäð
INSERT INTO Departments (Building, Name, FacultyId, HeadId) VALUES
(1, 'Software Development', (SELECT Id FROM Faculties WHERE Name = 'Engineering'), (SELECT Id FROM Heads WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Carmack'))),
(1, 'Fine Arts', (SELECT Id FROM Faculties WHERE Name = 'Arts and Sciences'), (SELECT Id FROM Heads WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Hopper'))),
(2, 'Economics', (SELECT Id FROM Faculties WHERE Name = 'Business'), (SELECT Id FROM Heads WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Doe'))),
(2, 'Education Policy', (SELECT Id FROM Faculties WHERE Name = 'Education'), (SELECT Id FROM Heads WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Smith'))),
(3, 'Computer Science', (SELECT Id FROM Faculties WHERE Name = 'Engineering'), (SELECT Id FROM Heads WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Carmack'))),
(3, 'Literature', (SELECT Id FROM Faculties WHERE Name = 'Arts and Sciences'), (SELECT Id FROM Heads WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Hopper'))),
(4, 'Mathematics', (SELECT Id FROM Faculties WHERE Name = 'Arts and Sciences'), (SELECT Id FROM Heads WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Hopper'))),
(4, 'Biology', (SELECT Id FROM Faculties WHERE Name = 'Arts and Sciences'), (SELECT Id FROM Heads WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Hopper'))),
(5, 'Mechanical Engineering', (SELECT Id FROM Faculties WHERE Name = 'Engineering'), (SELECT Id FROM Heads WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Carmack'))),
(5, 'Electrical Engineering', (SELECT Id FROM Faculties WHERE Name = 'Engineering'), (SELECT Id FROM Heads WHERE TeacherId = (SELECT Id FROM Teachers WHERE Surname = 'Carmack')));

Select * FROM Departments


-- Äîáàâëåíèå ãðóïï
INSERT INTO Groups (Name, Year, DepartmentId) VALUES
('F506', 2, (SELECT Id FROM Departments WHERE Name = 'Software Development')),
('A402', 1, (SELECT Id FROM Departments WHERE Name = 'Fine Arts')),
('E303', 2, (SELECT Id FROM Departments WHERE Name = 'Economics')),
('Edu102', 2, (SELECT Id FROM Departments WHERE Name = 'Education Policy')),
('F507', 3, (SELECT Id FROM Departments WHERE Name = 'Software Development')),
('A403', 3, (SELECT Id FROM Departments WHERE Name = 'Fine Arts')),
('E304', 4, (SELECT Id FROM Departments WHERE Name = 'Economics')),
('Edu103', 4, (SELECT Id FROM Departments WHERE Name = 'Education Policy')),
('F508', 1, (SELECT Id FROM Departments WHERE Name = 'Software Development')),
('A404', 1, (SELECT Id FROM Departments WHERE Name = 'Fine Arts'));

Select * FROM Groups

-- Äîáàâëåíèå àóäèòîðèé
INSERT INTO LectureRooms (Building, Name) VALUES
(1, 'A102'),
(2, 'B202'),
(3, 'C302'),
(4, 'D402'),
(5, 'E502'),
(1, 'A103'),
(2, 'B203'),
(3, 'C303'),
(4, 'D403'),
(5, 'E503');

SELECT * FROM LectureRooms;

-- Äîáàâëåíèå äèñöèïëèí
INSERT INTO Subjects (Name) VALUES
('Art History'),
('World Literature'),
('Organic Chemistry'),
('Anatomy'),
('Software Engineering'),
('World History'),
('Physical Education'),
('Music Theory'),
('Psychology'),
('Sociology');

SELECT * FROM Subjects;

-- Äîáàâëåíèå ëåêöèé
INSERT INTO Lectures (SubjectId, TeacherId) VALUES
((SELECT Id FROM Subjects WHERE Name = 'Art History'), (SELECT Id FROM Teachers WHERE Surname = 'Doe')),
((SELECT Id FROM Subjects WHERE Name = 'World Literature'), (SELECT Id FROM Teachers WHERE Surname = 'Smith')),
((SELECT Id FROM Subjects WHERE Name = 'Organic Chemistry'), (SELECT Id FROM Teachers WHERE Surname = 'Hopper')),
((SELECT Id FROM Subjects WHERE Name = 'Anatomy'), (SELECT Id FROM Teachers WHERE Surname = 'Carmack')),
((SELECT Id FROM Subjects WHERE Name = 'Software Engineering'), (SELECT Id FROM Teachers WHERE Surname = 'Stone')),
((SELECT Id FROM Subjects WHERE Name = 'World History'), (SELECT Id FROM Teachers WHERE Surname = 'Turner')),
((SELECT Id FROM Subjects WHERE Name = 'Physical Education'), (SELECT Id FROM Teachers WHERE Surname = 'Brown')),
((SELECT Id FROM Subjects WHERE Name = 'Music Theory'), (SELECT Id FROM Teachers WHERE Surname = 'Davis')),
((SELECT Id FROM Subjects WHERE Name = 'Psychology'), (SELECT Id FROM Teachers WHERE Surname = 'Wilson')),
((SELECT Id FROM Subjects WHERE Name = 'Sociology'), (SELECT Id FROM Teachers WHERE Surname = 'Miller'));

SELECT * FROM Lectures;

-- Äîáàâëåíèå ñâÿçè ìåæäó ãðóïïàìè è ëåêöèÿìè
INSERT INTO GroupsLectures (GroupId, LectureId) VALUES
((SELECT Id FROM Groups WHERE Name = 'F506'), (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'Software Engineering'))),
((SELECT Id FROM Groups WHERE Name = 'A402'), (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'Music Theory'))),
((SELECT Id FROM Groups WHERE Name = 'E303'), (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'Psychology'))),
((SELECT Id FROM Groups WHERE Name = 'Edu102'), (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'Physical Education'))),
((SELECT Id FROM Groups WHERE Name = 'F507'), (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'World History'))),
((SELECT Id FROM Groups WHERE Name = 'A403'), (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'Organic Chemistry'))),
((SELECT Id FROM Groups WHERE Name = 'E304'), (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'World Literature'))),
((SELECT Id FROM Groups WHERE Name = 'Edu103'), (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'Art History'))),
((SELECT Id FROM Groups WHERE Name = 'F508'), (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'Anatomy'))),
((SELECT Id FROM Groups WHERE Name = 'A404'), (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'Organic Chemistry')));

SELECT * FROM GroupsLectures;

-- Äîáàâëåíèå ðàñïèñàíèé
INSERT INTO Schedules (Class, DayOfWeek, Week, LectureId, LectureRoomId) VALUES
(1, 1, 1, (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'Art History')), (SELECT Id FROM LectureRooms WHERE Name = 'A102')),
(2, 2, 2, (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'World Literature')), (SELECT Id FROM LectureRooms WHERE Name = 'B202')),
(3, 3, 3, (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'Organic Chemistry')), (SELECT Id FROM LectureRooms WHERE Name = 'C302')),
(4, 4, 4, (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'Anatomy')), (SELECT Id FROM LectureRooms WHERE Name = 'D402')),
(5, 5, 5, (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'Software Engineering')), (SELECT Id FROM LectureRooms WHERE Name = 'E502')),
(6, 1, 6, (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'World History')), (SELECT Id FROM LectureRooms WHERE Name = 'A103')),
(7, 2, 7, (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'Physical Education')), (SELECT Id FROM LectureRooms WHERE Name = 'B203')),
(8, 3, 8, (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'Music Theory')), (SELECT Id FROM LectureRooms WHERE Name = 'C303')),
(1, 4, 9, (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'Psychology')), (SELECT Id FROM LectureRooms WHERE Name = 'D403')),
(2, 5, 10, (SELECT Id FROM Lectures WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name = 'Sociology')), (SELECT Id FROM LectureRooms WHERE Name = 'E503'));

SELECT * FROM Schedules;

--ØÀÃ 2 Çàïðîñû
--1. Âûâåñòè íàçâàíèÿ àóäèòîðèé, â êîòîðûõ ÷èòàåò ëåêöèè
--ïðåïîäàâàòåëü Edward Hopper.
SELECT lr.Name AS LectureRoomName
FROM Teachers t
	JOIN Lectures l ON t.Id = l.TeacherId
	JOIN Schedules s ON l.Id = s.LectureId
	JOIN LectureRooms lr ON s.LectureRoomId = lr.Id
WHERE t.Name = 'Edward' AND t.Surname = 'Hopper';

--2. Âûâåñòè ôàìèëèè àññèñòåíòîâ, ÷èòàþùèõ ëåêöèè â ãðóïïå
--F505.
SELECT t.Surname AS AssistantSurname
FROM Assistants a
	JOIN Teachers t ON a.TeacherId = t.Id
	JOIN Lectures l ON t.Id = l.TeacherId
	JOIN GroupsLectures gl ON l.Id = gl.LectureId
	JOIN Groups g ON gl.GroupId = g.Id
WHERE g.Name = 'F505';

--3. Âûâåñòè äèñöèïëèíû, êîòîðûå ÷èòàåò ïðåïîäàâàòåëü Alex
--Carmack äëÿ ãðóïï 1-ãî êóðñà.
SELECT s.Name AS SubjectName
FROM Teachers t
	JOIN Lectures l ON t.Id = l.TeacherId
	JOIN Subjects s ON l.SubjectId = s.Id
	JOIN GroupsLectures gl ON l.Id = gl.LectureId
	JOIN Groups g ON gl.GroupId = g.Id
WHERE t.Name = 'Alex' AND t.Surname = 'Carmack' AND g.Year = 1;

--4. Âûâåñòè ôàìèëèè ïðåïîäàâàòåëåé, êîòîðûå íå ÷èòàþò
--ëåêöèè ïî ïîíåäåëüíèêàì.
SELECT DISTINCT t.Surname AS TeacherSurname
FROM Teachers t
WHERE NOT EXISTS (
    SELECT 1
    FROM Lectures l
    JOIN Schedules s ON l.Id = s.LectureId
    WHERE t.Id = l.TeacherId AND s.DayOfWeek = 1
);

--5. Âûâåñòè íàçâàíèÿ àóäèòîðèé, ñ óêàçàíèåì èõ êîðïóñîâ,
--â êîòîðûõ íåò ëåêöèé â ñðåäó âòîðîé íåäåëè íà òðåòüåé
--ïàðå.
SELECT lr.Name AS LectureRoomName, lr.Building AS BuildingNumber
FROM LectureRooms lr
WHERE NOT EXISTS (
    SELECT 1
    FROM Schedules s
    WHERE s.LectureRoomId = lr.Id AND s.DayOfWeek = 3 AND s.Week = 2 AND s.Class = 3
);

--6. Âûâåñòè ïîëíûå èìåíà ïðåïîäàâàòåëåé ôàêóëüòåòà Computer
--Science, êîòîðûå íå êóðèðóþò ãðóïïû êàôåäðû Software
--Development.
SELECT t.Name, t.Surname
FROM Teachers t
	JOIN Departments d ON t.Id = d.HeadId
	JOIN Faculties f ON d.FacultyId = f.Id
WHERE f.Name = 'Computer Science' AND NOT EXISTS (
    SELECT 1
    FROM Groups g
    JOIN GroupsCurators gc ON g.Id = gc.GroupId
    JOIN Curators c ON gc.CuratorId = c.Id
    WHERE c.TeacherId = t.Id AND g.DepartmentId = (SELECT Id FROM Departments WHERE Name = 'Software Development')
);

--7. Âûâåñòè ñïèñîê íîìåðîâ âñåõ êîðïóñîâ, êîòîðûå èìåþòñÿ
--â òàáëèöàõ ôàêóëüòåòîâ, êàôåäð è àóäèòîðèé.
SELECT DISTINCT Building FROM Faculties
UNION
SELECT DISTINCT Building FROM Departments
UNION
SELECT DISTINCT Building FROM LectureRooms;

--8. Âûâåñòè ïîëíûå èìåíà ïðåïîäàâàòåëåé â ñëåäóþùåì ïî-
--ðÿäêå: äåêàíû ôàêóëüòåòîâ, çàâåäóþùèå êàôåäðàìè, ïðå-
--ïîäàâàòåëè, êóðàòîðû, àññèñòåíòû.
(SELECT t.Name, t.Surname, 'Dean' AS Role FROM Teachers t JOIN Deans d ON t.Id = d.TeacherId)
UNION ALL
(SELECT t.Name, t.Surname, 'Head' AS Role FROM Teachers t JOIN Heads h ON t.Id = h.TeacherId)
UNION ALL
(SELECT t.Name, t.Surname, 'Teacher' AS Role FROM Teachers t)
UNION ALL
(SELECT t.Name, t.Surname, 'Curator' AS Role FROM Teachers t JOIN Curators c ON t.Id = c.TeacherId)
UNION ALL
(SELECT t.Name, t.Surname, 'Assistant' AS Role FROM Teachers t JOIN Assistants a ON t.Id = a.TeacherId)
ORDER BY Role;

--9. Âûâåñòè äíè íåäåëè (áåç ïîâòîðåíèé), â êîòîðûå èìåþòñÿ
--çàíÿòèÿ â àóäèòîðèÿõ A311 è A104 êîðïóñà 6.

SELECT DISTINCT s.DayOfWeek
FROM Schedules s
	JOIN LectureRooms lr ON s.LectureRoomId = lr.Id
WHERE lr.Name IN ('A311', 'A104') AND lr.Building = 6;
