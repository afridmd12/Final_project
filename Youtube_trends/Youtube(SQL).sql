
-- Create the Table
CREATE TABLE youtube_data (
    video_id TEXT,
    trending_date TEXT,
    title TEXT,
    channel_title TEXT,
    category_id INTEGER,
    publish_date TEXT,
    time_frame TEXT,
    published_day_of_week TEXT,
    publish_country TEXT,
    tags TEXT,
    views INTEGER,
    likes INTEGER,
    dislikes INTEGER,
    comment_count INTEGER,
    comments_disabled BOOLEAN,
    ratings_disabled BOOLEAN,
    video_error_or_removed BOOLEAN
);

-- Total Records:
SELECT COUNT(*) FROM youtube_data;


-- Total Views by Country
SELECT publish_country, SUM(views) AS total_views
FROM youtube_data
GROUP BY publish_country
ORDER BY total_views DESC;


-- Top 10 Most Viewed Videos
SELECT title, channel_title, views
FROM youtube_data
ORDER BY views DESC
LIMIT 10;


--  Average Likes per Category
SELECT category_id, AVG(likes) AS avg_likes
FROM youtube_data
GROUP BY category_id
ORDER BY avg_likes DESC;


-- Number of Videos Published Each Day of the Week
SELECT published_day_of_week, COUNT(*) AS total_videos
FROM youtube_data
GROUP BY published_day_of_week
ORDER BY total_videos DESC;


-- Like to View Ratio by Channel
SELECT channel_title,
       SUM(likes) * 1.0 / NULLIF(SUM(views), 0) AS like_view_ratio
FROM youtube_data
GROUP BY channel_title
ORDER BY like_view_ratio DESC
LIMIT 10;

-- Channels with Most Trending Videos
SELECT channel_title, COUNT(*) AS trending_videos
FROM youtube_data
GROUP BY channel_title
ORDER BY trending_videos DESC
LIMIT 10;


-- Count of Videos by Category
SELECT category_id, COUNT(*) AS video_count
FROM youtube_data
GROUP BY category_id
ORDER BY video_count DESC;


--  Average Comments per Country
SELECT publish_country, AVG(comment_count) AS avg_comments
FROM youtube_data
GROUP BY publish_country
ORDER BY avg_comments DESC;

--  Number of Videos with Comments Disabled
SELECT COUNT(*) AS disabled_comments_videos
FROM youtube_data
WHERE comments_disabled = TRUE;


-- Percentage of Videos with Ratings Disabled
SELECT 
  ROUND(100.0 * SUM(CASE WHEN ratings_disabled = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS percentage_ratings_disabled
FROM youtube_data;


-- Videos Removed or with Errors
SELECT COUNT(*) AS removed_or_error_videos
FROM youtube_data
WHERE video_error_or_removed = TRUE;


-- Day with Highest Number of Video Publications
SELECT published_day_of_week, COUNT(*) AS total_videos
FROM youtube_data
GROUP BY published_day_of_week
ORDER BY total_videos DESC
LIMIT 1;

-- Most Popular Time Frame for Publishing
SELECT time_frame, COUNT(*) AS video_count
FROM youtube_data
GROUP BY time_frame
ORDER BY video_count DESC;



