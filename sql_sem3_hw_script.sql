# SQL. Семинар 3. Домашняя работа
USE lesson_3;

-- ЧАСТЬ 1
-- Создание таблиц
-- Создание таблицы SALESPEOPLE
CREATE TABLE salespeople(
	snum INT PRIMARY KEY,
    sname VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    comm DECIMAL(3, 2)
);
INSERT INTO salespeople(snum, sname, city, comm)
VALUES
(1001, 'Peel', 'London', '.12'),
(1002, 'Serres', 'San Jose', '.13'),
(1004, 'Motika', 'London', '.11'),
(1007, 'Rifkin', 'Barcelona', '.15'),
(1003, 'Axelrod', 'New York', '.10');
SELECT * FROM salespeople;

-- Создание таблицы CUSTOMERS
CREATE TABLE customers(
	cnum INT PRIMARY KEY,
    cname VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    rating INT,
    snum INT
);
INSERT INTO customers(cnum, cname, city, rating, snum)
VALUES
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanni', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 200, 1002),
(2004, 'Grass', 'Berlin', 300, 1002),
(2006, 'Clemens', 'London', 100, 1001),
(2008, 'Cisneros', 'San Jose', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004);
SELECT * FROM customers;

-- Создание таблицы ORDERS
CREATE TABLE orders(
	onum INT PRIMARY KEY,
    amt DECIMAL(10, 2),
    odate DATE,
    cnum INT,
    snum INT
);
INSERT INTO orders(onum, amt, odate, cnum, snum)
VALUES
(3001, '18.69', '1990-01-10', 2008, 1007),
(3003, '767.19', '1990-03-10', 2001, 1001),
(3002, '1900.10', '1990-03-10', 2007, 1004),
(3005, '5160.45', '1990-03-10', 2003, 1002),
(3006, '1098.16', '1990-03-10', 2008, 1007),
(3009, '1713.23', '1990-04-10', 2002, 1003),
(3007, '75.75', '1990-04-10', 2004, 1002),
(3008, '4723.00', '1990-05-10', 2006, 1001),
(3010, '1309.95', '1990-06-10', 2004, 1002),
(3011, '9891.88', '1990-06-10', 2006, 1001);
SELECT * FROM orders;

-- Задачи
/*
1.1 Напишите запрос, который вывел бы таблицу со столбцами в следующем порядке: 
city, sname, snum, comm. (к первой или второй таблице, используя SELECT)
*/
SELECT city, sname, snum, comm
FROM salespeople;

/*
1.2 Напишите команду SELECT, которая вывела бы оценку(rating), 
сопровождаемую именем каждого заказчика в городе San Jose. (“заказчики”)
*/
SELECT cname, rating
FROM customers
WHERE city = 'San Jose';

/*
1.3 Напишите запрос, который вывел бы значения snum всех продавцов из таблицы заказов
без каких бы то ни было повторений. (уникальные значения в  “snum“ “Продавцы”)
*/
SELECT DISTINCT snum AS "Продавцы"
FROM orders
ORDER BY snum;

/*
1.4* Напишите запрос, который бы выбирал заказчиков, чьи имена начинаются с буквы G. 
Используется оператор "LIKE": (“заказчики”)
*/
SELECT cname
FROM customers
WHERE cname LIKE 'G%'
ORDER BY cname;

/*
1.5 Напишите запрос, который может дать вам все заказы со значениями суммы выше чем $1,000. 
(“Заказы”, “amt”  - сумма)
*/
SELECT onum, amt
FROM orders
WHERE amt > 1000
ORDER BY onum;

/*
1.6 Напишите запрос который выбрал бы наименьшую сумму заказа.
(Из поля “amt” - сумма в таблице “Заказы” выбрать наименьшее значение)
*/
SELECT MIN(amt) AS 'MIN_order'
FROM orders;

/*
1.7 Напишите запрос к таблице “Заказчики”, который может показать всех заказчиков,
у которых рейтинг больше 100 и они находятся не в Риме.
*/
SELECT cname, city, rating 
FROM customers
WHERE rating > 100 AND NOT city = 'Rome'
ORDER BY cname;

-- ЧАСТЬ 2
-- Таблица для работы (из классной работы)
SELECT * FROM staff;

-- Задачи
/*
2.1 Отсортируйте поле “зарплата” в порядке убывания и возрастания
*/
-- ASC сортировка (по возрастанию)
SELECT * FROM staff
ORDER BY salary;	
-- DESC сортировка (по убыванию)
SELECT * FROM staff
ORDER BY salary DESC;	

/*
2.2** Отсортируйте по возрастанию поле “Зарплата” и выведите 5 строк с наибольшей заработной платой
(возможен подзапрос)
*/
SELECT *
FROM (SELECT * FROM staff ORDER BY salary DESC LIMIT 5) AS quary
ORDER BY salary;

/*
2.3 Выполните группировку всех сотрудников по специальности, 
суммарная зарплата которых превышает 100000
*/
SELECT post, SUM(salary) as sum_salary
FROM staff
GROUP BY post
HAVING sum_salary > 100000;
