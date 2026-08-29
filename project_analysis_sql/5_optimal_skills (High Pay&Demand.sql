/*
Question: What are the most optimal skills to learn (aka it's high in demand and a high-paying skill)?
-- Identify skills in high demand and associated with high average salaries for Analyst roles.
   NOTE: Analyst here Includes Business Analysts, Data Analysts, and Senior Data Analysts
   but within the supply chain industry
   whose job titles reference core supply chain functions — e.g. logistics,
         last-mile operations, procurement, sourcing, inventory, transportation, supplier/vendor
         management, and demand planning.
-- Scope decisions: excludes adjacent industries/tools KWs (e.g. 
   ERP/SAP/MRP systems, generic "production" or "quality control") to keep
   results function-specific rather than industry-broad.
-- Concentrates roles with specified salaries, based in the United States.
-- Why? Target skills that offer job security (high demand) and financial benefits (high salaries),
   offering strategic insights for career development in supply chain data analytics.
*/

WITH skills_demand AS (
    SELECT
        skills_dim.skill_id, 
        skills_dim.skills,
        COUNT (skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        salary_year_avg IS NOT NULL
        AND job_title_short IN ('Data Analyst', 'Senior Data Analyst', 'Business Analyst')
        AND job_country = 'United States'
        AND (job_title ILIKE '%supply chain%'
            OR job_title ILIKE '%logistics%'
            OR job_title ILIKE '%procurement%'
            OR job_title ILIKE '%sourcing%'
            OR job_title ILIKE '%inventory%'
            OR job_title ILIKE '%fulfillment%'
            OR job_title ILIKE '%demand planning%'
            OR job_title ILIKE '%supply%operations%'
            OR job_title ILIKE '%vendor management%'
            OR job_title ILIKE '%materials management%'
            OR job_title ILIKE '%demand%planner%'
            OR job_title ILIKE '%demand forecasting%'
            OR job_title ILIKE '%s&op%'
            OR job_title ILIKE '%capacity planning%'
            OR job_title ILIKE '%replenishment%'
            OR job_title ILIKE '%transportation%'
            OR job_title ILIKE '%freight%'
            OR job_title ILIKE '%shipping%'
            OR job_title ~* '\yimport\y'
            OR job_title ~* '\yexport\y'
            OR job_title ILIKE '%customs%'
            OR job_title ILIKE '%last mile%'
            OR job_title ILIKE '%fleet%'
            OR job_title ILIKE '%production planning%'
            OR job_title ILIKE '%plant operations%'
            OR job_title ILIKE '%lean six sigma%'
            OR job_title ILIKE '%supply chain quality control%'
            OR job_title ILIKE '%purchasing%'
            OR job_title ILIKE '%buyer%'
            OR job_title ILIKE '%category management%'
            OR job_title ILIKE '%strategic sourcing%'
            OR job_title ILIKE '%contract management%'
            OR job_title ILIKE '%supplier%'
            OR job_title ILIKE '%vendor%'
            OR job_title ILIKE '%3pl%'
            OR job_title ILIKE '%third-party logistics%'
            OR job_title ILIKE '%order management%'
            OR job_title ~* '\yport\y')
            AND job_postings_fact.job_id NOT IN (993436, 815303, 198826)
    GROUP BY skills_dim.skill_id
),  avg_salaries AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salaries,
        COUNT(skills_job_dim.job_id) AS job_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        salary_year_avg IS NOT NULL
        AND job_title_short IN ('Data Analyst', 'Senior Data Analyst', 'Business Analyst')
        AND job_country = 'United States'
        AND (job_title ILIKE '%supply chain%'
            OR job_title ILIKE '%logistics%'
            OR job_title ILIKE '%procurement%'
            OR job_title ILIKE '%sourcing%'
            OR job_title ILIKE '%inventory%'
            OR job_title ILIKE '%fulfillment%'
            OR job_title ILIKE '%demand planning%'
            OR job_title ILIKE '%supply%operations%'
            OR job_title ILIKE '%vendor management%'
            OR job_title ILIKE '%materials management%'
            OR job_title ILIKE '%demand%planner%'
            OR job_title ILIKE '%demand forecasting%'
            OR job_title ILIKE '%s&op%'
            OR job_title ILIKE '%capacity planning%'
            OR job_title ILIKE '%replenishment%'
            OR job_title ILIKE '%transportation%'
            OR job_title ILIKE '%freight%'
            OR job_title ILIKE '%shipping%'
            OR job_title ~* '\yimport\y'
            OR job_title ~* '\yexport\y'
            OR job_title ILIKE '%customs%'
            OR job_title ILIKE '%last mile%'
            OR job_title ILIKE '%fleet%'
            OR job_title ILIKE '%production planning%'
            OR job_title ILIKE '%plant operations%'
            OR job_title ILIKE '%lean six sigma%'
            OR job_title ILIKE '%supply chain quality control%'
            OR job_title ILIKE '%purchasing%'
            OR job_title ILIKE '%buyer%'
            OR job_title ILIKE '%category management%'
            OR job_title ILIKE '%strategic sourcing%'
            OR job_title ILIKE '%contract management%'
            OR job_title ILIKE '%supplier%'
            OR job_title ILIKE '%vendor%'
            OR job_title ILIKE '%3pl%'
            OR job_title ILIKE '%third-party logistics%'
            OR job_title ILIKE '%order management%'
            OR job_title ~* '\yport\y')
        AND job_postings_fact.job_id NOT IN (993436, 815303, 198826)
    GROUP BY
        skills_job_dim.skill_id
    HAVING
    COUNT(skills_job_dim.job_id) >= 5 
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salaries.avg_salaries
FROM
    skills_demand
INNER JOIN avg_salaries ON skills_demand.skill_id = avg_salaries.skill_id
ORDER BY
    avg_salaries DESC,
    demand_count DESC
    
/*
Key methodology notes:
-- This query combines demand (skills_demand CTE, LEFT JOIN, no salary threshold on count) with 
   average salary (avg_salaries CTE, INNER JOIN, HAVING COUNT >= 5) to answer a two-part question: 
   which skills are both asked-for often AND paid well.
-- INNER JOINing the two CTEs means only skills that passed the >= 5 posting threshold in 
   avg_salaries survive — so "optimal" here really means "the 15 statistically reliable skills from 
   query 4, now re-sorted to also show demand alongside pay."
-- Data quirk: "sas" appears under two different skill_ids (7 and 186) in skills_dim, both with 
   demand_count=9 and avg_salary=$98,528. This is a source-data duplication, not a real distinct 
   skill — treat it as one skill (sas, combined n=18) when interpreting rank, not two.
*/
/*
Result:
16 rows returned (15 distinct skills, since "sas" is split across two skill_ids as noted above), 
ranked by avg_salaries DESC then demand_count DESC.

Key finding: The most "optimal" skills sit in the middle of the pack, not at either extreme.
-- SQL is the standout optimal skill: high demand (35 postings — the 2nd-highest in the list) 
   AND a strong salary ($97,749, above the group median). Few skills combine both like this.
-- Tableau is the next-best balance: 29 postings (3rd-highest demand) at $98,003 — nearly tied 
   with SQL on pay, with comparable demand.
-- Python (21 postings, $96,268) rounds out the top tier of "genuinely optimal" skills — solid 
   on both axes rather than excelling at just one.
-- Alteryx, VBA, and SQL Server sit at the top of the salary list ($108K–$111K) but rank near the 
   bottom on demand (6–9 postings) — high reward, but a narrower slice of the market wants them, 
   so they're a smaller bet.
-- Excel and Power BI sit at the opposite extreme: Excel is the single most in-demand skill (59 
   postings) but the second-lowest paid ($82,758); Power BI similarly trades high demand (17) for 
   middling pay ($85,040). Both read as "expected baseline," not a differentiator.
-- SAP is the clear outlier to avoid over-indexing on: lowest pay ($65,929) and modest demand 
   (7 postings) — weak on both axes.
*/
/*
Caveat to carry:
-- "Optimal" is a judgment call, not a formula in this query — the SQL only sorts by salary, then 
   demand. Actually identifying the best trade-off (e.g., SQL/Tableau/Python) requires eyeballing 
   both columns together rather than trusting the ORDER BY alone.
-- Same small-sample caveat as query 4 applies: skills with n=6–9 (Alteryx, SQL Server, VBA, SAS, 
   SPSS) carry more uncertainty in their salary averages than the higher-volume skills (Excel n=59, 
   SQL n=35, Tableau n=29).
*/




    