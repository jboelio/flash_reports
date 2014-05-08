drop table bitmp.dmm_lq;
create table bitmp.dmm_lq as
(
select
        'Total' as dimension
        , '# of Live Products' as metric
        
        -- What We Brought
        , round((count(product_id)/91)/1000,1.0) as wwb_lq
        , NULL as wwb_lq_share
        
        -- How She Engaged
        , round(sum(site_product_visits)/count(product_id),2.0) as hse_lq
        
        -- What She Looked At
        , round(sum(site_product_visits)/91000,0.0) as wsla_lq
        , NULL as wsla_lq_share
        
        -- How She Converted
        , round(sum(sales_dollars)/sum(site_product_visits),2.0) as hsc_lq
        
        -- What She Bought
        , round(sum(sales_dollars)/91000000,2.0) as wsb_lq
        , NULL as wsb_lq_share       
from
        bitmp.dmm_src 
where 
        retail_year = (select year(current_date)) and retail_quarter = 1     
group by
        1,2
) union (
select
        'Cat Mix' as dimension
        , owner_dmm as metric
        
        -- What We Brought
        , round((count(owner_dmm)/91)/1000,1.0) as wwb_lq
        , round((count(owner_dmm)/sum(count(*)) over()) * 100,0.0) || '%' as wwb_lq_share
        
        -- How She Engaged
        , round(sum(site_product_visits)/count(owner_dmm),2.0) as hse_lq
        
        -- What She Looked At
        , round(sum(site_product_visits)/91000,0.0) as wsla_lq
        , round((sum(site_product_visits)/sum(sum(site_product_visits)) over()) * 100,0.0) || '%' as wsla_lq_share
        
        -- How She Converted
        , round(sum(sales_dollars)/sum(site_product_visits),2.0) as hsc_lq
        
        -- What She Bought
        , round(sum(sales_dollars)/91000000,2.0) as wsb_lq
        , round((sum(sales_dollars)/sum(sum(sales_dollars)) over()) * 100,0.0) || '%' as wsb_lq_share
        
from
        bitmp.dmm_src 
where 
        retail_year = (select year(current_date)) and retail_quarter = 1
group by
        1,2
) union (
select
        'Doorway' as dimension
        , event_type as metric
        
        -- What We Brought
        , round((count(event_type)/91)/1000,1.0) as wwb_lq
        , round((count(event_type)/sum(count(*)) over()) * 100,0.0) || '%' as wwb_lq_share
        
        -- How She Engaged
        , round(sum(site_product_visits)/count(event_type),2.0) as hse_lq
       
        -- What She Looked At
        , round(sum(site_product_visits)/91000,0.0) as wsla_lq
        , round((sum(site_product_visits)/sum(sum(site_product_visits)) over()) * 100,0.0) || '%' as wsla_lq_share
        
        -- How She Converted
        , round(sum(sales_dollars)/sum(site_product_visits),2.0) as hsc_lq
       
        -- What She Bought
        , round(sum(sales_dollars)/91000000,2.0) as wsb_lq
        , round((sum(sales_dollars)/sum(sum(sales_dollars)) over()) * 100,0.0) || '%' as wsb_lq_share
        
from
        bitmp.dmm_src 
where 
        retail_year = (select year(current_date)) and retail_quarter = 1      
group by
        1,2
) union (
select
        'AUR Mix' as dimension
        , aur_tranche as metric
        
        -- What We Brought
        , round((count(aur_tranche)/91)/1000,1.0) as wwb_lq
        , round((count(aur_tranche)/sum(count(*)) over()) * 100,0.0) || '%' as wwb_lq_share
       
        -- How She Engaged
        , round(sum(site_product_visits)/count(aur_tranche),2.0) as hse_lq
        
        -- What She Looked At
        , round(sum(site_product_visits)/91000,0.0) as wsla_lq
        , round((sum(site_product_visits)/sum(sum(site_product_visits)) over()) * 100,0.0) || '%' as wsla_lq_share
        
        -- How She Converted
        , round(sum(sales_dollars)/sum(site_product_visits),2.0) as hsc_lq
        
        -- What She Bought
        , round(sum(sales_dollars)/91000000,2.0) as wsb_lq
        , round((sum(sales_dollars)/sum(sum(sales_dollars)) over()) * 100,0.0) || '%' as wsb_lq_share
        
from
        bitmp.dmm_src 
where 
        retail_year = (select year(current_date)) and retail_quarter = 1 and aur_tranche notnull        
group by
        1,2
) union (
select
        'Freshness Mix' as dimension
        , freshness_tranche as metric
        
        -- What We Brought
        , round((count(freshness_tranche)/91)/1000,1.0) as wwb_lq
        , round((count(freshness_tranche)/sum(count(*)) over()) * 100,0.0) || '%' as wwb_lq_share
        
        -- How She Engaged
        , round(sum(site_product_visits)/count(freshness_tranche),2.0) as hse_lq
        
        -- What She Looked At
        , round(sum(site_product_visits)/91000,0.0) as wsla_lq
        , round((sum(site_product_visits)/sum(sum(site_product_visits)) over()) * 100,0.0) || '%' as wsla_lq_share
       
        -- How She Converted
        , round(sum(sales_dollars)/sum(site_product_visits),2.0) as hsc_lq
       
        -- What She Bought
        , round(sum(sales_dollars)/91000000,2.0) as wsb_lq
        , round((sum(sales_dollars)/sum(sum(sales_dollars)) over()) * 100,0.0) || '%' as wsb_lq_share
       
from
        bitmp.dmm_src 
where 
        retail_year = (select year(current_date)) and retail_quarter = 1 and freshness_tranche notnull        
group by
        1,2
) union (
select
        'New' as dimension
        , 'New - Ever' as metric
        
        -- What We Brought
        , round((count(distinct case when product_sequence = 1 and full_dt = sales_event_start_dt then product_id||full_dt||sales_event_id end)/91)/1000,1.0) as wwb_lq
        , round((count(distinct case when product_sequence = 1 and full_dt = sales_event_start_dt then product_id||full_dt||sales_event_id end)/count(distinct case when full_dt = sales_event_start_dt then product_id||full_dt||sales_event_id end)) * 100,0.0) || '%' as wwb_lq_share
        
        -- How She Engaged
        , round(sum(case when product_sequence = 1 then site_product_visits else null end)/count(distinct case when product_sequence = 1 and full_dt = sales_event_start_dt then product_id||full_dt||sales_event_id end),2.0) as hse_lq
       
        -- What She Looked At
        , round(sum(case when product_sequence = 1 then site_product_visits else null end)/91000,0.0) as wsla_lq
        , round((sum(case when product_sequence = 1 then site_product_visits else null end)/sum(site_product_visits)) * 100,0.0) || '%' as wsla_lq_share
       
        -- How She Converted
        , round(sum(case when product_sequence = 1 then sales_dollars else null end)/sum(case when product_sequence = 1 then site_product_visits else null end),2.0) as hsc_lq
       
        -- What She Bought
        , round(sum(case when product_sequence = 1 then sales_dollars else null end)/91000000,2.0) as wsb_lq
        , round((sum(case when product_sequence = 1 then sales_dollars else null end)/sum(sales_dollars)) * 100,0.0) || '%' as wsb_lq_share
        
from
        bitmp.dmm_src 
where 
        retail_year = (select year(current_date)) and retail_quarter = 1         
group by
        1,2
)

