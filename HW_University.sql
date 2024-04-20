USE University

--1. Вывести все возможные пары строк преподавателей и групп.
select G.Name, T.Name
from GroupsLectures GL, Groups G, Lectures L, Teachers T
where GL.GroupID = G.Id and GL.LectureID = L.Id and L.TeacherID = T.Id

--2. Вывести названия факультетов, фонд финансирования кафедр которых превышает фонд финансирования факультета.
SELECT F.Name AS FacultyName, D.Name AS DepartmentName, D.Financing AS DepartmentFinancing
FROM Faculties F
	JOIN Departments D ON F.Id = D.FacultyID
WHERE D.Financing > F.Financing;

--3. Вывести фамилии кураторов групп и названия групп, которые они курируют.
SELECT Curators.Surname AS CuratorSurname, Groups.Name AS GroupName
FROM Curators
	JOIN GroupsCurators ON Curators.Id = GroupsCurators.CuratorID
	JOIN Groups ON GroupsCurators.GroupID = Groups.Id;

--4. Вывести имена и фамилии преподавателей, которые читают лекции у группы “EE301”.
SELECT Teachers.Name AS TeacherName, Teachers.Surname AS TeacherSurname
FROM Teachers
	JOIN Lectures ON Teachers.Id = Lectures.TeacherID
	JOIN GroupsLectures ON Lectures.Id = GroupsLectures.LectureID
	JOIN Groups ON GroupsLectures.GroupID = Groups.Id
WHERE Groups.Name = 'EE301';

--5. Вывести фамилии преподавателей и названия факультетов на которых они читают лекции.
SELECT Teachers.Surname AS TeacherSurname, Faculties.Name AS FacultyName
FROM Teachers
	JOIN Lectures ON Teachers.Id = Lectures.TeacherID
	JOIN Subjects ON Lectures.SubjectID = Subjects.Id
	JOIN Departments ON Subjects.Id = Departments.Id
	JOIN Faculties ON Departments.FacultyID = Faculties.Id;

--6. Вывести названия кафедр и названия групп, которые к ним относятся.
SELECT Departments.Name AS DepartmentName, Groups.Name AS GroupName
FROM Departments
	JOIN Groups ON Departments.Id = Groups.DepartmentID;

--7. Вывести названия дисциплин, которые читает преподаватель “Smith John”.
SELECT Subjects.Name AS SubjectName
FROM Teachers
	JOIN Lectures ON Teachers.Id = Lectures.TeacherID
	JOIN Subjects ON Lectures.SubjectID = Subjects.Id
WHERE Teachers.Surname = 'Smith' AND Teachers.Name = 'John';

--8. Вывести названия кафедр, на которых читается дисциплина “Mechanics”.
SELECT Departments.Name AS DepartmentName
FROM Subjects
	JOIN Departments ON Subjects.Id = Departments.Id
WHERE Subjects.Name = 'Mechanics';

--9. Вывести названия групп, которые относятся к факультету “Computer Science”.
SELECT Groups.Name AS GroupName
FROM Groups
	JOIN Departments ON Groups.DepartmentID = Departments.Id
	JOIN Faculties ON Departments.FacultyID = Faculties.Id
WHERE Faculties.Name = 'Faculty of Engineering' AND Departments.Name = 'Mechanical Engineering';

--10. Вывести названия групп 5-го курса, а также название факультетов, к которым они относятся.
SELECT Groups.Name AS GroupName, Faculties.Name AS FacultyName
FROM Groups
	JOIN Departments ON Groups.DepartmentID = Departments.Id
	JOIN Faculties ON Departments.FacultyID = Faculties.Id
WHERE Groups.Year = 2024;

--11. Вывести полные имена преподавателей и лекции, которые они читают (названия дисциплин и групп), причем отобрать только те лекции, которые читаются в аудитории 
SELECT Teachers.Name AS TeacherName, Teachers.Surname AS TeacherSurname, Subjects.Name AS SubjectName, Groups.Name AS GroupName
FROM Teachers
	JOIN Lectures ON Teachers.Id = Lectures.TeacherID
	JOIN Subjects ON Lectures.SubjectID = Subjects.Id
	JOIN GroupsLectures ON Lectures.Id = GroupsLectures.LectureID
	JOIN Groups ON GroupsLectures.GroupID = Groups.Id
WHERE Groups.Name = 'CS101';