-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
alter table products
add check(unit_price > 0);

-- Проверка невозможности добавления записи с unit_price = 0
INSERT INTO public.products (product_id,
product_name, 
supplier_id, 
category_id, 
quantity_per_unit, 
unit_price, 
units_in_stock, 
units_on_order, 
reorder_level, 
discontinued) 
VALUES(78, 'Tofu', 6, 7, '40 - 100 g pkgs.', 0, 35, 0, 0, 0);

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
alter table products
add check(discontinued = 0 or discontinued = 1);

-- Проверка невозможности добавления записи с discontinued <> 0 или discontinued <> 1
INSERT INTO public.products (product_id,
product_name, 
supplier_id, 
category_id, 
quantity_per_unit, 
unit_price, 
units_in_stock, 
units_on_order, 
reorder_level, 
discontinued) 
VALUES(78, 'Tofu', 6, 7, '40 - 100 g pkgs.', 25, 35, 0, 0, 10);

-- Проверка возможности добавления записи с discontinued = 1
INSERT INTO public.products (product_id,
product_name, 
supplier_id, 
category_id, 
quantity_per_unit, 
unit_price, 
units_in_stock, 
units_on_order, 
reorder_level, 
discontinued) 
VALUES(78, 'Tofu', 6, 7, '40 - 100 g pkgs.', 25, 35, 0, 0, 1);

-- Проверка возможности добавления записи с discontinued = 0
INSERT INTO public.products (product_id,
product_name, 
supplier_id, 
category_id, 
quantity_per_unit, 
unit_price, 
units_in_stock, 
units_on_order, 
reorder_level, 
discontinued) 
VALUES(79, 'Tofu', 6, 7, '40 - 100 g pkgs.', 25, 35, 0, 0, 0);

-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
select * into products_discontinued from products p where p.discontinued = 1;

select * from products_discontinued pd;

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key. Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.

-- Изменение внешнего ключа на каскадное удаление
alter table order_details drop constraint fk_order_details_products;

alter table order_details 
add constraint fk_order_details_products 
foreign key (product_id) references products(product_id) on delete cascade;

-- Удаление данных из таблицы products, где discontinued = 1
delete from products where discontinued = 1;

--Проверка таблицы products
select * from products p order by p.discontinued;

--Проверка таблицы order_details
select * from order_details od;
