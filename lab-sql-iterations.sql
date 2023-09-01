-- 1.
select sum(amount) from payment p
left join staff s on s.staff_id = p.staff_id
group by store_id;


-- 2.
DELIMITER //
CREATE PROCEDURE TotalByStore()
BEGIN
    select sum(amount) from payment p
	left join staff s on s.staff_id = p.staff_id
	group by store_id;
END //
DELIMITER ;

CALL TotalByStore;


-- 3.
DELIMITER //
CREATE PROCEDURE TotalFromStore(IN store_number int)
BEGIN
    select sum(amount) from payment p
	left join staff s on s.staff_id = p.staff_id
    group by store_id
    having store_id = store_number;
END //
DELIMITER ;

CALL TotalFromStore(1);
CALL TotalFromStore(2);


-- 4.
drop procedure if exists TotalFromStore;
DELIMITER //
CREATE PROCEDURE TotalFromStore(IN store_number int, OUT total_sales_value float)
BEGIN
    select sum(amount) from payment p
	left join staff s on s.staff_id = p.staff_id
    group by store_id
    having store_id = store_number
    into total_sales_value;
END //
DELIMITER ;

CALL TotalFromStore(2, @total_sales_value);
select @total_sales_value;


-- 5.
drop procedure if exists TotalFromStore;
DELIMITER //
CREATE PROCEDURE TotalFromStore(IN store_number int, OUT total_sales_value float, OUT flag varchar(25))
BEGIN
    select sum(amount) from payment p
	left join staff s on s.staff_id = p.staff_id
    group by store_id
    having store_id = store_number
    into total_sales_value;
    
    if total_sales_value > 30000 then
		set flag = 'green_flag';
    else
		set flag = 'red_flag';
	end if;
END //
DELIMITER ;

CALL TotalFromStore(1, @total_sales_value, @flag);
select @total_sales_value, @flag;