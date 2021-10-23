explain 
select item_name, year, price_tax_ex as price
from items
where year <= 2001
UNION ALL
select item_name, year, price_tax_in as price
from items
where year >= 2002
order by item_name, year;

explain select item_name, year,
case when year <= 2001 then price_tax_ex
     when year >= 2002 then price_tax_in
     end as price
from items;
