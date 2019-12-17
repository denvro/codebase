-- Get a list of tables and views in the current database
select *
from   RDV.Datum_H dat
order by dat.Datum
;

select count(*)
from   RDV.Datum_H dat
;