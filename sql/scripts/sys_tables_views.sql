select  sma.name            as schema_name
,       tbl.name            as object_name
,       'table'             as object_category
from    sys.tables          tbl
join    sys.schemas         sma     on sma.schema_id            = tbl.schema_id
union all
select  sma.name            as schema_name
,       viw.name            as object_name
,       'view'              as object_category
from    sys.views           viw
join    sys.schemas         sma     on sma.schema_id            = viw.schema_id
order by schema_name
,        object_name
;
-- dit is comment

