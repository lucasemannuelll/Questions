SELECT
    id,
    filename,
    appearances,
    heard,
    partial,
    skipped,

    ROUND(CAST(heard AS REAL) / appearances * 100, 1) AS heard_pct,
    ROUND(CAST(skipped AS REAL) / appearances * 100, 1) AS skipped_pct,
    ROUND(total_sec / 60.0, 1) AS total_minutes,

    DATETIME(last_played, 'unixepoch', 'localtime') AS last_played_human,
    
    ROUND((heard + (partial * 0.45) - (skipped * 0.90)) / appearances, 3) AS score,

    CASE
        WHEN appearances < 3 THEN 'low data'
        WHEN (heard + partial * 0.45 - skipped * 0.90) / appearances >= 0.75 THEN 'favorite'
        WHEN (heard + partial * 0.45 - skipped * 0.90) / appearances >= 0.35 THEN 'liked'
        WHEN (heard + partial * 0.45 - skipped * 0.90) / appearances >= 0.00 THEN 'neutral'
        ELSE 'avoid'
    END AS verdict

FROM songs
WHERE appearances >= 3
ORDER BY score DESC, heard DESC, total_sec DESC;
