/*
Question: What are the Top-Paying Supply Chain Data Analyst roles?
-- Identify the top 20 highest-paying analyst roles within the supply chain
   industry, based in the United States.
   NOTE: Analyst here Includes Business Analysts, Data Analysts, and Senior Data Analysts
         but within the supply chain industry
         whose job titles reference core supply chain functions — e.g. logistics,
         last-mile operations, procurement, sourcing, inventory, transportation, supplier/vendor
         management, and demand planning.
-- Scope decisions: excludes adjacent industries/tools KWs (e.g. 
   ERP/SAP/MRP systems, generic "production" or "quality control") to keep
   results function-specific rather than industry-broad.
-- Focuses on job postings with specified salaries (removing nulls).
-- Why? To highlight the top-paying opportunities for analysts who started or are specializing
   in supply chain, and to practice building/refining a keyword-based
   classification filter on messy real-world job title data.
*/
SELECT
job_id,
job_title,
job_title_short,
job_location,
job_country,
job_schedule_type,
salary_year_avg,
company_dim.name AS company_name,
job_posted_date
FROM
job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
job_title_short IN ('Data Analyst', 'Senior Data Analyst', 'Business Analyst')
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
    AND salary_year_avg IS NOT NULL
    AND job_id NOT IN (993436, 815303, 198826)
ORDER BY
salary_year_avg DESC
LIMIT 20;


/*

Key Findings – Query 1 (Top Paying Supply Chain Data Analyst Jobs):

1. Salary range: $112,500 – $175,000 for the top 20 highest-paying roles, with a median around $126,000.

2. Top job is "Senior Logistics Data Analyst" at Falconwood, Incorporated ($175,000) — over $29K higher 
than the #2 spot, a clear outlier at the top.

3. Government/defense logistics pays well: The US Department of Transportation appears 4 times 
(all $126,801.5, Chicago/Philadelphia) and Tecolote Research (Navy logistics) appears twice 
($125,000 and $115,000) — federal and defense-adjacent roles form a notable cluster.

4. Big-name companies value supply chain analytics: TikTok ($145,877.5), Home Depot 
(2 postings, $125K–$130K), and Tesla ($115,000) all appear — showing large corporations pay competitively 
for this niche skill set.

5. Remote work doesn't hurt pay: Ryder System posted the identical "Sr. Data Analyst – Supply Chain (Remote)"
role 3 times across different cities (Tallahassee, DC, Harrisburg), all at $125,000 — proving location-flexible 
roles can match on-site senior pay.

6. "Senior" titles = majority of high earners: 12 of the top 20 roles are "Senior Data Analyst" level, 
reinforcing that seniority is the strongest lever for salary in this space, followed by specialized domain 
knowledge (logistics, transportation, defense).

7. Repeated identical postings (US DOT x4, Ryder x3, Tecolote x2) suggest large-scale hiring pushes by a few employers, rather than one-off openings — useful to note if you're job hunting in this niche.

*/