ALTER FUNCTION CheckAge(@age int, @date DATE)
RETURNS NVARCHAR(max)
AS
BEGIN
DECLARE @TodayDate Date = GETDATE();
DECLARE @Formatted NVARCHAR(max)
DECLARE @month NVARCHAR(10)
DECLARE @subtract NVARCHAR(10)
DECLARE @difference int = DATEDIFF(day, @date, @TodayDate)


IF @difference > @age * 365
    IF (@difference - @age *365) > 30 
        BEGIN
        SET @month = CAST(((@difference - @age * 365) / 30) AS NVARCHAR(10))
        SET @subtract = CAST(((@difference - @age *365) - (@month * 30))  AS NVARCHAR(10))
        SET @Formatted = N'Age is more by ' + @month + N' month '+ @subtract + N' days'
        END
    ELSE
        SET @Formatted = N'Age is more by ' +  CAST((@difference - @age *365) AS NVARCHAR(10)) + N'days'

ELSE IF @difference < @age * 365
    IF (@age *365 - @difference) > 30 
        BEGIN
        SET @month = CAST(((@age *365 - @difference) / 30) AS NVARCHAR(2))
        SET @subtract = CAST(((@age *365 - @difference) - (@month * 30))  AS NVARCHAR(2))
        SET @Formatted = N'Age is less by ' + @month + N'month'+ @subtract + N'days'
        END
    ELSE
        SET @Formatted = N'Age is less by '+ CAST((@age *365 - @difference) AS NVARCHAR(5))+N'days'

ELSE IF @difference =  @age * 365
    SET @Formatted = 'Age is equal'

RETURN @Formatted
END
GO

