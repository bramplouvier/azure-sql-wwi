-- Note this procedure is not included in the regular build, it
-- is called during the post deployment process.
-- This is due to the fact it updates temporal tables, and SSDT
-- will throw up an error when this occurs, despite the fact we
-- have procedures to deactivate the temporal tables and reactivate
-- when done.
DROP PROCEDURE IF EXISTS DataLoadSimulation.RecordColdRoomTemperatures;
GO


CREATE PROCEDURE [DataLoadSimulation].[RecordColdRoomTemperatures]
    @AverageSecondsBetweenReadings int,
    @NumberOfSensors int,
    @CurrentDateTime datetime2(7),
    @EndOfTime datetime2(7),
    @IsSilentMode bit
WITH EXECUTE AS OWNER
AS
BEGIN

    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF @IsSilentMode = 0
    BEGIN
        PRINT N'Recording cold room temperatures NTT Optimised';
    END;
        
    DROP TABLE IF EXISTS #RandomTable
    DROP TABLE IF EXISTS #sensors
    DROP TABLE IF EXISTS #RandomTimes

    DECLARE @StartDate DATE = CAST(@CurrentDateTime AS DATE)

    -- Get random number between 10k-20k
    DECLARE @NumberofRows BIGINT =  FLOOR((24 * 3600) / @AverageSecondsBetweenReadings) + 1;

    -- Generate a table with that many rows
    WITH Numbers(Id)
    AS (SELECT ROW_NUMBER() OVER(
            ORDER BY N1.N)
        FROM   (VALUES(1), (1), (1), (1), (1), (1), (1), (1), (1), (1)) AS N1(N)          -- 10
            CROSS JOIN(VALUES(1), (1), (1), (1), (1), (1), (1), (1), (1), (1)) AS N2(N)-- 100  
            CROSS JOIN (VALUES (1),(1),(1),(1),(1),(1),(1),(1),(1),(1)) AS N3 (N)   -- 1,000
            CROSS JOIN (VALUES (1),(1),(1),(1),(1),(1),(1),(1),(1),(1)) AS N4 (N)   -- 10,000
            CROSS JOIN (VALUES (1),(1),(1),(1),(1),(1),(1),(1),(1),(1)) AS N5 (N) -- 100,000
            -- Etc....
    )
    SELECT Id
    INTO #RandomTable
    FROM Numbers
    WHERE Id <= @NumberOfSensors;

    WITH Numbers(Id)
    AS (SELECT ROW_NUMBER() OVER(
            ORDER BY N1.N)
        FROM   (VALUES(1), (1), (1), (1), (1), (1), (1), (1), (1), (1)) AS N1(N)          -- 10
            CROSS JOIN(VALUES(1), (1), (1), (1), (1), (1), (1), (1), (1), (1)) AS N2(N)-- 100  
            CROSS JOIN (VALUES (1),(1),(1),(1),(1),(1),(1),(1),(1),(1)) AS N3 (N)   -- 1,000
            CROSS JOIN (VALUES (1),(1),(1),(1),(1),(1),(1),(1),(1),(1)) AS N4 (N)   -- 10,000
            CROSS JOIN (VALUES (1),(1),(1),(1),(1),(1),(1),(1),(1),(1)) AS N5 (N) -- 100,000
            -- Etc....
    )
    SELECT Id AS SensorId
    INTO #sensors
    FROM Numbers
    WHERE Id <= @NumberofRows;
    

    -- Generate a random list of times and add them to the date
    ;WITH RandomTimes AS 
    (
        SELECT RT.RandomTime,
            CONVERT(SMALLDATETIME, CONVERT(DATE, @StartDate)) + CONVERT(DATETIME, RT.RandomTime) AS DateObject
        FROM #RandomTable x
            CROSS APPLY(SELECT FromTime = '00:00:00', ToTime = '23:59:59') FT
            CROSS APPLY(SELECT MaxSeconds = DATEDIFF(ss, FT.FromTime, FT.ToTime)) MS
            CROSS APPLY(SELECT RandomTime = CONVERT(TIME, DATEADD(SECOND, (MS.MaxSeconds + 1) * RAND(CONVERT(VARBINARY, NEWID() )) , FT.FromTime))) RT
    )
    SELECT  RandomTime ,
            DateObject ,
            LEAD(DateObject, 1, 0) OVER (ORDER BY DateObject) AS NextDateObject
    INTO #RandomTimes
    FROM RandomTimes 
    ORDER BY RandomTime

    -- Cross join with the sensors
    SELECT  sensorId AS ColdRoomSensorNumber ,
            DateObject AS RecordedWhen ,
            CAST(3+ 5 * RAND(convert(varbinary, newid())) AS DECIMAL (6,2)) AS Temperature ,
            DateObject AS ValidFrom ,
            CASE WHEN NextDateObject = '1900-01-01 00:00:00.000' THEN @EndOfTime ELSE NextDateObject END AS ValidTo
    INTO #ColdRoomArchive
    FROM #RandomTimes 
        CROSS JOIN #sensors
    ORDER BY DateObject, sensorId

    DECLARE @FromDate DATETIME = (SELECT MIN(validFrom) FROM #ColdRoomArchive)

    -- Insert the previous records into the archive
    INSERT INTO Warehouse.ColdRoomTemperatures_Archive (ColdRoomTemperatureID, ColdRoomSensorNumber, RecordedWhen, Temperature, ValidFrom, ValidTo)
    SELECT ColdRoomTemperatureID, ColdRoomSensorNumber, RecordedWhen, Temperature, ValidFrom, @FromDate
    FROM Warehouse.ColdRoomTemperatures

    -- Clear it out (dont truncate as we need the Ids)
    DELETE FROM Warehouse.ColdRoomTemperatures

    -- Insert full recordset into the main
    INSERT INTO Warehouse.ColdRoomTemperatures (ColdRoomSensorNumber, RecordedWhen, Temperature, ValidFrom, ValidTo)
    SELECT ColdRoomSensorNumber, RecordedWhen, Temperature, ValidFrom, ValidTo
    FROM #ColdRoomArchive

    -- Archive all records which dont have exp as normal
    INSERT INTO Warehouse.ColdRoomTemperatures_Archive (ColdRoomTemperatureID, ColdRoomSensorNumber, RecordedWhen, Temperature, ValidFrom, ValidTo)
    SELECT ColdRoomTemperatureID, ColdRoomSensorNumber, RecordedWhen, Temperature, ValidFrom, ValidTo
    FROM Warehouse.ColdRoomTemperatures
    WHERE ValidTo <> @EndOfTime

    -- Delete all that we just inserted
    DELETE FROM Warehouse.ColdRoomTemperatures 
    WHERE ValidTo <> @EndOfTime
END