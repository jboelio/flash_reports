create table bitmp.dmm_src as
select
                  product_sequence
                , owner_dmm
                , product_id
                , sales_event_start_dt 
                , full_dt
                , retail_year
                , retail_quarter
                , retail_week 
                , sales_event_id 
                , site_product_visits 
                , sales_dollars   
                , case 
                     when lower(nexus_event_name) like '%right hero%' or lower(substring(nexus_event_name,1,3)) = 'rh:' or lower(substring(nexus_event_name,1,3)) = 'rh_' or lower(substring(nexus_event_name,1,3)) = 'rh ' or sales_event_type = 'FLASH' then 'Flash'
                     else 'Hidden'
                  end as event_type
                , case 
                     when prep_unit_price <= 50  then '$0-50'
                     when prep_unit_price between 51 and 250 then '$51-250'
                     when prep_unit_price > 250  then '>$250'
                  end as aur_tranche  
                , case 
                     when product_in_last_90d_frequency = 0 then '0x in last 90d'
                     when product_in_last_90d_frequency = 1 then '1x in last 90d'
                     when product_in_last_90d_frequency = 2 then '2x in last 90d'
                     when product_in_last_90d_frequency = 3 then '3x in last 90d'
                     when product_in_last_90d_frequency > 3 then '>3x in last 90d'
                  end as freshness_tranche
from
                analytics.merch_product_daily
where
                line_of_business in ('Branded','Global Sourcing') and owner_dmm in ('Furnishings','Decor','Home Keeping','Lifestyle & Leisure'); 





        