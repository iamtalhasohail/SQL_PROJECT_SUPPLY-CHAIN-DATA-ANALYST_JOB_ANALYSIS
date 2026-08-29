/*
Question: What skills are required for the top 20 high paying supply chain data analyst jobs 
based in the United States?
NOTE: Analyst here Includes Business Analysts, Data Analysts, and Senior Data Analysts
         but within the supply chain industry
         whose job titles reference core supply chain functions — e.g. logistics,
         last-mile operations, procurement, sourcing, inventory, transportation, supplier/vendor
         management, and demand planning.
-- Scope decisions: excludes adjacent industries/tools KWs (e.g. 
   ERP/SAP/MRP systems, generic "production" or "quality control") to keep
   results function-specific rather than industry-broad.
-- Use the top 20 highest-paying jobs from first query.
-- Add specific skills required for those roles
-- Why? It provides a detailed look at which high-paying jobs demand what skills,
   helping job seekers understand which skills to develop that allign with top salaries 
*/

WITH top_paying_jobs AS
(
SELECT
job_id,
job_title,
job_title_short,
salary_year_avg,
company_dim.name AS company_name
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
LIMIT 20
)
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
LEFT JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;

-- NOTE: Used LEFT JOIN (not INNER JOIN) to preserve all 20 jobs from the
-- top_paying_jobs CTE, even though 3-4 postings have no tagged skills data
-- (resulting in NULL in the skills column for those rows). This keeps the
-- job list consistent with query 1, rather than silently dropping postings.


/*
Key findings of Top-20 supply chain analytics postings including skills:

1. SQL is the clear baseline skill. It appears in 55% of postings (11/20) — more than any 
other tool by a wide margin. If someone's targeting supply chain analytics roles, SQL is 
non-negotiable.

2. Tableau leads visualization, well ahead of Power BI. 35% of postings mention Tableau 
(7/20) vs. just 10% for Power BI (2/20) — a notably stronger tilt toward Tableau than you 
sometimes see in general data analyst postings, which are often closer to 50/50.

3. Excel, VBA, and Python are tied as secondary skills. Each sits at 25% (5/20) — a 
reminder that supply chain analytics still leans on spreadsheet-based workflows 
(forecasting models, planning sheets) alongside programming skills, rather than favoring 
one over the other.

4. Alteryx is a standout "supply chain specific" signal. At 20% (4/20), it's notably 
higher here than you'd typically see in general data analyst postings — Alteryx is 
heavily used for ETL/data-blending workflows common in supply chain and logistics 
operations, so this fits the domain well and is a good talking point ("supply chain 
analytics leans more on Alteryx than typical DA roles").

5. Long tail of niche/legacy tools (SAS, SPSS, C++, Java, Oracle, MS Access) suggests 
some postings — especially at larger, more established companies — still carry legacy 
tech stack requirements, likely tied to older internal systems.

6. Skill breadth varies a lot by posting — average ~3.75 skills per job across all 20 
postings.

7. 4 of 20 postings (20%) had no tagged skills at all — worth noting as a data 
completeness caveat in your writeup. Interestingly, all 4 are "Logistics"/"Navy 
Logistics"/"Transportation" titles (Falconwood, Federal Transit Administration, and 
Tecolote Research x2) — possibly a pattern in how specialized/government-adjacent roles 
get posted without structured skill tags.
*/

[
  {
    "job_id": 184746,
    "job_title": "Senior Logistics Data Analyst",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "175000.0",
    "company_name": "Falconwood, Incorporated",
    "skills": null
  },
  {
    "job_id": 284142,
    "job_title": "Logistics Quality Control Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "145877.5",
    "company_name": "TikTok",
    "skills": "sql"
  },
  {
    "job_id": 284142,
    "job_title": "Logistics Quality Control Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "145877.5",
    "company_name": "TikTok",
    "skills": "excel"
  },
  {
    "job_id": 284142,
    "job_title": "Logistics Quality Control Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "145877.5",
    "company_name": "TikTok",
    "skills": "tableau"
  },
  {
    "job_id": 138598,
    "job_title": "Data Analytics Manager | Industry Leading Shipping & Packaging...",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "140000.0",
    "company_name": "Glocomms",
    "skills": "sql"
  },
  {
    "job_id": 138598,
    "job_title": "Data Analytics Manager | Industry Leading Shipping & Packaging...",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "140000.0",
    "company_name": "Glocomms",
    "skills": "python"
  },
  {
    "job_id": 138598,
    "job_title": "Data Analytics Manager | Industry Leading Shipping & Packaging...",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "140000.0",
    "company_name": "Glocomms",
    "skills": "powershell"
  },
  {
    "job_id": 961999,
    "job_title": "Remote | WFH - Senior Data Analyst, Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Get It Recruit - Transporation",
    "skills": "sql"
  },
  {
    "job_id": 961999,
    "job_title": "Remote | WFH - Senior Data Analyst, Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Get It Recruit - Transporation",
    "skills": "python"
  },
  {
    "job_id": 961999,
    "job_title": "Remote | WFH - Senior Data Analyst, Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Get It Recruit - Transporation",
    "skills": "java"
  },
  {
    "job_id": 961999,
    "job_title": "Remote | WFH - Senior Data Analyst, Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Get It Recruit - Transporation",
    "skills": "r"
  },
  {
    "job_id": 961999,
    "job_title": "Remote | WFH - Senior Data Analyst, Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Get It Recruit - Transporation",
    "skills": "sas"
  },
  {
    "job_id": 961999,
    "job_title": "Remote | WFH - Senior Data Analyst, Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Get It Recruit - Transporation",
    "skills": "c++"
  },
  {
    "job_id": 961999,
    "job_title": "Remote | WFH - Senior Data Analyst, Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Get It Recruit - Transporation",
    "skills": "vba"
  },
  {
    "job_id": 961999,
    "job_title": "Remote | WFH - Senior Data Analyst, Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Get It Recruit - Transporation",
    "skills": "sql server"
  },
  {
    "job_id": 961999,
    "job_title": "Remote | WFH - Senior Data Analyst, Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Get It Recruit - Transporation",
    "skills": "oracle"
  },
  {
    "job_id": 961999,
    "job_title": "Remote | WFH - Senior Data Analyst, Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Get It Recruit - Transporation",
    "skills": "excel"
  },
  {
    "job_id": 961999,
    "job_title": "Remote | WFH - Senior Data Analyst, Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Get It Recruit - Transporation",
    "skills": "tableau"
  },
  {
    "job_id": 961999,
    "job_title": "Remote | WFH - Senior Data Analyst, Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Get It Recruit - Transporation",
    "skills": "sas"
  },
  {
    "job_id": 961999,
    "job_title": "Remote | WFH - Senior Data Analyst, Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Get It Recruit - Transporation",
    "skills": "spss"
  },
  {
    "job_id": 961999,
    "job_title": "Remote | WFH - Senior Data Analyst, Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Get It Recruit - Transporation",
    "skills": "ms access"
  },
  {
    "job_id": 9643,
    "job_title": "Senior Data Analyst, Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Home Depot / THD",
    "skills": "sql"
  },
  {
    "job_id": 9643,
    "job_title": "Senior Data Analyst, Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Home Depot / THD",
    "skills": "python"
  },
  {
    "job_id": 9643,
    "job_title": "Senior Data Analyst, Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Home Depot / THD",
    "skills": "java"
  },
  {
    "job_id": 9643,
    "job_title": "Senior Data Analyst, Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Home Depot / THD",
    "skills": "r"
  },
  {
    "job_id": 9643,
    "job_title": "Senior Data Analyst, Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Home Depot / THD",
    "skills": "sas"
  },
  {
    "job_id": 9643,
    "job_title": "Senior Data Analyst, Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Home Depot / THD",
    "skills": "c++"
  },
  {
    "job_id": 9643,
    "job_title": "Senior Data Analyst, Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Home Depot / THD",
    "skills": "vba"
  },
  {
    "job_id": 9643,
    "job_title": "Senior Data Analyst, Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Home Depot / THD",
    "skills": "sql server"
  },
  {
    "job_id": 9643,
    "job_title": "Senior Data Analyst, Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Home Depot / THD",
    "skills": "oracle"
  },
  {
    "job_id": 9643,
    "job_title": "Senior Data Analyst, Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Home Depot / THD",
    "skills": "excel"
  },
  {
    "job_id": 9643,
    "job_title": "Senior Data Analyst, Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Home Depot / THD",
    "skills": "tableau"
  },
  {
    "job_id": 9643,
    "job_title": "Senior Data Analyst, Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Home Depot / THD",
    "skills": "sas"
  },
  {
    "job_id": 9643,
    "job_title": "Senior Data Analyst, Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Home Depot / THD",
    "skills": "spss"
  },
  {
    "job_id": 9643,
    "job_title": "Senior Data Analyst, Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "Home Depot / THD",
    "skills": "ms access"
  },
  {
    "job_id": 1054439,
    "job_title": "Supply Chain Analyst",
    "job_title_short": "Business Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "LatentView Analytics Corporation",
    "skills": "sql"
  },
  {
    "job_id": 1054439,
    "job_title": "Supply Chain Analyst",
    "job_title_short": "Business Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "LatentView Analytics Corporation",
    "skills": "python"
  },
  {
    "job_id": 1054439,
    "job_title": "Supply Chain Analyst",
    "job_title_short": "Business Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "LatentView Analytics Corporation",
    "skills": "r"
  },
  {
    "job_id": 1054439,
    "job_title": "Supply Chain Analyst",
    "job_title_short": "Business Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "LatentView Analytics Corporation",
    "skills": "shell"
  },
  {
    "job_id": 1054439,
    "job_title": "Supply Chain Analyst",
    "job_title_short": "Business Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "LatentView Analytics Corporation",
    "skills": "c++"
  },
  {
    "job_id": 1054439,
    "job_title": "Supply Chain Analyst",
    "job_title_short": "Business Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "LatentView Analytics Corporation",
    "skills": "linux"
  },
  {
    "job_id": 1054439,
    "job_title": "Supply Chain Analyst",
    "job_title_short": "Business Analyst",
    "salary_year_avg": "130000.0",
    "company_name": "LatentView Analytics Corporation",
    "skills": "tableau"
  },
  {
    "job_id": 1363816,
    "job_title": "Transportation Program Specialist/ Transportation Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "126801.5",
    "company_name": "US Department of Transportation",
    "skills": "phoenix"
  },
  {
    "job_id": 1040844,
    "job_title": "Transportation Program Specialist / Transportation Data Analyst ...",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "126801.5",
    "company_name": "Federal Transit Administration",
    "skills": null
  },
  {
    "job_id": 220153,
    "job_title": "Transportation Program Specialist/ Transportation Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "126801.5",
    "company_name": "US Department of Transportation",
    "skills": "phoenix"
  },
  {
    "job_id": 691944,
    "job_title": "Transportation Program Specialist / Transportation Data Analyst ...",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "126801.5",
    "company_name": "US Department of Transportation",
    "skills": "phoenix"
  },
  {
    "job_id": 78545,
    "job_title": "Sr. Data Analyst - Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "125000.0",
    "company_name": "Ryder System, Inc",
    "skills": "sql"
  },
  {
    "job_id": 78545,
    "job_title": "Sr. Data Analyst - Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "125000.0",
    "company_name": "Ryder System, Inc",
    "skills": "vba"
  },
  {
    "job_id": 78545,
    "job_title": "Sr. Data Analyst - Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "125000.0",
    "company_name": "Ryder System, Inc",
    "skills": "alteryx"
  },
  {
    "job_id": 229373,
    "job_title": "Sr. Data Analyst - Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "125000.0",
    "company_name": "Ryder System, Inc",
    "skills": "sql"
  },
  {
    "job_id": 229373,
    "job_title": "Sr. Data Analyst - Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "125000.0",
    "company_name": "Ryder System, Inc",
    "skills": "vba"
  },
  {
    "job_id": 229373,
    "job_title": "Sr. Data Analyst - Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "125000.0",
    "company_name": "Ryder System, Inc",
    "skills": "alteryx"
  },
  {
    "job_id": 722783,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "125000.0",
    "company_name": "The Home Depot",
    "skills": "sql"
  },
  {
    "job_id": 722783,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "125000.0",
    "company_name": "The Home Depot",
    "skills": "c#"
  },
  {
    "job_id": 722783,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "125000.0",
    "company_name": "The Home Depot",
    "skills": "sql server"
  },
  {
    "job_id": 722783,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "125000.0",
    "company_name": "The Home Depot",
    "skills": "asp.net"
  },
  {
    "job_id": 722783,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "125000.0",
    "company_name": "The Home Depot",
    "skills": "ssrs"
  },
  {
    "job_id": 1598375,
    "job_title": "Sr. Data Analyst - Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "125000.0",
    "company_name": "Ryder System, Inc",
    "skills": "sql"
  },
  {
    "job_id": 1598375,
    "job_title": "Sr. Data Analyst - Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "125000.0",
    "company_name": "Ryder System, Inc",
    "skills": "vba"
  },
  {
    "job_id": 1598375,
    "job_title": "Sr. Data Analyst - Supply Chain (Remote)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "125000.0",
    "company_name": "Ryder System, Inc",
    "skills": "alteryx"
  },
  {
    "job_id": 1031014,
    "job_title": "Senior Navy Logistics Data Analyst",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "125000.0",
    "company_name": "Tecolote Research, Inc.",
    "skills": null
  },
  {
    "job_id": 1033600,
    "job_title": "HYBRID Transportation Analytics Manager (LTL exp. req.)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "120000.0",
    "company_name": "#twiceasnice Recruiting",
    "skills": "excel"
  },
  {
    "job_id": 1033600,
    "job_title": "HYBRID Transportation Analytics Manager (LTL exp. req.)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "120000.0",
    "company_name": "#twiceasnice Recruiting",
    "skills": "power bi"
  },
  {
    "job_id": 869117,
    "job_title": "Senior Supplier Data Analyst",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "115500.0",
    "company_name": "J&J Family of Companies",
    "skills": "azure"
  },
  {
    "job_id": 869117,
    "job_title": "Senior Supplier Data Analyst",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "115500.0",
    "company_name": "J&J Family of Companies",
    "skills": "databricks"
  },
  {
    "job_id": 869117,
    "job_title": "Senior Supplier Data Analyst",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "115500.0",
    "company_name": "J&J Family of Companies",
    "skills": "tableau"
  },
  {
    "job_id": 869117,
    "job_title": "Senior Supplier Data Analyst",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "115500.0",
    "company_name": "J&J Family of Companies",
    "skills": "power bi"
  },
  {
    "job_id": 869117,
    "job_title": "Senior Supplier Data Analyst",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "115500.0",
    "company_name": "J&J Family of Companies",
    "skills": "looker"
  },
  {
    "job_id": 869117,
    "job_title": "Senior Supplier Data Analyst",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "115500.0",
    "company_name": "J&J Family of Companies",
    "skills": "alteryx"
  },
  {
    "job_id": 1154019,
    "job_title": "Senior Navy Logistics Data Analyst",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "115000.0",
    "company_name": "Tecolote Research, Inc.",
    "skills": null
  },
  {
    "job_id": 1483400,
    "job_title": "Data Analyst, Supply Chain Data Analytics",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "115000.0",
    "company_name": "Tesla, Inc",
    "skills": "sql"
  },
  {
    "job_id": 1483400,
    "job_title": "Data Analyst, Supply Chain Data Analytics",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "115000.0",
    "company_name": "Tesla, Inc",
    "skills": "python"
  },
  {
    "job_id": 1483400,
    "job_title": "Data Analyst, Supply Chain Data Analytics",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "115000.0",
    "company_name": "Tesla, Inc",
    "skills": "pandas"
  },
  {
    "job_id": 1483400,
    "job_title": "Data Analyst, Supply Chain Data Analytics",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "115000.0",
    "company_name": "Tesla, Inc",
    "skills": "numpy"
  },
  {
    "job_id": 1483400,
    "job_title": "Data Analyst, Supply Chain Data Analytics",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "115000.0",
    "company_name": "Tesla, Inc",
    "skills": "matplotlib"
  },
  {
    "job_id": 1483400,
    "job_title": "Data Analyst, Supply Chain Data Analytics",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "115000.0",
    "company_name": "Tesla, Inc",
    "skills": "plotly"
  },
  {
    "job_id": 1483400,
    "job_title": "Data Analyst, Supply Chain Data Analytics",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "115000.0",
    "company_name": "Tesla, Inc",
    "skills": "excel"
  },
  {
    "job_id": 1483400,
    "job_title": "Data Analyst, Supply Chain Data Analytics",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "115000.0",
    "company_name": "Tesla, Inc",
    "skills": "tableau"
  },
  {
    "job_id": 1483400,
    "job_title": "Data Analyst, Supply Chain Data Analytics",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "115000.0",
    "company_name": "Tesla, Inc",
    "skills": "powerpoint"
  },
  {
    "job_id": 144106,
    "job_title": "Senior Inventory Data Analyst (Greater LA Area, CA)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "112500.0",
    "company_name": "Alo Yoga",
    "skills": "sql"
  },
  {
    "job_id": 144106,
    "job_title": "Senior Inventory Data Analyst (Greater LA Area, CA)",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "112500.0",
    "company_name": "Alo Yoga",
    "skills": "tableau"
  },
  {
    "job_id": 690167,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "111175.0",
    "company_name": "Tempus",
    "skills": "tableau"
  },
  {
    "job_id": 690167,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "111175.0",
    "company_name": "Tempus",
    "skills": "looker"
  },
  {
    "job_id": 1717166,
    "job_title": "Logistics Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "111175.0",
    "company_name": "Halvik",
    "skills": "excel"
  },
  {
    "job_id": 1717166,
    "job_title": "Logistics Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "111175.0",
    "company_name": "Halvik",
    "skills": "powerpoint"
  },
  {
    "job_id": 1720026,
    "job_title": "Capacity Planning Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "110000.0",
    "company_name": "SDI Presence",
    "skills": "excel"
  },
  {
    "job_id": 1720026,
    "job_title": "Capacity Planning Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "110000.0",
    "company_name": "SDI Presence",
    "skills": "powerpoint"
  },
  {
    "job_id": 1554191,
    "job_title": "Senior Inventory Data Analyst",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "110000.0",
    "company_name": "Company",
    "skills": "python"
  },
  {
    "job_id": 1554191,
    "job_title": "Senior Inventory Data Analyst",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "110000.0",
    "company_name": "Company",
    "skills": "excel"
  },
  {
    "job_id": 1554191,
    "job_title": "Senior Inventory Data Analyst",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "110000.0",
    "company_name": "Company",
    "skills": "tableau"
  },
  {
    "job_id": 153775,
    "job_title": "Supply Chain Data Analyst (Network Optimization)",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "110000.0",
    "company_name": "Insight Global",
    "skills": "sql"
  },
  {
    "job_id": 153775,
    "job_title": "Supply Chain Data Analyst (Network Optimization)",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "110000.0",
    "company_name": "Insight Global",
    "skills": "excel"
  },
  {
    "job_id": 153775,
    "job_title": "Supply Chain Data Analyst (Network Optimization)",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "110000.0",
    "company_name": "Insight Global",
    "skills": "tableau"
  },
  {
    "job_id": 361849,
    "job_title": "The Manager, Procurement Data & Analytics",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "105000.0",
    "company_name": "DaVita Kidney Care",
    "skills": null
  },
  {
    "job_id": 1241541,
    "job_title": "Senior Navy Logistics Data Analyst",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "105000.0",
    "company_name": "Tecolote Research, Inc.",
    "skills": null
  },
  {
    "job_id": 869531,
    "job_title": "Transportation Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "102500.0",
    "company_name": "Alameda Corridor Transportation Authority",
    "skills": "sql"
  },
  {
    "job_id": 869531,
    "job_title": "Transportation Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "102500.0",
    "company_name": "Alameda Corridor Transportation Authority",
    "skills": "python"
  },
  {
    "job_id": 869531,
    "job_title": "Transportation Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "102500.0",
    "company_name": "Alameda Corridor Transportation Authority",
    "skills": "r"
  },
  {
    "job_id": 869531,
    "job_title": "Transportation Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "102500.0",
    "company_name": "Alameda Corridor Transportation Authority",
    "skills": "c"
  },
  {
    "job_id": 869531,
    "job_title": "Transportation Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "102500.0",
    "company_name": "Alameda Corridor Transportation Authority",
    "skills": "excel"
  },
  {
    "job_id": 869531,
    "job_title": "Transportation Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "102500.0",
    "company_name": "Alameda Corridor Transportation Authority",
    "skills": "word"
  },
  {
    "job_id": 869531,
    "job_title": "Transportation Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "102500.0",
    "company_name": "Alameda Corridor Transportation Authority",
    "skills": "spreadsheet"
  },
  {
    "job_id": 476423,
    "job_title": "Inventory analyst",
    "job_title_short": "Business Analyst",
    "salary_year_avg": "100430.0",
    "company_name": "Citi",
    "skills": "excel"
  },
  {
    "job_id": 476423,
    "job_title": "Inventory analyst",
    "job_title_short": "Business Analyst",
    "salary_year_avg": "100430.0",
    "company_name": "Citi",
    "skills": "word"
  },
  {
    "job_id": 476423,
    "job_title": "Inventory analyst",
    "job_title_short": "Business Analyst",
    "salary_year_avg": "100430.0",
    "company_name": "Citi",
    "skills": "powerpoint"
  },
  {
    "job_id": 476423,
    "job_title": "Inventory analyst",
    "job_title_short": "Business Analyst",
    "salary_year_avg": "100430.0",
    "company_name": "Citi",
    "skills": "visio"
  },
  {
    "job_id": 652462,
    "job_title": "Sr. Data Analyst - Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "100000.0",
    "company_name": "New Bath Today",
    "skills": "sql"
  },
  {
    "job_id": 652462,
    "job_title": "Sr. Data Analyst - Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "100000.0",
    "company_name": "New Bath Today",
    "skills": "python"
  },
  {
    "job_id": 652462,
    "job_title": "Sr. Data Analyst - Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "100000.0",
    "company_name": "New Bath Today",
    "skills": "r"
  },
  {
    "job_id": 652462,
    "job_title": "Sr. Data Analyst - Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "100000.0",
    "company_name": "New Bath Today",
    "skills": "sas"
  },
  {
    "job_id": 652462,
    "job_title": "Sr. Data Analyst - Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "100000.0",
    "company_name": "New Bath Today",
    "skills": "vba"
  },
  {
    "job_id": 652462,
    "job_title": "Sr. Data Analyst - Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "100000.0",
    "company_name": "New Bath Today",
    "skills": "excel"
  },
  {
    "job_id": 652462,
    "job_title": "Sr. Data Analyst - Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "100000.0",
    "company_name": "New Bath Today",
    "skills": "tableau"
  },
  {
    "job_id": 652462,
    "job_title": "Sr. Data Analyst - Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "100000.0",
    "company_name": "New Bath Today",
    "skills": "power bi"
  },
  {
    "job_id": 652462,
    "job_title": "Sr. Data Analyst - Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "100000.0",
    "company_name": "New Bath Today",
    "skills": "sas"
  },
  {
    "job_id": 652462,
    "job_title": "Sr. Data Analyst - Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "100000.0",
    "company_name": "New Bath Today",
    "skills": "powerpoint"
  },
  {
    "job_id": 283592,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "98500.0",
    "company_name": "Atlas Energy Solutions",
    "skills": "excel"
  },
  {
    "job_id": 880263,
    "job_title": "Data Analyst - Fleet",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "95000.0",
    "company_name": "FINN",
    "skills": "sql"
  },
  {
    "job_id": 880263,
    "job_title": "Data Analyst - Fleet",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "95000.0",
    "company_name": "FINN",
    "skills": "looker"
  },
  {
    "job_id": 503539,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "95000.0",
    "company_name": "Insight Global",
    "skills": "sql"
  },
  {
    "job_id": 503539,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "95000.0",
    "company_name": "Insight Global",
    "skills": "python"
  },
  {
    "job_id": 503539,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "95000.0",
    "company_name": "Insight Global",
    "skills": "r"
  },
  {
    "job_id": 503539,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "95000.0",
    "company_name": "Insight Global",
    "skills": "vba"
  },
  {
    "job_id": 503539,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "95000.0",
    "company_name": "Insight Global",
    "skills": "excel"
  },
  {
    "job_id": 503539,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "95000.0",
    "company_name": "Insight Global",
    "skills": "tableau"
  },
  {
    "job_id": 503539,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "95000.0",
    "company_name": "Insight Global",
    "skills": "sap"
  },
  {
    "job_id": 503539,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "95000.0",
    "company_name": "Insight Global",
    "skills": "git"
  },
  {
    "job_id": 1650266,
    "job_title": "Buyer/Operations Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "95000.0",
    "company_name": "DSJ Global",
    "skills": "excel"
  },
  {
    "job_id": 1650266,
    "job_title": "Buyer/Operations Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "95000.0",
    "company_name": "DSJ Global",
    "skills": "word"
  },
  {
    "job_id": 1650266,
    "job_title": "Buyer/Operations Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "95000.0",
    "company_name": "DSJ Global",
    "skills": "powerpoint"
  },
  {
    "job_id": 1557428,
    "job_title": "Buyer/Operations Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "95000.0",
    "company_name": "Blackrock Resources",
    "skills": "excel"
  },
  {
    "job_id": 1557428,
    "job_title": "Buyer/Operations Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "95000.0",
    "company_name": "Blackrock Resources",
    "skills": "word"
  },
  {
    "job_id": 1557428,
    "job_title": "Buyer/Operations Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "95000.0",
    "company_name": "Blackrock Resources",
    "skills": "powerpoint"
  },
  {
    "job_id": 198444,
    "job_title": "Inventory Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "93500.0",
    "company_name": "PROCEPT BioRobotics",
    "skills": "excel"
  },
  {
    "job_id": 198444,
    "job_title": "Inventory Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "93500.0",
    "company_name": "PROCEPT BioRobotics",
    "skills": "tableau"
  },
  {
    "job_id": 198444,
    "job_title": "Inventory Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "93500.0",
    "company_name": "PROCEPT BioRobotics",
    "skills": "visio"
  },
  {
    "job_id": 198444,
    "job_title": "Inventory Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "93500.0",
    "company_name": "PROCEPT BioRobotics",
    "skills": "terminal"
  },
  {
    "job_id": 198444,
    "job_title": "Inventory Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "93500.0",
    "company_name": "PROCEPT BioRobotics",
    "skills": "smartsheet"
  },
  {
    "job_id": 1321066,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "HNY Ferry II, LLC",
    "skills": "sql"
  },
  {
    "job_id": 1321066,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "HNY Ferry II, LLC",
    "skills": "python"
  },
  {
    "job_id": 1321066,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "HNY Ferry II, LLC",
    "skills": "r"
  },
  {
    "job_id": 1321066,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "HNY Ferry II, LLC",
    "skills": "sas"
  },
  {
    "job_id": 1321066,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "HNY Ferry II, LLC",
    "skills": "excel"
  },
  {
    "job_id": 1321066,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "HNY Ferry II, LLC",
    "skills": "tableau"
  },
  {
    "job_id": 1321066,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "HNY Ferry II, LLC",
    "skills": "power bi"
  },
  {
    "job_id": 1321066,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "HNY Ferry II, LLC",
    "skills": "sas"
  },
  {
    "job_id": 1321066,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "HNY Ferry II, LLC",
    "skills": "spss"
  },
  {
    "job_id": 297740,
    "job_title": "Supply Chain Data Analyst and Planner",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Silvus Technologies",
    "skills": "excel"
  },
  {
    "job_id": 297740,
    "job_title": "Supply Chain Data Analyst and Planner",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Silvus Technologies",
    "skills": "spreadsheet"
  },
  {
    "job_id": 297740,
    "job_title": "Supply Chain Data Analyst and Planner",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Silvus Technologies",
    "skills": "sheets"
  },
  {
    "job_id": 297740,
    "job_title": "Supply Chain Data Analyst and Planner",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Silvus Technologies",
    "skills": "planner"
  },
  {
    "job_id": 914174,
    "job_title": "Data Analyst, Supply Chain (Remote)",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Home Depot / THD",
    "skills": "sql"
  },
  {
    "job_id": 914174,
    "job_title": "Data Analyst, Supply Chain (Remote)",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Home Depot / THD",
    "skills": "sql server"
  },
  {
    "job_id": 914174,
    "job_title": "Data Analyst, Supply Chain (Remote)",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Home Depot / THD",
    "skills": "oracle"
  },
  {
    "job_id": 932115,
    "job_title": "Sourcing Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Lhoist North America",
    "skills": null
  },
  {
    "job_id": 457133,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Hornblower Inc",
    "skills": "sql"
  },
  {
    "job_id": 457133,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Hornblower Inc",
    "skills": "python"
  },
  {
    "job_id": 457133,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Hornblower Inc",
    "skills": "r"
  },
  {
    "job_id": 457133,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Hornblower Inc",
    "skills": "sas"
  },
  {
    "job_id": 457133,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Hornblower Inc",
    "skills": "excel"
  },
  {
    "job_id": 457133,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Hornblower Inc",
    "skills": "tableau"
  },
  {
    "job_id": 457133,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Hornblower Inc",
    "skills": "power bi"
  },
  {
    "job_id": 457133,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Hornblower Inc",
    "skills": "sas"
  },
  {
    "job_id": 457133,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Hornblower Inc",
    "skills": "spss"
  },
  {
    "job_id": 1060670,
    "job_title": "Data Analyst, Fulfillment",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Tesla, Inc",
    "skills": "sql"
  },
  {
    "job_id": 1060670,
    "job_title": "Data Analyst, Fulfillment",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Tesla, Inc",
    "skills": "sas"
  },
  {
    "job_id": 1060670,
    "job_title": "Data Analyst, Fulfillment",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Tesla, Inc",
    "skills": "javascript"
  },
  {
    "job_id": 1060670,
    "job_title": "Data Analyst, Fulfillment",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Tesla, Inc",
    "skills": "excel"
  },
  {
    "job_id": 1060670,
    "job_title": "Data Analyst, Fulfillment",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Tesla, Inc",
    "skills": "tableau"
  },
  {
    "job_id": 1060670,
    "job_title": "Data Analyst, Fulfillment",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Tesla, Inc",
    "skills": "sas"
  },
  {
    "job_id": 1060670,
    "job_title": "Data Analyst, Fulfillment",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Tesla, Inc",
    "skills": "spss"
  },
  {
    "job_id": 1491573,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "The Home Depot",
    "skills": "sql"
  },
  {
    "job_id": 1491573,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "The Home Depot",
    "skills": "python"
  },
  {
    "job_id": 1491573,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "The Home Depot",
    "skills": "java"
  },
  {
    "job_id": 1491573,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "The Home Depot",
    "skills": "r"
  },
  {
    "job_id": 1491573,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "The Home Depot",
    "skills": "sas"
  },
  {
    "job_id": 1491573,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "The Home Depot",
    "skills": "c++"
  },
  {
    "job_id": 1491573,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "The Home Depot",
    "skills": "vba"
  },
  {
    "job_id": 1491573,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "The Home Depot",
    "skills": "sql server"
  },
  {
    "job_id": 1491573,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "The Home Depot",
    "skills": "oracle"
  },
  {
    "job_id": 1491573,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "The Home Depot",
    "skills": "excel"
  },
  {
    "job_id": 1491573,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "The Home Depot",
    "skills": "tableau"
  },
  {
    "job_id": 1491573,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "The Home Depot",
    "skills": "sas"
  },
  {
    "job_id": 1491573,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "The Home Depot",
    "skills": "spss"
  },
  {
    "job_id": 1491573,
    "job_title": "Sr. Data Analyst – Supply Chain",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "The Home Depot",
    "skills": "ms access"
  },
  {
    "job_id": 1488846,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Hornblower Inc",
    "skills": "sql"
  },
  {
    "job_id": 1488846,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Hornblower Inc",
    "skills": "python"
  },
  {
    "job_id": 1488846,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Hornblower Inc",
    "skills": "r"
  },
  {
    "job_id": 1488846,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Hornblower Inc",
    "skills": "sas"
  },
  {
    "job_id": 1488846,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Hornblower Inc",
    "skills": "excel"
  },
  {
    "job_id": 1488846,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Hornblower Inc",
    "skills": "tableau"
  },
  {
    "job_id": 1488846,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Hornblower Inc",
    "skills": "power bi"
  },
  {
    "job_id": 1488846,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Hornblower Inc",
    "skills": "sas"
  },
  {
    "job_id": 1488846,
    "job_title": "Senior Transportation Scheduling and Data Analyst - NYC Ferry",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "90000.0",
    "company_name": "Hornblower Inc",
    "skills": "spss"
  },
  {
    "job_id": 1569179,
    "job_title": "Supplier Diversity Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "89315.203125",
    "company_name": "Massachusetts Bay Transportation Authority",
    "skills": "sql"
  },
  {
    "job_id": 1569179,
    "job_title": "Supplier Diversity Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "89315.203125",
    "company_name": "Massachusetts Bay Transportation Authority",
    "skills": "python"
  },
  {
    "job_id": 1569179,
    "job_title": "Supplier Diversity Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "89315.203125",
    "company_name": "Massachusetts Bay Transportation Authority",
    "skills": "r"
  },
  {
    "job_id": 1569179,
    "job_title": "Supplier Diversity Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "89315.203125",
    "company_name": "Massachusetts Bay Transportation Authority",
    "skills": "tableau"
  },
  {
    "job_id": 22656,
    "job_title": "Supplier Diversity Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "89315.203125",
    "company_name": "MBTA",
    "skills": "sql"
  },
  {
    "job_id": 22656,
    "job_title": "Supplier Diversity Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "89315.203125",
    "company_name": "MBTA",
    "skills": "python"
  },
  {
    "job_id": 22656,
    "job_title": "Supplier Diversity Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "89315.203125",
    "company_name": "MBTA",
    "skills": "r"
  },
  {
    "job_id": 22656,
    "job_title": "Supplier Diversity Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "89315.203125",
    "company_name": "MBTA",
    "skills": "tableau"
  },
  {
    "job_id": 660036,
    "job_title": "Senior Supply Chain Analytics Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "89000.0",
    "company_name": "Get It Recruit - Transportation",
    "skills": "python"
  },
  {
    "job_id": 660036,
    "job_title": "Senior Supply Chain Analytics Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "89000.0",
    "company_name": "Get It Recruit - Transportation",
    "skills": "r"
  },
  {
    "job_id": 660036,
    "job_title": "Senior Supply Chain Analytics Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "89000.0",
    "company_name": "Get It Recruit - Transportation",
    "skills": "tableau"
  },
  {
    "job_id": 660036,
    "job_title": "Senior Supply Chain Analytics Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "89000.0",
    "company_name": "Get It Recruit - Transportation",
    "skills": "alteryx"
  },
  {
    "job_id": 1657752,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "88000.0",
    "company_name": "Get It Recruit - Transportation",
    "skills": "excel"
  },
  {
    "job_id": 1657752,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "88000.0",
    "company_name": "Get It Recruit - Transportation",
    "skills": "word"
  },
  {
    "job_id": 1657752,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "88000.0",
    "company_name": "Get It Recruit - Transportation",
    "skills": "powerpoint"
  },
  {
    "job_id": 1657752,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "88000.0",
    "company_name": "Get It Recruit - Transportation",
    "skills": "outlook"
  },
  {
    "job_id": 888697,
    "job_title": "Strategic Sourcing Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "86732.5",
    "company_name": "Apple",
    "skills": "sql"
  },
  {
    "job_id": 888697,
    "job_title": "Strategic Sourcing Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "86732.5",
    "company_name": "Apple",
    "skills": "r"
  },
  {
    "job_id": 888697,
    "job_title": "Strategic Sourcing Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "86732.5",
    "company_name": "Apple",
    "skills": "tableau"
  },
  {
    "job_id": 888697,
    "job_title": "Strategic Sourcing Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "86732.5",
    "company_name": "Apple",
    "skills": "alteryx"
  },
  {
    "job_id": 97888,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "85000.0",
    "company_name": "Stella & Chewy's",
    "skills": "excel"
  },
  {
    "job_id": 97888,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "85000.0",
    "company_name": "Stella & Chewy's",
    "skills": "power bi"
  },
  {
    "job_id": 97888,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "85000.0",
    "company_name": "Stella & Chewy's",
    "skills": "flow"
  },
  {
    "job_id": 939699,
    "job_title": "1403487 - Supply Chain Transformation Data & Analytics Project...",
    "job_title_short": "Business Analyst",
    "salary_year_avg": "84700.0",
    "company_name": "Cisco",
    "skills": "excel"
  },
  {
    "job_id": 939699,
    "job_title": "1403487 - Supply Chain Transformation Data & Analytics Project...",
    "job_title_short": "Business Analyst",
    "salary_year_avg": "84700.0",
    "company_name": "Cisco",
    "skills": "tableau"
  },
  {
    "job_id": 939699,
    "job_title": "1403487 - Supply Chain Transformation Data & Analytics Project...",
    "job_title_short": "Business Analyst",
    "salary_year_avg": "84700.0",
    "company_name": "Cisco",
    "skills": "power bi"
  },
  {
    "job_id": 1756680,
    "job_title": "Data Analyst III - Transportation Planning and Programming ...",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "84479.0",
    "company_name": "Texas Department of Transportation",
    "skills": "sql"
  },
  {
    "job_id": 1756680,
    "job_title": "Data Analyst III - Transportation Planning and Programming ...",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "84479.0",
    "company_name": "Texas Department of Transportation",
    "skills": "sql server"
  },
  {
    "job_id": 1756680,
    "job_title": "Data Analyst III - Transportation Planning and Programming ...",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "84479.0",
    "company_name": "Texas Department of Transportation",
    "skills": "oracle"
  },
  {
    "job_id": 1756680,
    "job_title": "Data Analyst III - Transportation Planning and Programming ...",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "84479.0",
    "company_name": "Texas Department of Transportation",
    "skills": "excel"
  },
  {
    "job_id": 1756680,
    "job_title": "Data Analyst III - Transportation Planning and Programming ...",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "84479.0",
    "company_name": "Texas Department of Transportation",
    "skills": "tableau"
  },
  {
    "job_id": 1756680,
    "job_title": "Data Analyst III - Transportation Planning and Programming ...",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "84479.0",
    "company_name": "Texas Department of Transportation",
    "skills": "power bi"
  },
  {
    "job_id": 1756680,
    "job_title": "Data Analyst III - Transportation Planning and Programming ...",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "84479.0",
    "company_name": "Texas Department of Transportation",
    "skills": "qlik"
  },
  {
    "job_id": 1756680,
    "job_title": "Data Analyst III - Transportation Planning and Programming ...",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "84479.0",
    "company_name": "Texas Department of Transportation",
    "skills": "ms access"
  },
  {
    "job_id": 583813,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "83500.0",
    "company_name": "Get It Recruit - Transportation",
    "skills": null
  },
  {
    "job_id": 749430,
    "job_title": "Logistics Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "82830.0",
    "company_name": "Defense Logistics Agency",
    "skills": null
  },
  {
    "job_id": 1714124,
    "job_title": "Logistics Data Analyst and Forecaster",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "82500.0",
    "company_name": "Geopaq Logic",
    "skills": "excel"
  },
  {
    "job_id": 1714124,
    "job_title": "Logistics Data Analyst and Forecaster",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "82500.0",
    "company_name": "Geopaq Logic",
    "skills": "word"
  },
  {
    "job_id": 1714124,
    "job_title": "Logistics Data Analyst and Forecaster",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "82500.0",
    "company_name": "Geopaq Logic",
    "skills": "outlook"
  },
  {
    "job_id": 319860,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "81600.0",
    "company_name": "Vantage Elevation",
    "skills": null
  },
  {
    "job_id": 547171,
    "job_title": "Data Analyst- Supply Chain",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "80000.0",
    "company_name": "Coldwater Creek",
    "skills": "sql"
  },
  {
    "job_id": 547171,
    "job_title": "Data Analyst- Supply Chain",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "80000.0",
    "company_name": "Coldwater Creek",
    "skills": "azure"
  },
  {
    "job_id": 547171,
    "job_title": "Data Analyst- Supply Chain",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "80000.0",
    "company_name": "Coldwater Creek",
    "skills": "excel"
  },
  {
    "job_id": 547171,
    "job_title": "Data Analyst- Supply Chain",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "80000.0",
    "company_name": "Coldwater Creek",
    "skills": "tableau"
  },
  {
    "job_id": 547171,
    "job_title": "Data Analyst- Supply Chain",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "80000.0",
    "company_name": "Coldwater Creek",
    "skills": "power bi"
  },
  {
    "job_id": 547171,
    "job_title": "Data Analyst- Supply Chain",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "80000.0",
    "company_name": "Coldwater Creek",
    "skills": "dax"
  },
  {
    "job_id": 547171,
    "job_title": "Data Analyst- Supply Chain",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "80000.0",
    "company_name": "Coldwater Creek",
    "skills": "qlik"
  },
  {
    "job_id": 620584,
    "job_title": "Procurement Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "80000.0",
    "company_name": "Arconic",
    "skills": "sql"
  },
  {
    "job_id": 620584,
    "job_title": "Procurement Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "80000.0",
    "company_name": "Arconic",
    "skills": "oracle"
  },
  {
    "job_id": 620584,
    "job_title": "Procurement Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "80000.0",
    "company_name": "Arconic",
    "skills": "excel"
  },
  {
    "job_id": 620584,
    "job_title": "Procurement Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "80000.0",
    "company_name": "Arconic",
    "skills": "power bi"
  },
  {
    "job_id": 620584,
    "job_title": "Procurement Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "80000.0",
    "company_name": "Arconic",
    "skills": "sharepoint"
  },
  {
    "job_id": 547485,
    "job_title": "Procurement Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "80000.0",
    "company_name": "Arconic",
    "skills": "sql"
  },
  {
    "job_id": 547485,
    "job_title": "Procurement Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "80000.0",
    "company_name": "Arconic",
    "skills": "oracle"
  },
  {
    "job_id": 547485,
    "job_title": "Procurement Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "80000.0",
    "company_name": "Arconic",
    "skills": "excel"
  },
  {
    "job_id": 547485,
    "job_title": "Procurement Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "80000.0",
    "company_name": "Arconic",
    "skills": "power bi"
  },
  {
    "job_id": 547485,
    "job_title": "Procurement Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "80000.0",
    "company_name": "Arconic",
    "skills": "sharepoint"
  },
  {
    "job_id": 872856,
    "job_title": "Supply Chain Data Analyst (Manufacturing)",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "77800.0",
    "company_name": "Partners Personnel - Professional & Contact Center",
    "skills": "excel"
  },
  {
    "job_id": 1536711,
    "job_title": "Data Analyst - (Transportation)",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "76747.5",
    "company_name": "Baltimore City Public Schools",
    "skills": "sas"
  },
  {
    "job_id": 1536711,
    "job_title": "Data Analyst - (Transportation)",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "76747.5",
    "company_name": "Baltimore City Public Schools",
    "skills": "visual basic"
  },
  {
    "job_id": 1536711,
    "job_title": "Data Analyst - (Transportation)",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "76747.5",
    "company_name": "Baltimore City Public Schools",
    "skills": "excel"
  },
  {
    "job_id": 1536711,
    "job_title": "Data Analyst - (Transportation)",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "76747.5",
    "company_name": "Baltimore City Public Schools",
    "skills": "sas"
  },
  {
    "job_id": 1536711,
    "job_title": "Data Analyst - (Transportation)",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "76747.5",
    "company_name": "Baltimore City Public Schools",
    "skills": "spss"
  },
  {
    "job_id": 137165,
    "job_title": "Supply chain analyst",
    "job_title_short": "Business Analyst",
    "salary_year_avg": "76000.0",
    "company_name": "Edwards Lifesciences",
    "skills": "tableau"
  },
  {
    "job_id": 578018,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "75000.0",
    "company_name": "Thompson Pipe Group",
    "skills": "python"
  },
  {
    "job_id": 578018,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "75000.0",
    "company_name": "Thompson Pipe Group",
    "skills": "vba"
  },
  {
    "job_id": 578018,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "75000.0",
    "company_name": "Thompson Pipe Group",
    "skills": "excel"
  },
  {
    "job_id": 578018,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "75000.0",
    "company_name": "Thompson Pipe Group",
    "skills": "tableau"
  },
  {
    "job_id": 221984,
    "job_title": "Data Analyst, Category Management & Demand Planning",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "75000.0",
    "company_name": "MaryRuth's",
    "skills": "excel"
  },
  {
    "job_id": 221984,
    "job_title": "Data Analyst, Category Management & Demand Planning",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "75000.0",
    "company_name": "MaryRuth's",
    "skills": "sap"
  },
  {
    "job_id": 221984,
    "job_title": "Data Analyst, Category Management & Demand Planning",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "75000.0",
    "company_name": "MaryRuth's",
    "skills": "flow"
  },
  {
    "job_id": 193923,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "75000.0",
    "company_name": "Get It Recruit - Transportation",
    "skills": "excel"
  },
  {
    "job_id": 193923,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "75000.0",
    "company_name": "Get It Recruit - Transportation",
    "skills": "power bi"
  },
  {
    "job_id": 1064002,
    "job_title": "Sourcing Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "72500.0",
    "company_name": "LHH",
    "skills": null
  },
  {
    "job_id": 768723,
    "job_title": "Supply Chain Analyst",
    "job_title_short": "Business Analyst",
    "salary_year_avg": "72000.0",
    "company_name": "Get It Recruit - Transportation",
    "skills": null
  },
  {
    "job_id": 814835,
    "job_title": "Senior Data Analyst - Procurement",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "71000.0",
    "company_name": "Diversey, Inc.",
    "skills": "python"
  },
  {
    "job_id": 814835,
    "job_title": "Senior Data Analyst - Procurement",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "71000.0",
    "company_name": "Diversey, Inc.",
    "skills": "excel"
  },
  {
    "job_id": 814835,
    "job_title": "Senior Data Analyst - Procurement",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "71000.0",
    "company_name": "Diversey, Inc.",
    "skills": "tableau"
  },
  {
    "job_id": 814835,
    "job_title": "Senior Data Analyst - Procurement",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "71000.0",
    "company_name": "Diversey, Inc.",
    "skills": "power bi"
  },
  {
    "job_id": 814835,
    "job_title": "Senior Data Analyst - Procurement",
    "job_title_short": "Senior Data Analyst",
    "salary_year_avg": "71000.0",
    "company_name": "Diversey, Inc.",
    "skills": "powerpoint"
  },
  {
    "job_id": 212882,
    "job_title": "Transportation Program Specialist / Transportation Data Analyst ...",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "70103.0",
    "company_name": "Federal Transit Administration",
    "skills": null
  },
  {
    "job_id": 436732,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "70000.0",
    "company_name": "Insight Global",
    "skills": "sql"
  },
  {
    "job_id": 436732,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "70000.0",
    "company_name": "Insight Global",
    "skills": "excel"
  },
  {
    "job_id": 436732,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "70000.0",
    "company_name": "Insight Global",
    "skills": "flow"
  },
  {
    "job_id": 665747,
    "job_title": "Procurement Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "70000.0",
    "company_name": "aquesst",
    "skills": "sql"
  },
  {
    "job_id": 665747,
    "job_title": "Procurement Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "70000.0",
    "company_name": "aquesst",
    "skills": "excel"
  },
  {
    "job_id": 1063429,
    "job_title": "Vendor Relations Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "70000.0",
    "company_name": "Solar Energy World",
    "skills": "python"
  },
  {
    "job_id": 1063429,
    "job_title": "Vendor Relations Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "70000.0",
    "company_name": "Solar Energy World",
    "skills": "excel"
  },
  {
    "job_id": 1063429,
    "job_title": "Vendor Relations Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "70000.0",
    "company_name": "Solar Energy World",
    "skills": "power bi"
  },
  {
    "job_id": 616079,
    "job_title": "Product Data Analyst - Fleet",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "68000.0",
    "company_name": "The Hertz Corporation",
    "skills": "sql"
  },
  {
    "job_id": 616079,
    "job_title": "Product Data Analyst - Fleet",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "68000.0",
    "company_name": "The Hertz Corporation",
    "skills": "python"
  },
  {
    "job_id": 616079,
    "job_title": "Product Data Analyst - Fleet",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "68000.0",
    "company_name": "The Hertz Corporation",
    "skills": "aws"
  },
  {
    "job_id": 616079,
    "job_title": "Product Data Analyst - Fleet",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "68000.0",
    "company_name": "The Hertz Corporation",
    "skills": "tableau"
  },
  {
    "job_id": 1739241,
    "job_title": "Logistics Data Analyst (Power BI exp. req.)",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "67500.0",
    "company_name": "#twiceasnice Recruiting",
    "skills": "excel"
  },
  {
    "job_id": 1739241,
    "job_title": "Logistics Data Analyst (Power BI exp. req.)",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "67500.0",
    "company_name": "#twiceasnice Recruiting",
    "skills": "power bi"
  },
  {
    "job_id": 337493,
    "job_title": "Data / Supply Chain Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "67500.0",
    "company_name": "Magnify",
    "skills": "excel"
  },
  {
    "job_id": 949687,
    "job_title": "Supplier Diversity Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "65037.5",
    "company_name": "Boston Planning and Development Agency",
    "skills": "excel"
  },
  {
    "job_id": 949687,
    "job_title": "Supplier Diversity Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "65037.5",
    "company_name": "Boston Planning and Development Agency",
    "skills": "word"
  },
  {
    "job_id": 949687,
    "job_title": "Supplier Diversity Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "65037.5",
    "company_name": "Boston Planning and Development Agency",
    "skills": "airtable"
  },
  {
    "job_id": 949687,
    "job_title": "Supplier Diversity Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "65037.5",
    "company_name": "Boston Planning and Development Agency",
    "skills": "asana"
  },
  {
    "job_id": 18591,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "65000.0",
    "company_name": "DYNAMIC MANUFACTURING INC",
    "skills": "assembly"
  },
  {
    "job_id": 18591,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "65000.0",
    "company_name": "DYNAMIC MANUFACTURING INC",
    "skills": "excel"
  },
  {
    "job_id": 18591,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "65000.0",
    "company_name": "DYNAMIC MANUFACTURING INC",
    "skills": "spreadsheet"
  },
  {
    "job_id": 18591,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "65000.0",
    "company_name": "DYNAMIC MANUFACTURING INC",
    "skills": "outlook"
  },
  {
    "job_id": 940260,
    "job_title": "Data Analyst - Procurement",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "65000.0",
    "company_name": "Mane USA",
    "skills": "excel"
  },
  {
    "job_id": 940260,
    "job_title": "Data Analyst - Procurement",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "65000.0",
    "company_name": "Mane USA",
    "skills": "sap"
  },
  {
    "job_id": 940260,
    "job_title": "Data Analyst - Procurement",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "65000.0",
    "company_name": "Mane USA",
    "skills": "powerpoint"
  },
  {
    "job_id": 937462,
    "job_title": "Buyer or Data Analyst Category Specialist",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "65000.0",
    "company_name": "Paul May Associates",
    "skills": "excel"
  },
  {
    "job_id": 937462,
    "job_title": "Buyer or Data Analyst Category Specialist",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "65000.0",
    "company_name": "Paul May Associates",
    "skills": "word"
  },
  {
    "job_id": 520305,
    "job_title": "Inventory Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "65000.0",
    "company_name": "CannabizTeam - Executive Search and Staffing",
    "skills": null
  },
  {
    "job_id": 679714,
    "job_title": "Data Analyst (Hybrid, 1+ yrs exp req, Supply Chain Ind)",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "62500.0",
    "company_name": "#twiceasnice Recruiting",
    "skills": "excel"
  },
  {
    "job_id": 679714,
    "job_title": "Data Analyst (Hybrid, 1+ yrs exp req, Supply Chain Ind)",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "62500.0",
    "company_name": "#twiceasnice Recruiting",
    "skills": "power bi"
  },
  {
    "job_id": 553921,
    "job_title": "Supply Chain Data Integrity Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "62500.0",
    "company_name": "Get It Recruit - Transportation",
    "skills": "excel"
  },
  {
    "job_id": 526263,
    "job_title": "Data Analyst IV - Public Transportation Division",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "62004.0",
    "company_name": "Texas Department of Transportation",
    "skills": "sql"
  },
  {
    "job_id": 526263,
    "job_title": "Data Analyst IV - Public Transportation Division",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "62004.0",
    "company_name": "Texas Department of Transportation",
    "skills": "excel"
  },
  {
    "job_id": 644972,
    "job_title": "Fulfillment Data Analyst-Hybrid-Reside in Atlanta/Fairburn area.",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "61500.0",
    "company_name": "TOTO USA, Inc.",
    "skills": "excel"
  },
  {
    "job_id": 644972,
    "job_title": "Fulfillment Data Analyst-Hybrid-Reside in Atlanta/Fairburn area.",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "61500.0",
    "company_name": "TOTO USA, Inc.",
    "skills": "sap"
  },
  {
    "job_id": 644972,
    "job_title": "Fulfillment Data Analyst-Hybrid-Reside in Atlanta/Fairburn area.",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "61500.0",
    "company_name": "TOTO USA, Inc.",
    "skills": "powerpoint"
  },
  {
    "job_id": 1240845,
    "job_title": "MINC Purchasing Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "60000.0",
    "company_name": "Mane USA",
    "skills": "excel"
  },
  {
    "job_id": 1240845,
    "job_title": "MINC Purchasing Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "60000.0",
    "company_name": "Mane USA",
    "skills": "sap"
  },
  {
    "job_id": 1240845,
    "job_title": "MINC Purchasing Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "60000.0",
    "company_name": "Mane USA",
    "skills": "powerpoint"
  },
  {
    "job_id": 862906,
    "job_title": "Logistics Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "60000.0",
    "company_name": "Spartan 5S Solutions",
    "skills": null
  },
  {
    "job_id": 1091264,
    "job_title": "Logistics Data Analyst (Remote Friendly)",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "58000.0",
    "company_name": "Webstaurant Store",
    "skills": "sql"
  },
  {
    "job_id": 1091264,
    "job_title": "Logistics Data Analyst (Remote Friendly)",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "58000.0",
    "company_name": "Webstaurant Store",
    "skills": "excel"
  },
  {
    "job_id": 1162173,
    "job_title": "Transportation Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "57500.0",
    "company_name": "ZERO EMISSIONS PARTNERS LLC",
    "skills": "excel"
  },
  {
    "job_id": 1638304,
    "job_title": "Transportation Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "57500.0",
    "company_name": "ZERO EMISSIONS PARTNERS LLC",
    "skills": "excel"
  },
  {
    "job_id": 469837,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "57500.0",
    "company_name": "Armas Pharmaceuticals",
    "skills": "sql"
  },
  {
    "job_id": 469837,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "57500.0",
    "company_name": "Armas Pharmaceuticals",
    "skills": "python"
  },
  {
    "job_id": 469837,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "57500.0",
    "company_name": "Armas Pharmaceuticals",
    "skills": "excel"
  },
  {
    "job_id": 1502287,
    "job_title": "Transportation Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "57500.0",
    "company_name": "ZERO EMISSIONS PARTNERS LLC",
    "skills": "excel"
  },
  {
    "job_id": 1807725,
    "job_title": "Purchasing Junior Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "55000.0",
    "company_name": "Arocam Sports Inc.",
    "skills": "excel"
  },
  {
    "job_id": 1784479,
    "job_title": "Entry Level BI Analyst – Logistics",
    "job_title_short": "Business Analyst",
    "salary_year_avg": "55000.0",
    "company_name": "LaSalle Network",
    "skills": "excel"
  },
  {
    "job_id": 1784479,
    "job_title": "Entry Level BI Analyst – Logistics",
    "job_title_short": "Business Analyst",
    "salary_year_avg": "55000.0",
    "company_name": "LaSalle Network",
    "skills": "sap"
  },
  {
    "job_id": 498995,
    "job_title": "Fleet Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "54000.0",
    "company_name": "Excell Communications Inc",
    "skills": "excel"
  },
  {
    "job_id": 481162,
    "job_title": "Supply Chain Data Analyst Intern",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "50000.0",
    "company_name": "Veritiv Corporation",
    "skills": null
  },
  {
    "job_id": 791379,
    "job_title": "Import/Export Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "50000.0",
    "company_name": "Elwood Staffing",
    "skills": null
  },
  {
    "job_id": 1252057,
    "job_title": "Logistics Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "50000.0",
    "company_name": "Great American Transport",
    "skills": "sap"
  },
  {
    "job_id": 1252057,
    "job_title": "Logistics Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "50000.0",
    "company_name": "Great American Transport",
    "skills": "planner"
  },
  {
    "job_id": 126115,
    "job_title": "Data Analyst in Logistics",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "47500.0",
    "company_name": "JobGiraffe",
    "skills": null
  },
  {
    "job_id": 720897,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "40000.0",
    "company_name": "Techniweld USA",
    "skills": "oracle"
  },
  {
    "job_id": 720897,
    "job_title": "Supply Chain Data Analyst",
    "job_title_short": "Data Analyst",
    "salary_year_avg": "40000.0",
    "company_name": "Techniweld USA",
    "skills": "sheets"
  }
]