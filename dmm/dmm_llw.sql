drop table bitmp.dmm_llw;
create table bitmp.dmm_llw as
(
select
        'Total' as dimension
        , '# of Live Products' as metric
        
        -- What We Brought
        , round((count(product_id)/7)/1000,1.0) as wwb_llw
        , NULL as wwb_llw_share
        
        -- How She Engaged
        , round(sum(site_product_visits)/count(product_id),2.0) as hse_llw
        
        -- What She Looked At
        , round(sum(site_product_visits)/7000,0.0) as wsla_llw
        , NULL as wsla_llw_share
        
        -- How She Converted
        , round(sum(sales_dollars)/sum(site_product_visits),2.0) as hsc_llw
        
        -- What She Bought
        , round(sum(sales_dollars)/7000000,2.0) as wsb_llw
        , NULL as wsb_llw_share       
from
        bitmp.dmm_src 
where 
        retail_year = (select year(current_date)) and retail_week = 16     
group by
        1,2
) union (
select
        'Cat Mix' as dimension
        , owner_dmm as metric
        
        -- What We Brought
        , round((count(owner_dmm)/7)/1000,1.0) as wwb_llw
        , round((count(owner_dmm)/sum(count(*)) over()) * 100,0.0) || '%' as wwb_llw_share
        
        -- How She Engaged
        , round(sum(site_product_visits)/count(owner_dmm),2.0) as hse_llw
        
        -- What She Looked At
        , round(sum(site_product_visits)/7000,0.0) as wsla_llw
        , round((sum(site_product_visits)/sum(sum(site_product_visits)) over()) * 100,0.0) || '%' as wsla_llw_share
        
        -- How She Converted
        , round(sum(sales_dollars)/sum(site_product_visits),2.0) as hsc_llw
        
        -- What She Bought
        , round(sum(sales_dollars)/7000000,2.0) as wsb_llw
        , round((sum(sales_dollars)/sum(sum(sales_dollars)) over()) * 100,0.0) || '%' as wsb_llw_share
        
from
        bitmp.dmm_src 
where 
        retail_year = (select year(current_date)) and retail_week = 16
group by
        1,2
) union (
select
        'Doorway' as dimension
        , event_type as metric
        
        -- What We Brought
        , round((count(event_type)/7)/1000,1.0) as wwb_llw
        , round((count(event_type)/sum(count(*)) over()) * 100,0.0) || '%' as wwb_llw_share
        
        -- How She Engaged
        , round(sum(site_product_visits)/count(event_type),2.0) as hse_llw
       
        -- What She Looked At
        , round(sum(site_product_visits)/7000,0.0) as wsla_llw
        , round((sum(site_product_visits)/sum(sum(site_product_visits)) over()) * 100,0.0) || '%' as wsla_llw_share
        
        -- How She Converted
        , round(sum(sales_dollars)/sum(site_product_visits),2.0) as hsc_llw
       
        -- What She Bought
        , round(sum(sales_dollars)/7000000,2.0) as wsb_llw
        , round((sum(sales_dollars)/sum(sum(sales_dollars)) over()) * 100,0.0) || '%' as wsb_llw_share
        
from
        bitmp.dmm_src 
where 
        retail_year = (select year(current_date)) and retail_week = 16      
group by
        1,2
) union (
select
        'AUR Mix' as dimension
        , aur_tranche as metric
        
        -- What We Brought
        , round((count(aur_tranche)/7)/1000,1.0) as wwb_llw
        , round((count(aur_tranche)/sum(count(*)) over()) * 100,0.0) || '%' as wwb_llw_share
       
        -- How She Engaged
        , round(sum(site_product_visits)/count(aur_tranche),2.0) as hse_llw
        
        -- What She Looked At
        , round(sum(site_product_visits)/7000,0.0) as wsla_llw
        , round((sum(site_product_visits)/sum(sum(site_product_visits)) over()) * 100,0.0) || '%' as wsla_llw_share
        
        -- How She Converted
        , round(sum(sales_dollars)/sum(site_product_visits),2.0) as hsc_llw
        
        -- What She Bought
        , round(sum(sales_dollars)/7000000,2.0) as wsb_llw
        , round((sum(sales_dollars)/sum(sum(sales_dollars)) over()) * 100,0.0) || '%' as wsb_llw_share
        
from
        bitmp.dmm_src 
where 
        retail_year = (select year(current_date)) and retail_week = 16 and aur_tranche notnull        
group by
        1,2
) union (
select
        'Freshness Mix' as dimension
        , freshness_tranche as metric
        
        -- What We Brought
        , round((count(freshness_tranche)/7)/1000,1.0) as wwb_llw
        , round((count(freshness_tranche)/sum(count(*)) over()) * 100,0.0) || '%' as wwb_llw_share
        
        -- How She Engaged
        , round(sum(site_product_visits)/count(freshness_tranche),2.0) as hse_llw
        
        -- What She Looked At
        , round(sum(site_product_visits)/7000,0.0) as wsla_llw
        , round((sum(site_product_visits)/sum(sum(site_product_visits)) over()) * 100,0.0) || '%' as wsla_llw_share
       
        -- How She Converted
        , round(sum(sales_dollars)/sum(site_product_visits),2.0) as hsc_llw
       
        -- What She Bought
        , round(sum(sales_dollars)/7000000,2.0) as wsb_llw
        , round((sum(sales_dollars)/sum(sum(sales_dollars)) over()) * 100,0.0) || '%' as wsb_llw_share
       
from
        bitmp.dmm_src 
where 
        retail_year = (select year(current_date)) and retail_week = 16 and freshness_tranche notnull        
group by
        1,2
) union (
select
        'New' as dimension
        , 'New - Ever' as metric
        
        -- What We Brought
        , round((count(distinct case when product_sequence = 1 and full_dt = sales_event_start_dt then product_id||full_dt||sales_event_id end)/7)/1000,1.0) as wwb_llw
        , round((count(distinct case when product_sequence = 1 and full_dt = sales_event_start_dt then product_id||full_dt||sales_event_id end)/count(distinct case when full_dt = sales_event_start_dt then product_id||full_dt||sales_event_id end)) * 100,0.0) || '%' as wwb_llw_share
        
        -- How She Engaged
        , round(sum(case when product_sequence = 1 then site_product_visits else null end)/count(distinct case when product_sequence = 1 and full_dt = sales_event_start_dt then product_id||full_dt||sales_event_id end),2.0) as hse_llw
       
        -- What She Looked At
        , round(sum(case when product_sequence = 1 then site_product_visits else null end)/7000,0.0) as wsla_llw
        , round((sum(case when product_sequence = 1 then site_product_visits else null end)/sum(site_product_visits)) * 100,0.0) || '%' as wsla_llw_share
       
        -- How She Converted
        , round(sum(case when product_sequence = 1 then sales_dollars else null end)/sum(case when product_sequence = 1 then site_product_visits else null end),2.0) as hsc_llw
       
        -- What She Bought
        , round(sum(case when product_sequence = 1 then sales_dollars else null end)/7000000,2.0) as wsb_llw
        , round((sum(case when product_sequence = 1 then sales_dollars else null end)/sum(sales_dollars)) * 100,0.0) || '%' as wsb_llw_share
        
from
        bitmp.dmm_src 
where 
        retail_year = (select year(current_date)) and retail_week = 16         
group by
        1,2
)
