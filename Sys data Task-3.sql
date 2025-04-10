USE sys;
-- Top 10 statements by execution count
SELECT * FROM statement_analysis
ORDER BY exec_count DESC
LIMIT 10;

-- List host summary info for a specific user
SELECT * FROM host_summary
WHERE user = 'root';

-- Join host summary and statement analysis by user
SELECT hs.user, sa.avg_latency, sa.query
FROM host_summary hs
JOIN statement_analysis sa ON hs.user = sa.user
LIMIT 10;

-- Hosts with above-average total connections
SELECT host, total_connections
FROM host_summary
WHERE total_connections > (
    SELECT AVG(total_connections) FROM host_summary
);

-- Average latency by user
SELECT user, AVG(avg_latency) AS avg_user_latency
FROM statement_analysis
GROUP BY user;

-- Create a view showing high-latency queries
CREATE VIEW high_latency_queries AS
SELECT *
FROM statement_analysis
WHERE avg_latency > 1000000;

-- Show top 5 slow queries
SELECT query, avg_latency
FROM statement_analysis
ORDER BY avg_latency DESC
LIMIT 5;

