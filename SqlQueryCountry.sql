Create PROCEDURE addData
(@CountryName NVARCHAR(50),
@CityName NVARCHAR(50),
@DistrictName NVARCHAR(50),
@TownName NVARCHAR(50)
)
AS
BEGIN
--check country
declare @CountryId int
if exists(select [CountryName] from Country where [CountryName]=@CountryName)
    Begin 
    print  'Name ' +  @CountryName +'Already exists'
    END
ELSE
    BEGIN
    INSERT INTO Country(CountryName)
    values(@CountryName)
    PRINT @CountryName + ' inserted'
    END
Select @CountryId=Id From Country where [CountryName]=@CountryName
--check city

declare @CityId int
Select @CityId=Id  From City where [CityName]=@CityName
IF  EXISTS(select [CityName] from dbo.City where [CityName]=@CityName and CountryId=@CountryId)
    begin
    print 'this city exists'
    end
ELSE
    BEGIN
    INSERT INTO dbo.City
    values(@CityName,@CountryId,'code1')
    print 'Added city to db'
    END
declare @DistrictId int
Select @DistrictId=Id From District where [DistrictName]=@DistrictName and @CountryId=@CountryId and @CityId=@CityId

IF  EXISTS(select [TownName] from dbo.Town where [TownName]=@TownName and CountryId=@CountryId and CityId=@CityId and DistrictId=@DistrictId)
    begin
    print @TownName + 'town name exists'
    end
ELSE
    BEGIN
    INSERT INTO dbo.Town
    values(@TownName,@CountryId,@CityId,@DistrictId,'code')
    print 'Created town named ' + @TownName
    END


END
GO
exec addData @CountryName='Turkey',@CityName='Trabzon',@DistrictName='street',@TownName='ilce'