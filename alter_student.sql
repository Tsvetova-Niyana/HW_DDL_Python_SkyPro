-- 1. Создать таблицу student с полями student_id serial, first_name varchar, last_name varchar, birthday date, phone varchar
create table student(
	student_id serial primary key, 
	first_name varchar(20) not null, 
	last_name varchar(20) not null, 
	birthday date, 
	phone varchar(20)
);

-- 2. Добавить в таблицу student колонку middle_name varchar
alter table student 
add column middle_name varchar(20);

-- Проверка добавления столбца middle_name
select * from student s;


-- 3. Удалить колонку middle_name
alter table student 
drop column middle_name;

-- Проверка удаления столбца middle_name
select * from student s;


-- 4. Переименовать колонку birthday в birth_date
alter table student 
rename column birthday to birth_date; 

-- Проверка переименования столбца birthday в birth_date
select * from student s;


-- 5. Изменить тип данных колонки phone на varchar(32)
alter table student 
alter column phone type varchar(32);

-- Проверка изменения типа столбца phone
select c.column_name, data_type, c.character_maximum_length
from information_schema."columns" c 
where table_name = 'student';


-- 6. Вставить три любых записи с автогенерацией идентификатора
insert into student (first_name, last_name, birth_date, phone)
values 
('Марк', 'Кузнецов','12.07.2000' ,'+7 965 751 3663'),
('Вероника','Дмитриева', '10.05.2000', '+7 967 070 3834'),
('Даниэль','Ежов', '18.09.1999' , '+7 905 859 6679');

-- Проверка после добавления данных
select * from student s;

-- 7. Удалить все данные из таблицы со сбросом идентификатор в исходное состояние
truncate student restart identity;

-- Проверка после удаления (таблица пустая)
select * from student s;

-- Заполнение данных после удаления
insert into student (first_name, last_name, birth_date, phone)
values 
('Марк', 'Кузнецов','12.07.2000' ,'+7 965 751 3663'),
('Вероника','Дмитриева', '10.05.2000', '+7 967 070 3834'),
('Даниэль','Ежов', '18.09.1999' , '+7 905 859 6679');

-- Проверка таблицы после добавления данных (идентификатор записей начинается с 1)
select * from student s;
