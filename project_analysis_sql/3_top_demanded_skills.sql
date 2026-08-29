/*
Question: What are the most in-demand skills for supply chain data analysts?
   NOTE: Analyst here Includes Business Analysts, Data Analysts, and Senior Data Analysts
         but within the supply chain industry
         whose job titles reference core supply chain functions — e.g. logistics,
         last-mile operations, procurement, sourcing, inventory, transportation, supplier/vendor
         management, and demand planning.
-- Scope decisions: excludes adjacent industries/tools KWs (e.g. 
   ERP/SAP/MRP systems, generic "production" or "quality control") to keep
   results function-specific rather than industry-broad.
-- Identify the top 10 in-demand skills. Why? Retrieves the top 10 skills with the
   highest demand in the job market, providing insights into the most valuable skills
   for the job seekers.
*/

SELECT 
    skills,
    COUNT (skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short IN ('Data Analyst', 'Senior Data Analyst', 'Business Analyst')
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
GROUP BY skills_dim.skills
ORDER BY demand_count DESC
LIMIT 10;

/*

Key findings – In-Demand Skills for Supply Chain Data Analysts (Query 3)

1. Excel is the single most in-demand skill by a wide margin — 769 mentions, 57% more than SQL (490), the 
#2 skill. This confirms spreadsheet fluency remains the top expectation in supply chain analytics roles.
2. SQL is the clear #2 and the top technical/database skill (490 mentions) — roughly 1.6x more in-demand 
than Tableau (345), showing querying ability is valued well above any single visualization tool.
3. Visualization tools split demand: Tableau leads Power BI by a solid margin — 345 vs. 280 mentions, 
meaning Tableau is requested about 23% more often than Power BI in this domain.
4. Python (255) and SAP (249) are nearly tied — interesting, since SAP is a domain-specific ERP system 
while Python is a general-purpose language; their near-equal demand suggests supply chain roles value both
programming skills and enterprise-system fluency at similar rates.
5. PowerPoint (213) and Word (200) both crack the top 10, ranking above R (130) and VBA (93) — a reminder 
that these roles expect real reporting/communication deliverables, not just backend data work.
6. VBA is the least in-demand of the top 10 (93 mentions) — still notable given it's a niche, 
Excel-specific automation skill, but clearly secondary to the broader tool stack.
7. The skill hierarchy for this domain: 
Excel → SQL → Tableau → Power BI → Python ≈ SAP → PowerPoint → Word → R → VBA — a "must-have" foundation 
of Excel + SQL, followed by BI tools, then a mix of programming and enterprise-system skills.

Takeaway
"Excel and SQL are the two must-have skills" ✅ — they're #1 (769) and #2 (490), well ahead of everything 
else.
"Tableau as the leading visualization tool" ✅ — 345 vs. Power BI's 280, confirmed.
"Python as a strong secondary skill" ✅ — 255 mentions, ranks #5 overall, reasonable to call it secondary 
but real.
*/

