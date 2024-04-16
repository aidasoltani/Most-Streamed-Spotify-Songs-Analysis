

--------------------------------------- *** First KPI ***----------------------------------------------------------------

--Audio Feature Analysis

-- Calculating the average values of audio features for the Top 50 Spotify songs
-- These values could be used to help an artist to create a song that has a higher chance of being featured in the Top 50 Spotify songs in the future

SELECT AVG([energy_%]) AS average_energy,
       AVG([danceability_%]) AS average_danceability,
       AVG([acousticness_%]) AS average_acousticness,
       AVG([speechiness_%]) AS average_speechiness
FROM (
    SELECT TOP 50 [energy_%], [danceability_%], [acousticness_%], [speechiness_%]
    FROM [spotify-2023]
    ORDER BY streams DESC
    
) AS top_50_songs;


-- top 50 tracks by streams
SELECT TOP 10 track_name, streams
FROM [spotify-2023]
ORDER BY streams DESC

-- audio features of the most popular song

SELECT track_name, [energy_%], [danceability_%], [acousticness_%], [speechiness_%]
FROM [spotify-2023]
WHERE track_name = 'Blinding Lights'


--------------------------------------- *** Second KPI *** ------------------------------------------------------------------

--Artists collaboration Impact

SELECT artist_count, AVG(streams) AS Average_stream
FROM [spotify-2023]
GROUP BY artist_count
ORDER BY artist_count

--Frequency of artist_count
SELECT artist_count, COUNT(*) AS NumberOfArtist
FROM [spotify-2023]
GROUP BY artist_count
ORDER BY artist_count ASC;

-- top 50 artist popularity
SELECT Top 50 [artist(s)_name], SUM(streams) AS total_streams
FROM [spotify-2023]
WHERE artist_count = 1
GROUP BY [artist(s)_name]
Order BY total_streams DESC


-- check the popularity of a song by artist collaboration
SELECT track_name, [artist(s)_name], streams
FROM [spotify-2023]
WHERE artist_count >= 2 and [artist(s)_name] like '%Khalid%'
Order by streams DESC



--------------------------------------- *** Third KPI **----------------------------------------------------------------------------

--Cross platform playlist impact

-- Analyze how popularity is being transfer from platform to platform


--Songs popularity by presence in different platform playlists
SELECT streams, in_spotify_playlists,in_apple_playlists,in_deezer_playlists,(ISNULL(in_spotify_playlists, 0)+ISNULL(in_apple_playlists, 0)+ ISNULL(in_deezer_charts, 0)+ISNULL(in_deezer_playlists, 0)) AS total_playlists
FROM [spotify-2023]
ORDER BY streams DESC


-- TOP 10 non-popular tracks on different platform  playlist 
SELECT  TOP 10 track_name,[artist(s)_name],in_spotify_playlists,in_apple_playlists,in_deezer_playlists,streams
FROM [spotify-2023]
WHERE streams IS NOT NULL
ORDER BY streams ASC


-- the most popular artist songs

SELECT track_name,[artist(s)_name],in_spotify_playlists,in_apple_playlists,in_deezer_playlists, streams
FROM [spotify-2023]
WHERE [artist(s)_name]='The Weeknd'
ORDER BY streams DESC





