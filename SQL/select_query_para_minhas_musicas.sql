SELECT
  id,
  filename,
  (heard + (partial * 0.4) - (skipped * 0.8)) / appearances AS score
FROM songs
WHERE appearances > 0
ORDER BY score DESC;
