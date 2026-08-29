/*
Question: What are the top skills based on salary?
-- Look at the average salary associated with each skill for analyst roles 
   within the supply chain industry, based in the United States.
   NOTE: Analyst here Includes Business Analysts, Data Analysts, and Senior Data Analysts
         but within the supply chain industry
         whose job titles reference core supply chain functions — e.g. logistics,
         last-mile operations, procurement, sourcing, inventory, transportation, supplier/vendor
         management, and demand planning.
-- Scope decisions: excludes adjacent industries/tools KWs (e.g. 
   ERP/SAP/MRP systems, generic "production" or "quality control") to keep
   results function-specific rather than industry-broad.
-- Focuses on roles with specified salaries, based in the United States.    
-- Why? It reveals how different skills impact salary levels for supply chain data Analysts and helps 
   identify the most financially rewarding skills to acquire or improve.
*/

SELECT 
    skills,
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
    skills
HAVING
COUNT(skills_job_dim.job_id) >= 5
ORDER BY
    avg_salaries DESC
LIMIT 25;



/*
Key methodology notes:
-- Includes HAVING COUNT(skills_job_dim.job_id) >= 5 — this is the most important design decision in this
   query. Without it, skills mentioned in only 1–2 postings (e.g., PowerShell, Linux, ASP.NET) floated 
   to the top purely from small-sample noise, not genuine market signal. The threshold of 5 keeps only
   skills with enough postings behind them to trust the average.
-- Uses INNER JOIN (not LEFT JOIN) on skills_job_dim / skills_dim — postings with no tagged skills are 
   irrelevant to a per-skill salary average and are correctly excluded.
-- Filters salary_year_avg IS NOT NULL, since salary is the metric being averaged.
*/
/*
Result: 
15 skills passed the HAVING threshold, ranging from Alteryx ($111,039, n=6) down to SAP 
($65,929, n=7).
Key finding: Demand and pay don't move together.
-- Excel is the most in-demand skill overall (59 postings) but sits near the bottom of the 
   pay range ($82,758) — a baseline expectation, not a differentiator.
-- Alteryx, VBA, SQL Server, and R — all more specialized data manipulation/automation/stats 
   tools — command a clear pay premium despite far lower posting counts.
-- SAP, despite being supply-chain-specific ERP software, is actually the lowest-paying skill in the 
   qualifying list — suggesting it's table-stakes for the domain rather than a differentiator.
*/
/*
Caveat to carry: 
-- even n=5–7 (Alteryx, SAP, SQL Server) is a thin sample. Findings at the top and bottom
   of the 15-skill list carry more uncertainty than the middle (SQL n=35, Excel n=59, Tableau n=29), 
   which are statistically the most reliable data points in the set.

Lessons Learned 
-- Averages need sample-size context. A HAVING COUNT(...) >= N filter is essential whenever reporting an 
   average grouped by a category — otherwise rare categories with tiny samples can dominate a 
   "top" ranking purely from noise.
*/ 