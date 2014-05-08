select 
        lw.dimension
        , lw.metric

        -- What We Brought
        , lw.wwb_lw as 'What We Brought -- LW (K)'
        , lw.wwb_lw_share as 'What We Brought -- % Tot'
        , round((lw.wwb_lw/llw.wwb_llw - 1)*100,0.0)||'%' as 'What We Brought -- vLLW'
        , round((lw.wwb_lw/lq.wwb_lq - 1)*100,0.0)||'%' as 'What We Brought -- vQ1'
        , round((lw.wwb_lw/ly.wwb_ly - 1)*100,0.0)||'%' as 'What We Brought -- vLY'
        
        -- How She Engaged
        , lw.hse_lw as 'How She Engaged -- LW'
        , round((lw.hse_lw/llw.hse_llw - 1)*100,0.0)||'%' as 'How She Engaged -- vLLW'
        , round((lw.hse_lw/lq.hse_lq - 1)*100,0.0)||'%' as 'How She Engaged -- vQ1'
        
        -- What She Looked At
        , lw.wsla_lw as 'What She Looked At -- LW (K)'
        , lw.wsla_lw_share as 'What She Looked At -- % Tot'
        , round((lw.wsla_lw/llw.wsla_llw - 1)*100,0.0)||'%' as 'What She Looked At -- vLLW'
        , round((lw.wsla_lw/lq.wsla_lq - 1)*100,0.0)||'%' as 'What She Looked At -- vQ1'
        
        -- How She Converted
        , lw.hsc_lw as 'How She Converted -- LW'
        , round((lw.hsc_lw/llw.hsc_llw - 1)*100,0.0)||'%' as 'How She Converted -- vLLW'
        , round((lw.hsc_lw/lq.hsc_lq - 1)*100,0.0)||'%' as 'How She Converted -- vQ1'
        
        -- What She Bought
        , lw.wsb_lw as 'What She Bought -- LW ($M)'
        , lw.wsb_lw_share as 'What She Bought -- % Tot'
        , round((lw.wsb_lw/llw.wsb_llw - 1)*100,0.0)||'%' as 'What She Bought -- vLLW'
        , round((lw.wsb_lw/lq.wsb_lq - 1)*100,0.0)||'%' as 'What She Bought -- vQ1'
        , round((lw.wsb_lw/ly.wsb_ly - 1)*100,0.0)||'%' as 'What She Bought -- vLY'
 

from
        bitmp.dmm_lw lw 
        inner join bitmp.dmm_llw llw on (lw.dimension=llw.dimension and lw.metric=llw.metric)
        inner join bitmp.dmm_lq lq on (lw.dimension=lq.dimension and lw.metric=lq.metric)
        inner join bitmp.dmm_ly ly on (lw.dimension=ly.dimension and lw.metric=ly.metric)

order by dimension