--###########################################
--## script to determine statistics
--###########################################

select   sch.name        as schema_name
,        tab.name        as table_name
,        sts.name        as stat_name
,        STATS_DATE(tab.object_id, sts.stats_id) as stat_last_updated  
,        'DBCC SHOW_STATISTICS (''' + sch.name +'.' + tab.name + ''',''' + sts.name + ''')' as cmd_detailed_stats
from     sys.tables      tab
join     sys.schemas     sch on sch.schema_id = tab.schema_id
join     sys.stats       sts on sts.object_id = tab.object_id
where    sch.name        = 'BDV'
;

--DBCC SHOW_STATISTICS ('BDV.Treinnummer_Treinserie_BBR','PK_Treinnummer_Treinserie_BBR')