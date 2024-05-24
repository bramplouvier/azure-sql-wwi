CREATE PROCEDURE [DataLoadSimulation].[PopulateDataTo180DaysAgo]
@AverageNumberOfCustomerOrdersPerDay int = 30,
@SaturdayPercentageOfNormalWorkDay int = 25,
@SundayPercentageOfNormalWorkDay int = 0,
@IsSilentMode bit = 0,
@AreDatesPrinted bit = 1
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CurrentMaximumDate date = COALESCE((SELECT MAX(CAST(ValidFrom AS DATE)) FROM [Warehouse].[ColdRoomTemperatures]), '20200101');
    DECLARE @StartingDate date = DATEADD(day, 1, @CurrentMaximumDate);
    DECLARE @EndingDate date = CAST(DATEADD(day, -1, SYSDATETIME()) AS date);

    EXEC DataLoadSimulation.DailyProcessToCreateHistory
        @StartDate = @StartingDate,
        @EndDate = @EndingDate,
        @AverageNumberOfCustomerOrdersPerDay = @AverageNumberOfCustomerOrdersPerDay,
        @SaturdayPercentageOfNormalWorkDay = @SaturdayPercentageOfNormalWorkDay,
        @SundayPercentageOfNormalWorkDay = @SundayPercentageOfNormalWorkDay,
        @UpdateCustomFields = 0, -- they were done in the initial load
        @IsSilentMode = @IsSilentMode,
        @AreDatesPrinted = @AreDatesPrinted;

END;
