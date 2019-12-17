-- select  object_id
-- ,       parent_object_id
-- ,       name                fk_name
-- from    sys.foreign_keys
-- ;

-- with    CurrFKS
-- as      (
--         select  object_name(constid)                        as constraintname,
--                 object_schema_name(rkeyid)                  as refschema,
--                 object_name(rkeyid)                         as reftable,
--                 col_name(rkeyid, rkey)                      as refcolumn,
--                 object_schema_name(rkeyid)                  as fkschema,
--                 object_name(fkeyid)                         as fktable,
--                 col_name(fkeyid, fkey)                      as fkcolumn,
--                 ' ALTER TABLE ' 
--                     + Object_name(fkeyid)   
--                     + ' ADD CONSTRAINT [PLACEHOLDER]'   
--                     + ' FOREIGN KEY ('  
--                     + COL_NAME(fkeyid, fkey)    
--                     + ') REFERENCES '   
--                     + Object_name(rkeyid) + '(' 
--                     + COL_NAME(rkeyid, rkey) + ')'          as fksql
--          FROM   sysforeignkeys  
--          )  
-- ,       MyCTE   
-- as      (   
--         select  object_schema_name(colz.object_id)          as FKSchemaName
--         ,       object_name(colz.object_id)                 as FKTableName
--         ,       colz.NAME                                   as FKColumnName
--         ,       colz.column_id                              as FKcolumn_id
--         ,       CurrentReferenceCandidates.*    
--         from    sys.columns                                 colz
--         join    (
--                 select  idxz.object_id
--                 ,       object_schema_name(idxz.object_id)  as PKSchemaName
--                 ,       object_name(idxz.object_id)         as PKTableName
--                 ,       pcolz.name                          as PKColumnName
--                 ,       pcolz.column_id                     as PKColumnID
--                 ,       idxz.is_primary_key
--                 ,       idxz.is_unique
--                 from sys.indexes                            idxz
--                 join sys.index_columns                      icolz   on  idxz.object_id      = icolz.object_id
--                 join sys.columns                            pcolz   on  icolz.object_id     = pcolz.object_id
--                                                                     and icolz.column_id     = pcolz.column_id
--                 where ( idxz.is_primary_key                 = 1 
--                       or idxz.is_unique                     = 1
--                       )
--                 -- and pcolz.name                            like '%HashKey%'
--                 and   object_schema_name(idxz.object_id) <> 'sys'
--                 )                                           CurrentReferenceCandidates  on colz.NAME = CurrentReferenceCandidates.PKColumnName
--                                                                                     --  on colz.name like '%' + CurrentReferenceCandidates.PKColumnName + '%'
--                                                                                        and colz.object_id != CurrentReferenceCandidates.object_id
--         where   object_schema_name(colz.object_id)         != 'sys'
--         and     colz.object_id                             != CurrentReferenceCandidates.object_id
--         and     object_schema_name(colz.object_id)          = pkschemaname
--         and     colz.name                                   = CurrentReferenceCandidates.PKColumnName --toggle below for second version
--         --AND colz.name like '%' + CurrentReferenceCandidates.PKColumnName + '%'
--         ) 
-- select ' ALTER TABLE ' + FKSchemaName + '.'
--        + FKTableName + ' ADD CONSTRAINT [PLACEHOLDER]'
--       -- + FKTableName + '_' + FKColumnName + ']'
--        + ' FOREIGN KEY (' + FKColumnName
--        + ') REFERENCES ' + pkschemaname + '.'
--        + PKTableName + '(' + PKColumnName + ')' AS fksql
-- from   MYCTE
-- where  FKTableName not in (
--                           select name
--                           from   sys.views
--                           )
-- except
-- select FKSQL
-- from   CurrFKS
;

with    cte_fks
as      (
        select  sma.schema_id
        ,       sma.name                schemaname
        ,       tab.object_id
        ,       tab.name                tablename
        ,       col.column_id           
        ,       col.name                columnname
        ,       substring(col.name
                         ,1
                         ,charindex('Hash'
                                   ,col.name)-1
                         ) + 'HashKey'     fk_columnname
        from    sys.all_columns         col
        join    sys.tables              tab  on  tab.object_id      = col.object_id
        join    sys.schemas             sma  on  sma.schema_id      = tab.schema_id
        where   sma.name                in ( 'STG'
                                           , 'RDV'
                                           , 'BDV'
                                           , 'THT'
                                           )
        and     col.name                like '%Hash%'
        and     col.name               != 'HashDiff'                                           
        -- order by sma.schema_id
        -- ,       tab.object_id
        -- ,       col.column_id
        )
,       cte_pks
as      (
        select  sma.schema_id
        ,       sma.name                schemaname
        ,       tab.object_id
        ,       tab.name                tablename
        ,       col.column_id           
        ,       col.name                columnname
        from    sys.all_columns         col
        join    sys.tables              tab  on  tab.object_id      = col.object_id
        join    sys.schemas             sma  on  sma.schema_id      = tab.schema_id
        where   sma.name                in ( 'STG'
                                           , 'RDV'
                                           , 'BDV'
                                           , 'THT'
                                           )
        and     (tab.name               like '%_BH'
                or tab.name             like '%_H'
                )
        )        
select  fks.tablename                   fk_tablename
,       fks.columnname
,       pks.tablename                   pk_tablename
,       pks.columnname                  pk_columnname
from    cte_fks                         fks
join    cte_pks                         pks on   pks.columnname     = fks.fk_columnname
                                            and  pks.schema_id      = fks.schema_id
                                            and  pks.object_id     != fks.object_id
except

;


select   object_name(object_id)                 fk_tablename
,        object_name(referenced_object_id)      ref_table_name
,        fks.*
from     sys.foreign_keys                       fks
;

select  object_name(constid)                        as constraintname,
        object_schema_name(rkeyid)                  as refschema,
        object_name(rkeyid)                         as reftable,
        col_name(rkeyid, rkey)                      as refcolumn,
        object_schema_name(rkeyid)                  as fkschema,
        object_name(fkeyid)                         as fktable,
        col_name(fkeyid, fkey)                      as fkcolumn,
        ' ALTER TABLE ' 
            + Object_name(fkeyid)   
            + ' ADD CONSTRAINT [PLACEHOLDER]'   
            + ' FOREIGN KEY ('  
            + COL_NAME(fkeyid, fkey)    
            + ') REFERENCES '   
            + Object_name(rkeyid) + '(' 
            + COL_NAME(rkeyid, rkey) + ')'          as fksql
from   sysforeignkeys  