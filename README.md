# Unified-Analytics-Pipeline-GitHub-CircleCI-dbt-Databricks

<p align="center">
  <img src="https://img.shields.io/badge/Architecture-Medallion-orange?style=for-the-badge" alt="Medallion">
  <img src="https://img.shields.io/badge/Data%20Warehouse-Databricks-red?style=for-the-badge&logo=databricks" alt="Databricks">
  <img src="https://img.shields.io/badge/CI/CD-CircleCI-black?style=for-the-badge&logo=circleci" alt="CircleCI">
  <img src="https://img.shields.io/badge/Transformation-dbt-orange?style=for-the-badge&logo=dbt" alt="dbt">
</p>

<br>

<h2>Overview</h2>
<p>
This project demonstrates a <b>production-grade end-to-end analytics engineering pipeline</b>. It automates the ingestion, transformation, and testing of data using a Medallion Architecture within the <b>Databricks Unity Catalog</b>.
</p>

<hr>

<h2>Architecture Deep Dive</h2>

<h3>1. The Medallion Layers</h3>
<ul>
    <li><b>Bronze:</b> Raw ingestion from CSV seeds (<code>seeds/raw_sales.csv</code>).</li>
    <li><b>Silver:</b> Cleaned and typed relational tables (<code>models/silver/sales__cleaned.sql</code>).</li>
    <li><b>Gold:</b> High-level business aggregates (<code>models/gold/gold_sales__monthly.sql</code>).</li>
</ul>

<h3>2. CI/CD Workflow</h3>
<p>Integrated with <b>CircleCI</b>, every push to the <code>main</code> branch triggers:</p>
<ol>
    <li>Environment provisioning via Docker.</li>
    <li>Secure dynamic <code>profiles.yml</code> generation using environment variables.</li>
    <li>Execution of <code>dbt seed</code>, <code>dbt run</code>, and <code>dbt test</code> against Databricks.</li>
</ol>

<hr>

<h2>Setup Instructions</h2>

<h3>Local Environment Variables</h3>
<p>To run this project locally or in CircleCI, ensure the following variables are configured:</p>

<table>
  <tr>
    <th>Variable</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><code>DB_HOST</code></td>
    <td>Your Databricks Workspace URL (without https://)</td>
  </tr>
  <tr>
    <td><code>DB_HTTP_PATH</code></td>
    <td>The HTTP path of your SQL Warehouse</td>
  </tr>
  <tr>
    <td><code>DB_TOKEN</code></td>
    <td>Personal Access Token (PAT)</td>
  </tr>
</table>

<h3>Initialization & Conflict Resolution</h3>
<p>Use these commands to sync your local repository with GitHub and handle common branch naming conflicts:</p>

<pre>
<code>
# Initialize and commit
git init -b main
git add .
git commit -m "feat: Initial production pipeline setup"

# Connect to remote
git remote add origin &lt;YOUR_GITHUB_REPO_URL&gt;

# Resolve "refspec/rejected" or branch mismatches
git pull origin main --rebase
git push -u origin main
</code>
</pre>

<hr>

<h2>SQL Verification Steps</h2>
<p>Verify the pipeline success directly in the <b>Databricks SQL Editor</b>:</p>

<pre>
<code>
-- Check the final business view
SELECT * FROM dbt_project_catalog.gold.gold_sales__monthly
ORDER BY report_month DESC;
</code>
</pre>

<hr>

<h2>Key Features Included</h2>
<ul>
    <li><b>Macros:</b> <code>get_custom_schema.sql</code> ensures clean schema naming in Unity Catalog.</li>
    <li><b>Security:</b> Profiles are never committed; they are generated during runtime.</li>
    <li><b>Scalability:</b> Modular dbt structure allows for easy addition of new data sources.</li>
</ul>

<br>
<p align="right"><i>Developed for Portfolio Demonstration - 2026</i></p>