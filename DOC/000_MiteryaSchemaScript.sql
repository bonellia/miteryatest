--MiteryaScriptTestDb adi ile olusturulmus db uzerinde islem yapar


USE [master]
GO
ALTER DATABASE [MiteryaScriptTestDb] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MiteryaTestDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MiteryaScriptTestDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET  MULTI_USER 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MiteryaScriptTestDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MiteryaScriptTestDb] SET QUERY_STORE = OFF
GO
USE [MiteryaScriptTestDb]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
/****** Object:  UserDefinedFunction [dbo].[FNDereceGetir]    Script Date: 14.11.2019 09:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[FNDereceGetir]
(@Score int)
returns varchar
as
   begin
      declare @derece varchar(2)
       set @derece=(
       case when @score<50 THEN 'E'
       when @score between 50 and 59 then 'D'
       when @score between 60 and 69 then 'C'
       when @score between 70 and 84 then 'B'
       when @score>84 then 'A'
       end)
        
        RETURN (@derece)
   end
GO
/****** Object:  UserDefinedFunction [dbo].[GetMeritLevel]    Script Date: 14.11.2019 09:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[GetMeritLevel] (@score int,@Level int,@isNatural int)
RETURNS int
AS BEGIN
    DECLARE @retValue int

	SET @retValue =
	case when @Level<=4 or @Level=13/*Okul Öncesi, ilkokul veya level önemli değil.*/
	then
		(case when @score<=20 or @score is null  then 5
		when @score>20 and @score <=40 then 4
		when @score>40 and @score <=60 then 3
		when @score>60 and @score <=80 then 2
		when @score>80  then 1
		else 0 end)
	when @Level between 5 and 8 and @isNatural <> 2
	--if (@Level between 5 and 8 and @isNatural !=2) /*Orta Okul Doğal ve edinsel kriterler için scorelevel döner (3 kademeli)*/ 
	then 
		(case when @score<=33 or @score is null  then 3
		when @score>33 and @score <=66 then 2
		when @score>66 then 1
		else 0 end)
		when @Level between 5 and 8 and @isNatural =2
		--if (@Level between 5 and 8 and @isNatural =2) /*Orta Okul Evrensel kriterler için scorelevel döner (5 Kademeli)*/ 
	then
		(case when @score<=20 or @score is null  then 5
		when @score>20 and @score <=40 then 4
		when @score>40 and @score <=60 then 3
		when @score>60 and @score <=80 then 2
		when @score>80  then 1
		else 0 end)
	when @Level between 9 and 12 and @isNatural =1
	--if (@Level between 5 and 8 and @isNatural !=2) /*Lise Doğal kriterler için scorelevel döner (4 kademeli)*/ 
	then
	(case when @score<=25 or @score is null  then 4
		when @score>25 and @score <=50 then 4
		when @score>50 and @score <=75 then 3
		when @score>75  then 1
		else 0 end)
	when @Level between 9 and 12 and @isNatural =0
	--if (@Level between 5 and 8 and @isNatural =2) /*Lise edinsel kriterler kriterler için scorelevel döner (3 Kademeli)*/ 
	then 
	(case when @score<=33 or @score is null  then 3
		when @score>33 and @score <=66 then 2
		when @score>66 then 1
		else 0 end)
		when @Level between 9 and 12 and @isNatural =2
	--if (@Level between 5 and 8 and @isNatural =2) /*Lise Evrensel kriterler kriterler için scorelevel döner (5 Kademeli)*/ 
	then 
	(case when @score<=20 or @score is null  then 5
		when @score>20 and @score <=40 then 4
		when @score>40 and @score <=60 then 3
		when @score>60 and @score <=80 then 2
		when @score>80  then 1
		else 0 end)
	else 0 end



    RETURN @retValue


END
GO
/****** Object:  UserDefinedFunction [dbo].[GetNormStatu]    Script Date: 14.11.2019 09:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[GetNormStatu] 
(@Score int , @Norm int)
RETURNS int
AS
BEGIN
  declare @ScoreDegree int 
  declare @NormDegree int 
  declare @Diff int 
  declare @NormStatu int 

  set @ScoreDegree=(
       case when @Score<30 THEN 8
       when @Score between 30 and 39 then 7
       when @Score between 40 and 49 then 6
       when @Score between 50 and 59 then 5
	   when @Score between 60 and 69 then 4
	   when @Score between 70 and 79 then 3
	   when @Score between 80 and 89 then 2
       when @Score>=90 then 1
       end)

 set @NormDegree=(
       case when @Norm<30 THEN 8
       when @Norm between 30 and 39 then 7
       when @Norm between 40 and 49 then 6
       when @Norm between 50 and 59 then 5
	   when @Norm between 60 and 69 then 4
	   when @Norm between 70 and 79 then 3
	   when @Norm between 80 and 89 then 2
       when @Norm>=90 then 1
       end)
set @Diff=@NormDegree-@ScoreDegree

set @NormStatu=
(
case when @Diff>=2 then 1
when  @Diff=1 then 2
when  @Diff=0 then 3
when  @Diff=-1 then 4
when  @Diff<=-2 then 5 
end
)
return @NormStatu;

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetScoreDegree]    Script Date: 14.11.2019 09:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[GetScoreDegree]
(@Score int)
returns varchar
as
   begin
      declare @derece varchar(2)
       set @derece=(
       case when @score<50 THEN 'E'
       when @score between 50 and 59 then 'D'
       when @score between 60 and 69 then 'C'
       when @score between 70 and 84 then 'B'
       when @score>84 then 'A'
       end)
        
        RETURN (@derece)
   end;
GO
/****** Object:  UserDefinedFunction [dbo].[GetScoreLevel]    Script Date: 14.11.2019 09:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[GetScoreLevel] (@score int)
RETURNS int
AS BEGIN
    DECLARE @retValue int

    SET @retValue =(
	case when @score<50 or @score is null  then 1
	when @score>=50 and @score <65 then 2
	when @score>=65 and @score <75 then 3
	when @score>=75 and @score <90 then 4
	when @score>=90  then 5
	else 0 end)

    RETURN @retValue


END
GO
/****** Object:  UserDefinedFunction [dbo].[GetScoreLevelReverse]    Script Date: 14.11.2019 09:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* Score Levelleri tersten getirir en yüksek not 1 en düşük 5*/
CREATE FUNCTION [dbo].[GetScoreLevelReverse] (@score int)
RETURNS int
AS BEGIN
    DECLARE @retValue int

    SET @retValue =(
	case when @score<50 or @score is null  then 5
	when @score>=50 and @score <65 then 4
	when @score>=65 and @score <75 then 3
	when @score>=75 and @score <90 then 2
	when @score>=90  then 1
	else 0 end)

    RETURN @retValue


END
GO
/****** Object:  UserDefinedFunction [dbo].[GetSkillDegree]    Script Date: 14.11.2019 09:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE function [dbo].[GetSkillDegree]
(@Score_ int,@Lang varchar(10))
returns varchar(30)
as
   begin
      declare @degree varchar(30)
	  declare @score int=@Score_* 1.5
	  set @degree= (case when @Lang='tr' then
       (case when @score IS NULL or @score=0 THEN 'Desteklenmesi Gereken'
	   when @score<85 THEN 'Desteklenmesi Gereken'
       when @score between 85 and 99 then 'Alt Normal'
	   when @score between 100 and 114 then 'Normal'
       when @score between 115 and 129 then 'Gelişkin'
       when @score>=130 then 'Çok Gelişkin'
       end)
	   when @Lang='us' then (
	   case when @score IS NULL or @score=0 THEN 'To be supported'
	   when @score<85 THEN 'To be supported'
       when @score between 85 and 99 then 'Subnormal'
	   when @score between 100 and 114 then 'Normal'
       when @score between 115 and 129 then 'Advanced'
       when @score>=130 then 'Very Advanced'
       end
	   ) end
	   )
        RETURN (@degree)
   end;

GO
/****** Object:  UserDefinedFunction [dbo].[GetSkillLevel]    Script Date: 14.11.2019 09:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



Create FUNCTION [dbo].[GetSkillLevel] (@score_ int)
RETURNS int
AS BEGIN
    DECLARE @retValue int
	declare @score int=@Score_* 1.5
    SET @retValue =(
	case when @score=0 or @score is null or @score<70  then 1
	 WHEN @score >= 70 AND @score< 85 THEN 2
	 WHEN @score >= 85 AND @score< 100 THEN 3
     WHEN @score >= 100 AND @score < 115 THEN 4
	 WHEN @score >= 115 AND @score < 120 THEN 5
     WHEN @score >= 120 AND @score < 130 THEN 6
	 WHEN @score >= 130 AND @score < 140 THEN 7
     WHEN @score >= 140 THEN 8 end)

    RETURN @retValue

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetSkillNormalizeLevel]    Script Date: 14.11.2019 09:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Halil,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetSkillNormalizeLevel]
(
@Score int
)
RETURNS int
AS
BEGIN
DECLARE @RetVal int
    

    
	SET @RetVal = (
		CASE WHEN @Score IS NULL OR @Score = 0 THEN 1
			 WHEN @Score < 85 THEN 1
			 WHEN @Score >= 85 AND @Score < 100 THEN 2
             WHEN @Score >= 100 AND @Score < 115 THEN 3
			 WHEN @Score >= 115 AND @Score < 130 THEN 4
             WHEN @Score >= 130 then 5
		END
	);

	RETURN @RetVal;

END
GO
/****** Object:  Table [dbo].[DfnSurveyCriterias]    Script Date: 14.11.2019 09:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnSurveyCriterias](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SurveyCriteriaName] [nvarchar](max) NULL,
	[SurveyCriteriaName_US] [nvarchar](max) NULL,
	[CriteriaGroupId] [int] NULL,
	[SurveyCriteriaDescription] [nvarchar](max) NULL,
	[SurveyCriteriaDescription_US] [nvarchar](max) NULL,
	[CriteriaNickname] [nvarchar](max) NULL,
	[CriteriaNickname_Us] [nvarchar](max) NULL,
 CONSTRAINT [PK_DfnSurveyCriterias] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SurveyCriteriaScores]    Script Date: 14.11.2019 09:30:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyCriteriaScores](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[SurveyResultId] [int] NOT NULL,
	[DfnSurveyCriteriaId] [int] NOT NULL,
	[Score] [int] NOT NULL,
	[IsExcessive] [tinyint] NOT NULL,
 CONSTRAINT [PK_SurveyCriteriaScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnCriteriaTemperamentSuggestions]    Script Date: 14.11.2019 09:30:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnCriteriaTemperamentSuggestions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemperamentId] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[ScoreLevel] [int] NOT NULL,
	[CategoryGroupId] [int] NOT NULL,
	[ClassId] [int] NOT NULL,
	[UniteId] [int] NULL,
	[Age] [int] NULL,
	[ContentType] [int] NOT NULL,
	[Content] [nvarchar](max) NULL,
	[Content_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_DfnCriteriaTemperamentSuggestions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnCriteriaReports]    Script Date: 14.11.2019 09:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnCriteriaReports](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemperamentId] [int] NULL,
	[CriteriaId] [int] NULL,
	[CriteriaGroupId] [int] NULL,
	[Content] [nvarchar](max) NULL,
	[Content_US] [nvarchar](max) NULL,
	[ContentType] [int] NOT NULL,
	[NormStatus] [tinyint] NULL,
	[ScoreLevel] [int] NULL,
	[Age] [int] NULL,
	[ClassNo] [int] NULL,
	[IsNatural] [int] NULL,
	[SchoolLevel] [int] NULL,
 CONSTRAINT [PK_DfnCriteriaReports] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnCriteriaTemperaments]    Script Date: 14.11.2019 09:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnCriteriaTemperaments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemperamentId] [int] NULL,
	[CriteriaId] [int] NOT NULL,
	[CriteriaGroupId] [int] NULL,
	[IsNatural] [int] NULL,
	[Age] [int] NULL,
	[ClassId] [int] NULL,
	[SchoolLevel] [int] NULL,
 CONSTRAINT [PK_DfnCriteriaTemperaments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserOrganizationRoles]    Script Date: 14.11.2019 09:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserOrganizationRoles](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[OrganizationId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[TermId] [uniqueidentifier] NOT NULL,
	[AccessClassroomIds] [nvarchar](max) NULL,
	[UserDashboardModuleUserDashboard] [uniqueidentifier] NULL,
 CONSTRAINT [PK_UserOrganizationRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 14.11.2019 09:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[NationalId] [bigint] NULL,
	[UserName] [nvarchar](150) NULL,
	[Password] [nvarchar](150) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Surname] [nvarchar](max) NULL,
	[Email] [nvarchar](100) NULL,
	[Picture] [nvarchar](max) NULL,
	[PositionID] [int] NULL,
	[PhoneNumber] [nvarchar](15) NULL,
	[Sex] [bit] NOT NULL,
	[BirthDate] [datetime2](7) NOT NULL,
	[TemperamentTypeId] [int] NULL,
	[ShowTemperament] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_UserName] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SurveyResults]    Script Date: 14.11.2019 09:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyResults](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserOrganizationRoleId] [uniqueidentifier] NOT NULL,
	[SolvedUserId] [uniqueidentifier] NOT NULL,
	[SurveyId] [int] NOT NULL,
	[UserOrganizationRoleSolverUserId] [uniqueidentifier] NOT NULL,
	[SurveyContent] [nvarchar](max) NULL,
	[Result] [nvarchar](max) NULL,
	[SurveyState] [tinyint] NOT NULL,
	[TermId] [uniqueidentifier] NOT NULL,
	[SolvedUserAge] [int] NULL,
	[ClassId] [int] NULL,
	[SchoolLevel] [int] NULL,
	[SolverRoleId] [uniqueidentifier] NULL,
	[SolvedUserTemperamentId] [int] NOT NULL,
 CONSTRAINT [PK_SurveyResults] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VMeritCriteriaScore]    Script Date: 14.11.2019 09:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VMeritCriteriaScore]
AS

SELECT zz.*,
crpt.Content,crpt.Content_US, dbo.FNDereceGetir(zz.Score) as Derece,sss.Content as Suggestion,sss.Content_US as Suggestion_US
FROM (
    SELECT
    ss.SurveyId,
    ss.SolvedUserId,
    ss.SolvedUserTemperamentId,
    ss.TermId,
    ss.SolvedUserAge,
    ss.classNo,
    ss.IsNatural,
    ss.SurveyCriteriaName,
	ss.SurveyCriteriaName_US,
	ss.SurveyCriteriaDescription_US,
    ss.SurveyCriteriaDescription,
    ss.DfnSurveyCriteriaId,
    CAST(ss.Score as integer )as Score,
	[dbo].[GetScoreLevelReverse](ss.Score) as ScoreLevel
    FROM
            (SELECT
            SurveyId,
            SolvedUserId,
            SolvedUserTemperamentId,
            TermId,
            SolvedUserAge,
            classNo,
            IsNatural,
			SurveyCriteriaName_US,
			SurveyCriteriaDescription_US,
            SurveyCriteriaName,
            SurveyCriteriaDescription,
            DfnSurveyCriteriaId,
            CASE WHEN teacher =0 and leaderTeacher=0 THEN NULL /*Öğretmen çözmemiş ise tüm seviyelerde null*/
            WHEN student >0 AND parent >0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.4 + parent * 0.3 + teacher * 0.15 + leaderTeacher*0.15, 0)
			WHEN student >0 AND parent >0 AND teacher >0 and leaderTeacher=0 THEN ROUND(student * 0.4 + parent * 0.3 + teacher * 0.3, 0)
			WHEN student >0 AND parent >0 AND teacher =0 and leaderTeacher>0 THEN ROUND(student * 0.4 + parent * 0.3 + leaderTeacher * 0.3, 0)

			WHEN student >0 AND parent =0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.6 + teacher * 0.2 + leaderTeacher*0.2, 0)
			WHEN student >0 AND parent =0 AND teacher >0 and leaderTeacher=0 THEN ROUND(student * 0.6 + teacher * 0.4, 0)
			WHEN student >0 AND parent =0 AND teacher =0 and leaderTeacher>0 THEN ROUND(student * 0.6 + leaderTeacher * 0.4, 0)

			WHEN student =0 and parent =0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.5 + teacher * 0.5, 0)
			WHEN student =0 and parent =0 AND teacher >0 and leaderTeacher=0 THEN teacher
			WHEN student =0 and parent =0 AND teacher =0 and leaderTeacher>0 THEN leaderTeacher

			WHEN student =0 and parent >0 AND teacher >0 and leaderTeacher>0 THEN ROUND(leaderTeacher * 0.25 + teacher * 0.25 + parent*0.5, 0)
			WHEN student =0 and parent >0 AND teacher >0 and leaderTeacher=0 THEN ROUND (teacher * 0.5 + parent*0.5, 0)
			WHEN student =0 and parent >0 AND teacher =0 and leaderTeacher>0 THEN ROUND (leaderTeacher * 0.5 + parent*0.5, 0)  END AS Score
            FROM
                (SELECT
                sr.SurveyId,
                sr.SolvedUserId,
                sr.SolvedUserTemperamentId,
                sr.TermId,
                sr.SolvedUserAge,
                ct.ClassId AS classNo,
                cr.SurveyCriteriaName,
				cr.SurveyCriteriaName_US,
				cr.SurveyCriteriaDescription_US,
                cr.SurveyCriteriaDescription,
                scs.DfnSurveyCriteriaId,
				sum(case when sr.SolverRoleId='DEB470C7-9827-4375-B20A-BEA56511EA49' then scs.Score else 0 end) as student,
				avg(case when sr.SolverRoleId='13676A48-FC7A-4694-82B2-CF0EE8F06313' then scs.Score else 0 end) as parent,  
				sum(case when sr.SolverRoleId='46A1C2F2-AA44-41EF-A746-59AC5EC09DCE' then scs.Score else 0 end) as teacher, 
				sum(case when sr.SolverRoleId='574D2187-D602-4188-A63C-C2B9DC5133DF' then scs.Score else 0 end) as leaderTeacher,
			    ct.IsNatural
                FROM
                dbo.SurveyResults AS sr
                INNER JOIN dbo.SurveyCriteriaScores AS scs ON sr.Id = scs.SurveyResultId
                INNER JOIN dbo.DfnSurveyCriterias AS cr ON scs.DfnSurveyCriteriaId = cr.Id
                INNER JOIN dbo.DfnCriteriaTemperaments  AS ct ON scs.DfnSurveyCriteriaId = ct.CriteriaId 
				AND	sr.SolvedUserTemperamentId = ct.TemperamentId AND  ct.ClassId= sr.ClassId
                INNER JOIN dbo.UserOrganizationRoles AS uor ON sr.UserOrganizationRoleSolverUserId = uor.Id
				left join Users u on uor.UserId = u.Id and sr.SolvedUserTemperamentId = u.TemperamentTypeId
                where sr.SurveyState=3 and sr.SurveyId=7 and sr.IsActive=1 
				group by
				sr.SurveyId,
                sr.SolvedUserId,
                sr.SolvedUserTemperamentId,
                sr.TermId,
                sr.SolvedUserAge,
                ct.ClassId,
                cr.SurveyCriteriaName,
                cr.SurveyCriteriaDescription,
                scs.DfnSurveyCriteriaId,
				ct.IsNatural,
				cr.SurveyCriteriaName_US,
				cr.SurveyCriteriaDescription_US
				) AS sub
                group by
                sub.SurveyId,
                sub.SolvedUserId,
                sub.SolvedUserTemperamentId,
                sub.TermId,
                sub.SolvedUserAge,
                sub.classNo,
                sub.IsNatural,
                sub.SurveyCriteriaName,
                sub.SurveyCriteriaDescription,
                sub.DfnSurveyCriteriaId,
                sub.parent,
                sub.teacher,
				student,
				leaderTeacher,
				SurveyCriteriaName_US,
				SurveyCriteriaDescription_US
    ) AS ss
    )
    ZZ
    left JOIN dbo.DfnCriteriaReports AS crpt ON ZZ.DfnSurveyCriteriaId = crpt.CriteriaId  and ZZ.SolvedUserTemperamentId=crpt.TemperamentId
	AND ZZ.IsNatural = crpt.IsNatural and ZZ.classNo=crpt.ClassNo 	AND crpt.ScoreLevel = dbo.GetMeritLevel(ZZ.Score,ZZ.classNo,ZZ.IsNatural)
	LEFT JOIN [dbo].[DfnCriteriaTemperamentSuggestions] sss on ZZ.SolvedUserTemperamentId=sss.TemperamentId and ZZ.DfnSurveyCriteriaId=sss.criteriaId
	and ZZ.classNo=sss.classID and  sss.ScoreLevel = dbo.GetMeritLevel(ZZ.Score,ZZ.classNo,ZZ.IsNatural)

GO
/****** Object:  View [dbo].[VMeritUsersCriteriaScore]    Script Date: 14.11.2019 09:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[VMeritUsersCriteriaScore]
AS

SELECT
                sr.SurveyId,
                sr.SolvedUserId,
                sr.SolvedUserTemperamentId,
                sr.TermId,
				sr.SurveyState,
                cr.SurveyCriteriaName,
				cr.SurveyCriteriaName_US,
				case when sr.SchoolLevel is not null then sr.SchoolLevel else 0 end SchoolLevel,
                scs.DfnSurveyCriteriaId,
				sum(case when sr.SolverRoleId='DEB470C7-9827-4375-B20A-BEA56511EA49' then scs.Score else 0 end) as student,
				sum(case when sr.SolverRoleId='13676A48-FC7A-4694-82B2-CF0EE8F06313' then scs.Score else 0 end) as parent,  
				sum(case when sr.SolverRoleId='46A1C2F2-AA44-41EF-A746-59AC5EC09DCE' then scs.Score else 0 end) as teacher, 
				sum(case when sr.SolverRoleId='574D2187-D602-4188-A63C-C2B9DC5133DF' then scs.Score else 0 end) as leaderTeacher
                FROM
                dbo.SurveyResults AS sr
                INNER JOIN dbo.SurveyCriteriaScores AS scs ON sr.Id = scs.SurveyResultId
                INNER JOIN dbo.DfnSurveyCriterias AS cr ON scs.DfnSurveyCriteriaId = cr.Id
                INNER JOIN dbo.DfnCriteriaTemperaments  AS ct ON scs.DfnSurveyCriteriaId = ct.CriteriaId 
				AND	sr.SolvedUserTemperamentId = ct.TemperamentId AND  ct.ClassId= sr.ClassId
                INNER JOIN dbo.UserOrganizationRoles AS uor ON sr.UserOrganizationRoleSolverUserId = uor.Id
				left join Users u on uor.UserId = u.Id and sr.SolvedUserTemperamentId = u.TemperamentTypeId
                where sr.SurveyState=3 and sr.SurveyId=7 and sr.IsActive=1
				group by
				sr.SurveyId,
                sr.SolvedUserId,
                sr.SolvedUserTemperamentId,
                sr.TermId,
                cr.SurveyCriteriaName,
                scs.DfnSurveyCriteriaId,
				cr.SurveyCriteriaName_US,
				sr.SurveyState,
				sr.SchoolLevel
GO
/****** Object:  Table [dbo].[DfnCriteriaNorms]    Script Date: 14.11.2019 09:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnCriteriaNorms](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemperamentId] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[NormScore] [int] NOT NULL,
	[Age] [int] NULL,
	[ClassId] [int] NULL,
	[SchoolLevel] [int] NULL,
 CONSTRAINT [PK_DfnCriteriaNorms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VMentalCriteriaScore]    Script Date: 14.11.2019 09:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[VMentalCriteriaScore]
AS
SELECT        
zz.DfnSurveyCriteriaId, 
zz.TermId, zz.SolvedUserId, 
zz.SolvedUserAge,
zz.SolvedUserTemperamentId, 
src.SurveyCriteriaName, 
src.SurveyCriteriaDescription, 
src.SurveyCriteriaName_US, 
src.SurveyCriteriaDescription_US,
zz.Score, 
cn.NormScore, 
crap.[Content], 
crap.Content_US, 
crap.ContentType, 
zz.SurveyId,
dbo.GetNormStatu(zz.Score, cn.NormScore) AS NormStatus
FROM            
(SELECT 
 DfnSurveyCriteriaId, 
 TermId, 
 SolvedUserId, 
 SolvedUserAge, 
 SolvedUserTemperamentId, 
 SurveyId,
CAST(
			CASE WHEN teacher =0 and leaderTeacher=0 THEN NULL /*Öğretmen çözmemiş ise tüm seviyelerde null*/
            WHEN student >0 AND parent >0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.4 + parent * 0.3 + teacher * 0.15 + leaderTeacher*0.15, 0)
			WHEN student >0 AND parent >0 AND teacher >0 and leaderTeacher=0 THEN ROUND(student * 0.4 + parent * 0.3 + teacher * 0.3, 0)
			WHEN student >0 AND parent >0 AND teacher =0 and leaderTeacher>0 THEN ROUND(student * 0.4 + parent * 0.3 + leaderTeacher * 0.3, 0)

			WHEN student >0 AND parent =0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.6 + teacher * 0.2 + leaderTeacher*0.2, 0)
			WHEN student >0 AND parent =0 AND teacher >0 and leaderTeacher=0 THEN ROUND(student * 0.6 + teacher * 0.4, 0)
			WHEN student >0 AND parent =0 AND teacher =0 and leaderTeacher>0 THEN ROUND(student * 0.6 + leaderTeacher * 0.4, 0)

			WHEN student =0 and parent =0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.5 + teacher * 0.5, 0)
			WHEN student =0 and parent =0 AND teacher >0 and leaderTeacher=0 THEN teacher
			WHEN student =0 and parent =0 AND teacher =0 and leaderTeacher>0 THEN leaderTeacher

			WHEN student =0 and parent >0 AND teacher >0 and leaderTeacher>0 THEN ROUND(leaderTeacher * 0.25 + teacher * 0.25 + parent*0.5, 0)
			WHEN student =0 and parent >0 AND teacher >0 and leaderTeacher=0 THEN ROUND (teacher * 0.5 + parent*0.5, 0)
			WHEN student =0 and parent >0 AND teacher =0 and leaderTeacher>0 THEN ROUND (leaderTeacher * 0.5 + parent*0.5, 0)  END  AS integer) AS Score
FROM (
 SELECT scs.DfnSurveyCriteriaId, 
 sr.TermId, 
 sr.SolvedUserId, 
 sr.SolvedUserAge, 
 sr.SolvedUserTemperamentId,
 sr.SurveyId,
 sum(case when sr.SolverRoleId='DEB470C7-9827-4375-B20A-BEA56511EA49' then scs.Score else 0 end) as student,
 avg(case when sr.SolverRoleId='13676A48-FC7A-4694-82B2-CF0EE8F06313' then scs.Score else 0 end) as parent,  
 sum(case when sr.SolverRoleId='46A1C2F2-AA44-41EF-A746-59AC5EC09DCE' then scs.Score else 0 end) as teacher, 
 sum(case when sr.SolverRoleId='574D2187-D602-4188-A63C-C2B9DC5133DF' then scs.Score else 0 end) as leaderTeacher
  FROM dbo.SurveyResults AS sr 
  INNER JOIN dbo.SurveyCriteriaScores AS scs ON sr.Id = scs.SurveyResultId 
  INNER JOIN dbo.UserOrganizationRoles AS uor ON uor.Id = sr.UserOrganizationRoleSolverUserId
  left join Users u on uor.UserId = u.Id and sr.SolvedUserTemperamentId = u.TemperamentTypeId
  WHERE (sr.SurveyId in(2,3,4,5) )AND (sr.SurveyState = 3) and sr.IsActive=1

  GROUP BY scs.DfnSurveyCriteriaId, 
  sr.TermId, 
  sr.SolvedUserId, 
  sr.SolvedUserAge, 
  sr.SolvedUserTemperamentId,
  sr.SurveyId
  ) 
  AS sub)
  AS zz 
   INNER JOIN dbo.DfnSurveyCriterias AS src ON zz.DfnSurveyCriteriaId = src.Id 
   inner JOIN dbo.DfnCriteriaNorms AS cn ON src.Id = cn.CriteriaId AND zz.SolvedUserAge = cn.Age and zz.SolvedUserTemperamentId=cn.TemperamentId
   INNER JOIN dbo.DfnCriteriaReports AS crap ON src.Id = crap.CriteriaId AND (crap.NormStatus = dbo.GetNormStatu(zz.Score, cn.NormScore) OR
   crap.NormStatus IS NULL) AND zz.SolvedUserAge = crap.Age AND zz.SolvedUserTemperamentId = crap.TemperamentId
GO
/****** Object:  View [dbo].[VSocialSkillCriteriaScore]    Script Date: 14.11.2019 09:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[VSocialSkillCriteriaScore]
AS

SELECT 
	zz.DfnSurveyCriteriaId,
	src.CriteriaGroupId, 
	zz.TermId, 
	zz.SolvedUserId, 
	zz.SchoolLevel, 
	zz.SolvedUserTemperamentId, 
	cn.NormScore, 
	src.SurveyCriteriaName, 
	src.SurveyCriteriaDescription, 
	src.SurveyCriteriaName_US, 
	src.SurveyCriteriaDescription_US, 
	zz.Score FROM 
		(SELECT        
			DfnSurveyCriteriaId,
			TermId, SolvedUserId,
			SolvedUserTemperamentId,
			SchoolLevel,
			CASE WHEN teacher =0 and leaderTeacher=0 THEN NULL /*Öğretmen çözmemiş ise tüm seviyelerde null*/
            WHEN student >0 AND parent >0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.4 + parent * 0.3 + teacher * 0.15 + leaderTeacher*0.15, 0)
			WHEN student >0 AND parent >0 AND teacher >0 and leaderTeacher=0 THEN ROUND(student * 0.4 + parent * 0.3 + teacher * 0.3, 0)
			WHEN student >0 AND parent >0 AND teacher =0 and leaderTeacher>0 THEN ROUND(student * 0.4 + parent * 0.3 + leaderTeacher * 0.3, 0)

			WHEN student >0 AND parent =0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.6 + teacher * 0.2 + leaderTeacher*0.2, 0)
			WHEN student >0 AND parent =0 AND teacher >0 and leaderTeacher=0 THEN ROUND(student * 0.6 + teacher * 0.4, 0)
			WHEN student >0 AND parent =0 AND teacher =0 and leaderTeacher>0 THEN ROUND(student * 0.6 + leaderTeacher * 0.4, 0)

			WHEN student =0 and parent =0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.5 + teacher * 0.5, 0)
			WHEN student =0 and parent =0 AND teacher >0 and leaderTeacher=0 THEN teacher
			WHEN student =0 and parent =0 AND teacher =0 and leaderTeacher>0 THEN leaderTeacher

			WHEN student =0 and parent >0 AND teacher >0 and leaderTeacher>0 THEN ROUND(leaderTeacher * 0.25 + teacher * 0.25 + parent*0.5, 0)
			WHEN student =0 and parent >0 AND teacher >0 and leaderTeacher=0 THEN ROUND (teacher * 0.5 + parent*0.5, 0)
			WHEN student =0 and parent >0 AND teacher =0 and leaderTeacher>0 THEN ROUND (leaderTeacher * 0.5 + parent*0.5, 0)  END AS Score 
                    FROM            
						(SELECT 
								scs.DfnSurveyCriteriaId, 
								sr.TermId,
								sr.SchoolLevel,
								sr.SolvedUserId,	
								sr.SolvedUserTemperamentId,
								sum(case when sr.SolverRoleId='DEB470C7-9827-4375-B20A-BEA56511EA49' then scs.Score else 0 end) as student,
								avg(case when sr.SolverRoleId='13676A48-FC7A-4694-82B2-CF0EE8F06313' then scs.Score else 0 end) as parent,  
								sum(case when sr.SolverRoleId='46A1C2F2-AA44-41EF-A746-59AC5EC09DCE' then scs.Score else 0 end) as teacher, 
								sum(case when sr.SolverRoleId='574D2187-D602-4188-A63C-C2B9DC5133DF' then scs.Score else 0 end) as leaderTeacher
								     FROM dbo.SurveyResults AS sr 
									 Inner JOIN dbo.SurveyCriteriaScores AS scs ON sr.Id = scs.SurveyResultId 
									 WHERE        
										(sr.SurveyId IN (6,10,11,12,17,18)) AND (sr.SurveyState = 3) and sr.IsActive=1
										GROUP BY scs.DfnSurveyCriteriaId, sr.TermId,sr.SolvedUserId,sr.SchoolLevel,sr.SolvedUserTemperamentId) AS sub) AS zz
									INNER JOIN dbo.DfnSurveyCriterias AS src ON zz.DfnSurveyCriteriaId = src.Id 
									INNER JOIN dbo.DfnCriteriaNorms AS cn ON src.Id = cn.CriteriaId AND zz.SchoolLevel = cn.SchoolLevel AND zz.SolvedUserTemperamentId = cn.TemperamentId
GO
/****** Object:  Table [dbo].[Organizations]    Script Date: 14.11.2019 09:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organizations](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[OrganTypeId] [uniqueidentifier] NOT NULL,
	[ParentId] [uniqueidentifier] NOT NULL,
	[Capacity] [int] NOT NULL,
	[Level] [int] NOT NULL,
	[Rank] [int] NOT NULL,
 CONSTRAINT [PK_Organizations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnTemperamentTypes]    Script Date: 14.11.2019 09:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnTemperamentTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemperamentCode] [nvarchar](max) NULL,
	[TemperamentTypeName] [nvarchar](max) NULL,
	[TemperamentTypeName_US] [nvarchar](max) NULL,
	[BasicMotivation] [nvarchar](max) NULL,
	[BasicMotivation_US] [nvarchar](max) NULL,
	[OpenTrendId] [int] NOT NULL,
	[HiddenTrendId] [int] NOT NULL,
	[MainTemperamentDefinitionId] [int] NOT NULL,
	[WingTemperamentDefinitionId] [int] NULL,
	[MainTemperamentTendency] [int] NULL,
	[WingTemperamentTendency] [int] NULL,
	[TemperamentTypeNameShort] [nvarchar](max) NULL,
 CONSTRAINT [PK_DfnTemperamentTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Terms]    Script Date: 14.11.2019 09:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Terms](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Name_US] [nvarchar](max) NULL,
	[Year] [int] NOT NULL,
	[TermIndex] [tinyint] NOT NULL,
 CONSTRAINT [PK_Terms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VStudent]    Script Date: 14.11.2019 09:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VStudent] AS

SELECT
      U.Id as UserId
     ,U.[NationalId]
     ,U.[UserName]

     ,U.[Password]
     ,U.[Name]
     ,U.[Email]
     ,U.[Picture]
     ,U.[PositionID]
     ,U.[PhoneNumber]
     ,U.[Sex]
,(CASE
           WHEN (U.Sex = 0) THEN 'Kad�n'
           WHEN (U.Sex = 1) THEN 'Erkek'
       END) AS SexName
     ,U.[BirthDate]
    , datediff(yy,U.[BirthDate],getdate()) AS Age
     ,U.[TemperamentTypeId]
     ,U.[ShowTemperament]
      ,[DfnTemperamentTypes].BasicMotivation
      ,[DfnTemperamentTypes].MainTemperamentDefinitionId
      ,[DfnTemperamentTypes].MainTemperamentTendency
      ,[DfnTemperamentTypes].TemperamentCode
      ,[DfnTemperamentTypes].TemperamentTypeName
      ,[DfnTemperamentTypes].TemperamentTypeNameShort
      ,[DfnTemperamentTypes].WingTemperamentDefinitionId
      ,[DfnTemperamentTypes].WingTemperamentTendency
      ,(CASE
           WHEN (MainTemperamentTendency = 1) THEN 'Kendine D�n�k'
           WHEN (MainTemperamentTendency = 2) THEN '�li�kilere D�n�k'
            WHEN (MainTemperamentTendency = 3) THEN 'Topluma D�n�k'
       END) AS MainTemperamentTendencyName
        ,(CASE
           WHEN (WingTemperamentTendency = 1) THEN 'Kendine D�n�k'
           WHEN (WingTemperamentTendency = 2) THEN '�li�kilere D�n�k'
            WHEN (WingTemperamentTendency = 3) THEN 'Topluma D�n�k'
       END) AS WingTemperamentTendencyName
        ,UOR.OrganizationId AS OrganizationId
        , [Organizations].[Name] as OrganizationName
        , [Organizations].[Level] as OrganizationLevel
        , (CASE
           WHEN ([Organizations].[Level] = 0) THEN 0 --okul
            WHEN ([Organizations].[Level] < 0) THEN 1 -- anaokulu
           WHEN ([Organizations].[Level] between 1 and 4) THEN 2 --ilkokul
            WHEN ([Organizations].[Level] between 5 and 8) THEN 3 --ortaokul
            WHEN ([Organizations].[Level] between 9 and 12) THEN 4 --lise
       END) AS UnitType
        ,OgrU.[Name] as TheacerName
        ,RhbU.[Name] as LeaderName
        ,VU.[Name] as ParentName
 FROM [dbo].[Users] U
 LEFT JOIN [dbo].[DfnTemperamentTypes] on U.TemperamentTypeId = [DfnTemperamentTypes].Id
 LEFT JOIN [dbo].[UserOrganizationRoles] UOR ON U.Id = UOR.UserId
 LEFT JOIN [dbo].[Organizations] on UOR.OrganizationId = [Organizations].Id
 LEFT JOIN [dbo].[UserOrganizationRoles] OGR ON OGR.AccessClassroomIds LIKE CONCAT('%', UOR.OrganizationId ,'%') AND OGR.RoleId='46A1C2F2-AA44-41EF-A746-59AC5EC09DCE' and OGR.TermId=(SELECT Id FROM Terms WHERE IsActive=1)
 LEFT JOIN Users OgrU on OgrU.Id=OGR.UserId
 LEFT JOIN [dbo].[UserOrganizationRoles] RHB ON RHB.AccessClassroomIds LIKE CONCAT('%', UOR.OrganizationId ,'%') AND RHB.RoleId='574D2187-D602-4188-A63C-C2B9DC5133DF' and RHB.TermId=(SELECT Id FROM Terms WHERE IsActive=1)
 LEFT JOIN Users RhbU on RhbU.Id=RHB.UserId
 LEFT JOIN [dbo].[UserOrganizationRoles] V ON V.AccessClassroomIds LIKE CONCAT('%', UOR.OrganizationId ,'%') AND V.RoleId='13676A48-FC7A-4694-82B2-CF0EE8F06313' and V.TermId=(SELECT Id FROM Terms WHERE IsActive=1)
 LEFT JOIN Users VU on VU.Id=V.UserId

GO
/****** Object:  Table [dbo].[DfnGroupNorms]    Script Date: 14.11.2019 09:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnGroupNorms](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemperamentId] [int] NOT NULL,
	[GroupId] [int] NOT NULL,
	[NormScore] [int] NOT NULL,
	[SchoolLevel] [int] NULL,
 CONSTRAINT [PK_DfnGroupNorms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnSurveyCriteriaGroups]    Script Date: 14.11.2019 09:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnSurveyCriteriaGroups](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](max) NULL,
	[GroupName_US] [nvarchar](max) NULL,
	[SurveyCategoryId] [int] NOT NULL,
	[GroupDescription] [nvarchar](max) NULL,
	[GroupDescription_Us] [nvarchar](max) NULL,
	[GroupNickname] [nvarchar](max) NULL,
	[GroupNickname_Us] [nvarchar](max) NULL,
 CONSTRAINT [PK_DfnSurveyCriteriaGroupsCopy] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VSocialSkillGroupScore]    Script Date: 14.11.2019 09:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VSocialSkillGroupScore]
AS
SELECT
	sub.SolvedUserId,
	sub.TermId,
	cg.GroupName,
	cg.GroupName_US,
	sub.SolvedUserTemperamentId,
	sub.CriteriaGroupId,
	sub.SchoolLevel,
	grp.NormScore,
	dbo.GetNormStatu(Cast(sub.scoreAvg as int),grp.NormScore) AS Normstatu,
	dbo.GetScoreLevelReverse(Cast(sub.scoreAvg as int)) as ScoreLevel,
	dbo.GetScoreLevelReverse(grp.NormScore) as NormLevel,
	Cast(sub.scoreAvg as int) as StudentGroupScore,
	rep.Content,
	rep.Content_US,
	rep.ContentType,
	rep2.Content as StudentPersonelReport,
	rep2.Content_US as StudentPersonelReport_US
		FROM (
			SELECT      
				ss.SolvedUserId,
				ss.TermId,
				SolvedUserTemperamentId,
				CriteriaGroupId,
				SchoolLevel,
				AVG(Score) AS scoreAvg
					FROM
						dbo.VSocialSkillCriteriaScore AS ss
						GROUP BY  ss.SolvedUserId,ss.TermId, SolvedUserTemperamentId, SchoolLevel, CriteriaGroupId) AS sub 
						Left JOIN dbo.DfnSurveyCriteriaGroups AS cg ON sub.CriteriaGroupId = cg.Id 
						Left join dbo.DfnGroupNorms grp on grp.GroupId = sub.CriteriaGroupId and grp.TemperamentId = sub.SolvedUserTemperamentId and grp.SchoolLevel = sub.SchoolLevel 						
						Left join DfnCriteriaReports rep on rep.SchoolLevel = sub.SchoolLevel and rep.ContentType = 0 and rep.TemperamentId = sub.SolvedUserTemperamentId and rep.CriteriaGroupId = sub.CriteriaGroupId and rep.ScoreLevel = dbo.GetScoreLevelReverse(Cast(sub.scoreAvg as int)) 
						Left Join DfnCriteriaReports rep2 on rep2.SchoolLevel = sub.SchoolLevel and rep2.ContentType = 2 and rep2.TemperamentId = sub.SolvedUserTemperamentId and rep2.CriteriaGroupId is null and rep2.CriteriaId is null
						left join Users u on SolvedUserId = u.Id
						where SolvedUserTemperamentId = u.TemperamentTypeId 
GO
/****** Object:  Table [dbo].[DfnTemperamentReduces]    Script Date: 14.11.2019 09:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnTemperamentReduces](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemperamentId9] [int] NOT NULL,
	[TemperamentId18] [int] NOT NULL,
	[TemperamentId] [int] NOT NULL,
	[TemperamentId54] [int] NULL,
 CONSTRAINT [PK_DfnTemperamentReduces] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnMentalTalentReports]    Script Date: 14.11.2019 09:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnMentalTalentReports](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DfnSurveyCriteriaGroupId] [int] NOT NULL,
	[SchoolLevel] [int] NOT NULL,
	[ContentType] [int] NOT NULL,
	[Content] [nvarchar](max) NULL,
	[Content_En] [nvarchar](max) NULL,
 CONSTRAINT [PK_DfnMentalTalentReports] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VMentalTalentCriteriaScore]    Script Date: 14.11.2019 09:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[VMentalTalentCriteriaScore]
AS
SELECT
mt.DfnSurveyCriteriaGroupId,
--tr.TemperamentId18 as Temp18,
zz.TermId, zz.SolvedUserId,
zz.SolvedUserTemperamentId,
sg.GroupName,
zz.Score,
mt.Content,
mt.ContentType,
zz.SchoolLevel,
criteriaGroupId
FROM
(SELECT
DfnSurveyCriteriaId,
TermId,
SolvedUserId,
SolvedUserTemperamentId,
SurveyId,
SchoolLevel,
criteriaGroupId,
CAST(
            CASE WHEN teacher =0 and leaderTeacher=0 THEN NULL --/Öğretmen çözmemiş ise tüm seviyelerde null/
			WHEN student >0 AND parent >0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.4 + parent * 0.3 + teacher * 0.15 + leaderTeacher*0.15, 0)
            WHEN student >0 AND parent >0 AND teacher >0 and leaderTeacher=0 THEN ROUND(student * 0.4 + parent * 0.3 + teacher * 0.3, 0)
            WHEN student >0 AND parent >0 AND teacher =0 and leaderTeacher>0 THEN ROUND(student * 0.4 + parent * 0.3 + leaderTeacher * 0.3, 0)
            WHEN student >0 AND parent =0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.6 + teacher * 0.2 + leaderTeacher*0.2, 0)
            WHEN student >0 AND parent =0 AND teacher >0 and leaderTeacher=0 THEN ROUND(student * 0.6 + teacher * 0.4, 0)
            WHEN student >0 AND parent =0 AND teacher =0 and leaderTeacher>0 THEN ROUND(student * 0.6 + leaderTeacher * 0.4, 0)
            WHEN student =0 and parent =0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.5 + teacher * 0.5, 0)
            WHEN student =0 and parent =0 AND teacher >0 and leaderTeacher=0 THEN teacher
            WHEN student =0 and parent =0 AND teacher =0 and leaderTeacher>0 THEN leaderTeacher
            WHEN student =0 and parent >0 AND teacher >0 and leaderTeacher>0 THEN ROUND(leaderTeacher * 0.25 + teacher * 0.25 + parent*0.5, 0)
            WHEN student =0 and parent >0 AND teacher >0 and leaderTeacher=0 THEN ROUND (teacher * 0.5 + parent*0.5, 0)
            WHEN student =0 and parent >0 AND teacher =0 and leaderTeacher>0 THEN ROUND (leaderTeacher * 0.5 + parent*0.5, 0)  END AS integer) AS Score
FROM (
SELECT scs.DfnSurveyCriteriaId,
sr.TermId,
sr.SolvedUserId,
sr.SolvedUserTemperamentId,
sr.SurveyId,
sr.SchoolLevel,
cr.Id as criteriaGroupId,

 sum(case when sr.SolverRoleId='DEB470C7-9827-4375-B20A-BEA56511EA49' then scs.Score else 0 end) as student,
 sum(case when sr.SolverRoleId='13676A48-FC7A-4694-82B2-CF0EE8F06313' then scs.Score else 0 end) as parent,
 sum(case when sr.SolverRoleId='46A1C2F2-AA44-41EF-A746-59AC5EC09DCE' then scs.Score else 0 end) as teacher,
 sum(case when sr.SolverRoleId='574D2187-D602-4188-A63C-C2B9DC5133DF' then scs.Score else 0 end) as leaderTeacher
FROM dbo.SurveyResults AS sr
INNER JOIN dbo.SurveyCriteriaScores AS scs ON sr.Id = scs.SurveyResultId
inner JOIN dbo.DfnSurveyCriteriaGroups AS cr ON scs.DfnSurveyCriteriaId = cr.Id
INNER JOIN dbo.UserOrganizationRoles AS uor ON uor.Id = sr.UserOrganizationRoleSolverUserId
left join Users u on uor.UserId = u.Id and sr.SolvedUserTemperamentId = u.TemperamentTypeId
WHERE (sr.SurveyId in(23,24,25) )AND (sr.SurveyState = 3) and sr.IsActive=1 
GROUP BY scs.DfnSurveyCriteriaId,
sr.TermId,
sr.SolvedUserId,
sr.SolvedUserTemperamentId,
sr.SurveyId,
sr.SchoolLevel,
cr.Id
)
AS sub)
AS zz
join DfnTemperamentReduces tr on zz.SolvedUserTemperamentId=tr.TemperamentId
inner JOIN dbo.DfnSurveyCriteriaGroups AS sg on sg.Id = zz.criteriaGroupId
left join DfnMentalTalentReports as mt on mt.SchoolLevel = zz.SchoolLevel and sg.Id=mt.DfnSurveyCriteriaGroupId

GO
/****** Object:  View [dbo].[VUniversalLifeSkillsScore]    Script Date: 14.11.2019 09:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[VUniversalLifeSkillsScore]
AS
SELECT   
zz.DfnSurveyCriteriaId, 
zz.TermId, 
zz.SolvedUserId, 
zz.SolvedUserAge, 
zz.SolvedUserTemperamentId, 
src.SurveyCriteriaName, 
src.SurveyCriteriaDescription, 
src.SurveyCriteriaName_US, 
src.SurveyCriteriaDescription_US, 
zz.Score,dbo.GetMeritLevel(zz.Score,0,0) as ScoreLevel, 
crap.[Content],
crap.[Content_US],
 crap.ContentType
FROM            (SELECT        DfnSurveyCriteriaId, TermId, SolvedUserId, SolvedUserAge, SolvedUserTemperamentId,SchoolLevel,CASE WHEN teacher =0 and leaderTeacher=0 THEN NULL /*Öğretmen çözmemiş ise tüm seviyelerde null*/
            WHEN student >0 AND parent >0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.4 + parent * 0.3 + teacher * 0.15 + leaderTeacher*0.15, 0)
			WHEN student >0 AND parent >0 AND teacher >0 and leaderTeacher=0 THEN ROUND(student * 0.4 + parent * 0.3 + teacher * 0.3, 0)
			WHEN student >0 AND parent >0 AND teacher =0 and leaderTeacher>0 THEN ROUND(student * 0.4 + parent * 0.3 + leaderTeacher * 0.3, 0)

			WHEN student >0 AND parent =0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.6 + teacher * 0.2 + leaderTeacher*0.2, 0)
			WHEN student >0 AND parent =0 AND teacher >0 and leaderTeacher=0 THEN ROUND(student * 0.6 + teacher * 0.4, 0)
			WHEN student >0 AND parent =0 AND teacher =0 and leaderTeacher>0 THEN ROUND(student * 0.6 + leaderTeacher * 0.4, 0)

			WHEN student =0 and parent =0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.5 + teacher * 0.5, 0)
			WHEN student =0 and parent =0 AND teacher >0 and leaderTeacher=0 THEN teacher
			WHEN student =0 and parent =0 AND teacher =0 and leaderTeacher>0 THEN leaderTeacher

			WHEN student =0 and parent >0 AND teacher >0 and leaderTeacher>0 THEN ROUND(leaderTeacher * 0.25 + teacher * 0.25 + parent*0.5, 0)
			WHEN student =0 and parent >0 AND teacher >0 and leaderTeacher=0 THEN ROUND (teacher * 0.5 + parent*0.5, 0)
			WHEN student =0 and parent >0 AND teacher =0 and leaderTeacher>0 THEN ROUND (leaderTeacher * 0.5 + parent*0.5, 0)  END AS Score
		
FROM   
(SELECT        scs.DfnSurveyCriteriaId, sr.TermId, sr.SolvedUserId, sr.SolvedUserAge, sr.SolvedUserTemperamentId, sr.SchoolLevel,
   sum(case when sr.SolverRoleId='DEB470C7-9827-4375-B20A-BEA56511EA49' then scs.Score else 0 end) as student,
				avg(case when sr.SolverRoleId='13676A48-FC7A-4694-82B2-CF0EE8F06313' then scs.Score else 0 end) as parent,  
				sum(case when sr.SolverRoleId='46A1C2F2-AA44-41EF-A746-59AC5EC09DCE' then scs.Score else 0 end) as teacher, 
				sum(case when sr.SolverRoleId='574D2187-D602-4188-A63C-C2B9DC5133DF' then scs.Score else 0 end) as leaderTeacher
     FROM  dbo.SurveyResults AS sr 
	 INNER JOIN dbo.SurveyCriteriaScores AS scs ON sr.Id = scs.SurveyResultId 
	 INNER JOIN dbo.UserOrganizationRoles AS uor ON uor.Id = sr.UserOrganizationRoleSolverUserId
	 left join Users u on uor.UserId = u.Id and sr.SolvedUserTemperamentId = u.TemperamentTypeId
    WHERE(sr.SurveyId IN (15,16,21,22)) AND (sr.SurveyState = 3)  and sr.IsActive = 1
    GROUP BY scs.DfnSurveyCriteriaId, sr.TermId, sr.SolvedUserId, sr.SolvedUserAge, sr.SolvedUserTemperamentId, sr.SchoolLevel) AS sub) AS zz 
	INNER JOIN    dbo.DfnSurveyCriterias AS src ON zz.DfnSurveyCriteriaId = src.Id 
	left JOIN  dbo.DfnCriteriaReports AS crap ON src.Id = crap.CriteriaId AND crap.ScoreLevel = dbo.GetMeritLevel(zz.Score,0,0) and crap.CriteriaGroupId = src.CriteriaGroupId and crap.SchoolLevel = zz.SchoolLevel
GO
/****** Object:  View [dbo].[VUniversalUsersScore]    Script Date: 14.11.2019 09:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[VUniversalUsersScore]
AS
SELECT        scs.DfnSurveyCriteriaId,crt.SurveyCriteriaName, sr.TermId, sr.SolvedUserId, sr.SolvedUserTemperamentId, sr.SchoolLevel,sr.SurveyState,sr.SurveyId,
   sum(case when sr.SolverRoleId='DEB470C7-9827-4375-B20A-BEA56511EA49' then scs.Score else 0 end) as student,
				sum(case when sr.SolverRoleId='13676A48-FC7A-4694-82B2-CF0EE8F06313' then scs.Score else 0 end) as parent,  
				sum(case when sr.SolverRoleId='46A1C2F2-AA44-41EF-A746-59AC5EC09DCE' then scs.Score else 0 end) as teacher, 
				sum(case when sr.SolverRoleId='574D2187-D602-4188-A63C-C2B9DC5133DF' then scs.Score else 0 end) as leaderTeacher
     FROM  dbo.SurveyResults AS sr 
	 INNER JOIN SurveyCriteriaScores AS scs ON sr.Id = scs.SurveyResultId 
	 INNER JOIN UserOrganizationRoles AS uor ON uor.Id = sr.UserOrganizationRoleSolverUserId
	 Inner Join DfnSurveyCriterias as crt on crt.Id = scs.DfnSurveyCriteriaId
	 left join Users u on uor.UserId = u.Id and sr.SolvedUserTemperamentId = u.TemperamentTypeId
    WHERE(sr.SurveyId IN (15,16,21,22)) AND (sr.SurveyState = 3) and sr.IsActive = 1
    GROUP BY scs.DfnSurveyCriteriaId, sr.TermId, sr.SolvedUserId, sr.SolvedUserTemperamentId, sr.SchoolLevel,crt.SurveyCriteriaName,sr.SurveyState,sr.SurveyId
GO
/****** Object:  Table [dbo].[HrSurveys]    Script Date: 14.11.2019 09:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrSurveys](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SurveyId] [int] NOT NULL,
	[SurveyName] [nvarchar](max) NULL,
	[SurveyName_US] [nvarchar](max) NULL,
	[SurveyAlias] [nvarchar](max) NULL,
	[SurveyLevel] [nvarchar](max) NULL,
	[SurveyContent] [nvarchar](max) NULL,
	[SurveyContent_US] [nvarchar](max) NULL,
	[SurveyInfo] [nvarchar](max) NULL,
	[Category] [int] NOT NULL,
	[Level] [int] NOT NULL,
 CONSTRAINT [PK_HrSurveys] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrUserSurveys]    Script Date: 14.11.2019 09:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrUserSurveys](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RatedUserId] [uniqueidentifier] NOT NULL,
	[EvaluatedUserId] [uniqueidentifier] NOT NULL,
	[SurveyId] [int] NOT NULL,
	[SurveyState] [tinyint] NOT NULL,
	[AnswerId] [int] NOT NULL,
	[SurveyManipulationValue] [int] NOT NULL,
 CONSTRAINT [PK_HrUserSurveys] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrPositions]    Script Date: 14.11.2019 09:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrPositions](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PositionName] [nvarchar](max) NULL,
	[PositionLevel] [tinyint] NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[PositionDefination] [nvarchar](max) NULL,
	[IsDepartmentSupervisor] [bit] NOT NULL,
	[PositionOrientation] [tinyint] NOT NULL,
	[PositionCode] [tinyint] NOT NULL,
 CONSTRAINT [PK_HrPositions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VHrUserSurvey]    Script Date: 14.11.2019 09:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[VHrUserSurvey]
AS
SELECT        
uor.OrganizationId as OrganisationId,
 usurvey.Id as HrUserSurveyId, 
 usurvey.SurveyId, 
 usurvey.EvaluatedUserId, 
 usurvey.RatedUserId, 
 usurvey.SurveyState, 
 ue.Name AS EvaluatedUserName, 
 ur.Name AS RatedUserName, 
 srv.SurveyName, 
 srv.SurveyName_US, 
 srv.SurveyLevel, 
 p.PositionName, 
 usurvey.DateCreated AS CreatedDate, 
 usurvey.DateModified as ModifiedDate,
 srv.Category
FROM  dbo.HrUserSurveys AS usurvey INNER JOIN
  dbo.HrSurveys AS srv ON usurvey.SurveyId = srv.SurveyId INNER JOIN
  dbo.Users AS ue ON usurvey.EvaluatedUserId = ue.Id INNER JOIN
  dbo.Users AS ur ON usurvey.RatedUserId = ur.Id left JOIN
  dbo.HrPositions AS p ON ue.PositionID = p.Id INNER JOIN
  dbo.UserOrganizationRoles AS uor ON ue.Id = uor.UserId
GO
/****** Object:  Table [dbo].[HrDepartments]    Script Date: 14.11.2019 09:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrDepartments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrganizationId] [uniqueidentifier] NOT NULL,
	[DepartmentName] [nvarchar](max) NULL,
	[ParentDepartmentID] [int] NOT NULL,
 CONSTRAINT [PK_HrDepartments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 14.11.2019 09:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [uniqueidentifier] NOT NULL,
	[RoleName] [nvarchar](150) NOT NULL,
	[RoleName_US] [nvarchar](max) NULL,
	[Code] [int] NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VUser]    Script Date: 14.11.2019 09:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VUser]
AS


select u.Id
,u.Name +' '+ u.Surname as NameSurname
,u.Email
,u.Sex as SexCode
,u.BirthDate
,r.Id as RoleId
,r.RoleName
,r.RoleName_US
,r.Code
,u.TemperamentTypeId
,u.NationalId
,o.Id as OrganisationId
,o.Name as OrganisationName
,o.OrganTypeId
,o.[Rank]
,o.[Level]
,tem.TemperamentTypeName
,tem.TemperamentTypeName_US
,tem.OpenTrendId
,p.Id as PositionId
,p.PositionName
,p.PositionLevel
,p.PositionOrientation,
p.DepartmentId
,d.Id as DepartmentId1
,d.DepartmentName
 from Users u
join UserOrganizationRoles uor on u.Id=uor.UserId 
join Organizations o on uor.OrganizationId=o.Id
join Roles r on uor.RoleId=r.Id
left join HrPositions p on u.PositionID=p.Id
left join HrDepartments d on p.DepartmentId=d.Id
join DfnTemperamentTypes tem on u.TemperamentTypeId=tem.Id
where u.IsActive=1 and u.IsDeleted=0
GO
/****** Object:  Table [dbo].[HrRiskScores]    Script Date: 14.11.2019 09:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrRiskScores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RatedUserID] [uniqueidentifier] NOT NULL,
	[EvaluatedUserId] [uniqueidentifier] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[AnswerID] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[Score] [int] NOT NULL,
 CONSTRAINT [PK_HrRiskScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrUserLastSurveyAnswers]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrUserLastSurveyAnswers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RatedUserId] [uniqueidentifier] NOT NULL,
	[EveluatedUserID] [uniqueidentifier] NOT NULL,
	[SurveyId] [int] NOT NULL,
	[AnswerId] [int] NOT NULL,
	[CreateDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_HrUserLastSurveyAnswers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrCategoryEvaluationTexts]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrCategoryEvaluationTexts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[EvaluationLevel] [tinyint] NOT NULL,
	[EvaluationText] [nvarchar](max) NULL,
	[EvaluationText_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_HrCategoryEvaluationTexts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrCategories]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrCategories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](max) NULL,
	[CategoryName_US] [nvarchar](max) NULL,
	[CategoryTagId] [int] NOT NULL,
	[HrCategoryTagId] [int] NULL,
 CONSTRAINT [PK_HrCategories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VHrUserRiskEveluation]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VHrUserRiskEveluation]
AS
SELECT        
u.Id AS UserId, 
u.NameSurname, 
u.OrganisationId,
c.CategoryName,
c.CategoryName_US,
rs.CategoryID, 
u.TemperamentTypeName, 
u.TemperamentTypeName_US, 
u.PositionId, 
u.PositionName, 
u.DepartmentId, 
u.DepartmentName, 
u.OrganisationName, 
ctx.EvaluationText, 
ctx.EvaluationText_US, 
ctx.EvaluationLevel, 
rs.Score
FROM    dbo.VUser AS u INNER JOIN
                         dbo.HrRiskScores AS rs ON u.Id = rs.EvaluatedUserId INNER JOIN
                         dbo.HrUserLastSurveyAnswers AS uls ON rs.EvaluatedUserId = uls.EveluatedUserID AND rs.AnswerID = uls.AnswerId INNER JOIN
                         dbo.HrCategories AS c ON rs.CategoryID = c.Id INNER JOIN
                         dbo.HrCategoryEvaluationTexts AS ctx ON rs.CategoryID = ctx.CategoryID AND ctx.EvaluationLevel = dbo.GetMeritLevel(rs.Score,0,0)
WHERE        (ctx.Id < 46)
GO
/****** Object:  View [dbo].[VHrUserRiskEveluationTracking]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[VHrUserRiskEveluationTracking]
AS
SELECT        rs.EvaluatedUserId, rs.CategoryID, rs.Score
FROM            dbo.HrRiskScores AS rs 
			 INNER JOIN  dbo.HrUserLastSurveyAnswers AS uls ON rs.EvaluatedUserId = uls.EveluatedUserID AND rs.AnswerID = uls.AnswerId 
GO
/****** Object:  Table [dbo].[HrLeadershipResults]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrLeadershipResults](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[LeadershipTypeId] [int] NOT NULL,
	[IsNaturalLeadership] [bit] NOT NULL,
	[LowLevelEveluationScore] [int] NULL,
	[UpLevelEveluationScore] [int] NULL,
	[HorizontalLevelEveluationScore] [int] NULL,
	[SelfEveluationScore] [int] NULL,
	[TemperamentScore] [int] NULL,
	[EveluationScore] [int] NULL,
	[PerceivedEveluationScore] [int] NULL,
	[LeadershipScore] [int] NULL,
 CONSTRAINT [PK_HrLeadershipResults] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrLeadershipDescriptions]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrLeadershipDescriptions](
	[Id] [uniqueidentifier] NOT NULL,
	[LeadershipTypeId] [int] NOT NULL,
	[LeadershipName] [nvarchar](max) NULL,
	[LeadershipName_US] [nvarchar](max) NULL,
	[LeadershipDescription] [nvarchar](max) NULL,
	[LeadershipDescription_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_HrLeadershipDescriptions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VLeadershipNatural]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VLeadershipNatural]
AS
SELECT        
lr.Id, 
lr.UserId, 
lr.LeadershipTypeId, 
lr.IsNaturalLeadership,
lr.LowLevelEveluationScore, 
lr.UpLevelEveluationScore, 
lr.HorizontalLevelEveluationScore, 
lr.SelfEveluationScore, 
lr.TemperamentScore, 
lr.EveluationScore, 
lr.PerceivedEveluationScore, 
lr.LeadershipScore, 
ld.LeadershipName AS NaturalLeadershipName, 
ld.LeadershipName_US AS NaturalLeadershipName_US, 
dbo.GetMeritLevel(lr.LeadershipScore,0,0) AS LeadershipScoreLevel
FROM  dbo.HrLeadershipResults AS lr INNER JOIN
     dbo.HrLeadershipDescriptions AS ld ON lr.LeadershipTypeId = ld.LeadershipTypeId
WHERE        (lr.IsNaturalLeadership = 1)
GO
/****** Object:  Table [dbo].[HrLeadershipScores]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrLeadershipScores](
	[Id] [uniqueidentifier] NOT NULL,
	[RatedUserId] [uniqueidentifier] NOT NULL,
	[EvaluatedUserId] [uniqueidentifier] NOT NULL,
	[EveluationCategoryId] [int] NOT NULL,
	[LeadershipTypeId] [int] NOT NULL,
	[AnswerId] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[Score] [tinyint] NOT NULL,
	[TemperamentScore] [tinyint] NULL,
	[RawScore] [tinyint] NULL,
	[TemperamentManipulationType] [tinyint] NULL,
	[Manipulation] [real] NULL,
 CONSTRAINT [PK_HrLeadershipScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrLeadershipTemperamentCriteriaScores]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrLeadershipTemperamentCriteriaScores](
	[Id] [uniqueidentifier] NOT NULL,
	[TemperamentId] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[Score] [int] NOT NULL,
 CONSTRAINT [PK_HrLeadershipTemperamentCriteriaScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrCriterias]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrCriterias](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CriteriaName] [nvarchar](max) NULL,
	[CriteriaName_US] [nvarchar](max) NULL,
	[CriteriaDescription] [nvarchar](max) NULL,
	[CriteriaDescription_US] [nvarchar](max) NULL,
	[CategoryId] [int] NOT NULL,
	[HrCategoryId] [int] NULL,
 CONSTRAINT [PK_HrCriterias] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrCriteriaEvaluationTexts]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrCriteriaEvaluationTexts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[EvaluationLevel] [tinyint] NOT NULL,
	[EvaluationText] [nvarchar](max) NULL,
	[EvaluationText_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_HrCriteriaEvaluationTexts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VLeadershipCriteriaAvg]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VLeadershipCriteriaAvg]
AS
SELECT       
 zz.UserId, 
 u.NameSurname, 
 u.PositionId,
 u.PositionName,
 u.TemperamentTypeName,
 u.TemperamentTypeName_US,
 u.TemperamentTypeId, 
 zz.CategoryId, 
 zz.CriteriaId, 
 zz.CriteriaName_US, 
 zz.CriteriaDescription,
  zz.CriteriaName, 
 zz.CriteriaDescription_Us,
 zz.EveluationCategoryId, 
 CAST(zz.EveluationAvg * 0.5 + cs.Score * 0.5 AS int) AS CriteriaAvg, 
dbo.GetMeritLevel(CAST(zz.EveluationAvg * 0.5 + cs.Score * 0.5 AS int),0,0) AS CriteriaAvgLevel,
zz.SelfEveluationAvg, dbo.GetMeritLevel(zz.SelfEveluationAvg,0,0) AS SelfEveluationAvgLevel, 
zz.PerceivedEveluationAvg, 
dbo.GetMeritLevel(zz.PerceivedEveluationAvg,0,0) AS PerceivedEveluationAvgLevel,
zz.EveluationAvg, 
dbo.GetMeritLevel(zz.EveluationAvg,0,0) AS EveluationAvgLevel, 
cs.Score AS TemperamentScore,
ce.EvaluationText,
ce.EvaluationText_US,
case when zz.CategoryId=28 then 0
when zz.CategoryId=ln.LeadershipTypeId then 1
else 2 end as CriteriaType
   
FROM (SELECT ls.EvaluatedUserId AS UserId, 
			 ls.EveluationCategoryId, 
			 ls.CriteriaId, 
			 c.CategoryId, 
			 c.CriteriaName, 
			 c.CriteriaDescription,
			  c.CriteriaName_US, 
			 c.CriteriaDescription_US, 
			 CASE WHEN ls.EveluationCategoryId = 16 THEN CAST(ROUND(SUM(ls.Score)/ COUNT(ls.Score), 0) AS int) 
			 ELSE NULL END AS SelfEveluationAvg, 
			 CASE WHEN ls.EveluationCategoryId <> 16 THEN CAST(ROUND(SUM(ls.Score) / COUNT(ls.Score), 0) AS int) 
			 ELSE NULL END AS PerceivedEveluationAvg, 
			 CAST(ROUND(SUM(ls.Score) / COUNT(ls.Score), 0) AS int) AS EveluationAvg
    FROM dbo.HrLeadershipScores AS ls 
	INNER JOIN dbo.HrUserLastSurveyAnswers AS la ON ls.EvaluatedUserId = la.EveluatedUserID AND ls.AnswerId = la.AnswerId 
	INNER JOIN dbo.HrCriterias AS c ON ls.CriteriaId = c.Id
    GROUP BY ls.EvaluatedUserId, 
	ls.EveluationCategoryId, 
	ls.CriteriaId, c.CategoryId,
	c.CriteriaName, 
	c.CriteriaDescription,
	c.CriteriaName_US, 
	 c.CriteriaDescription_US) AS zz 
INNER JOIN dbo.VUser AS u ON zz.UserId = u.Id 
LEFT OUTER JOIN  dbo.HrLeadershipTemperamentCriteriaScores AS cs ON zz.CriteriaId = cs.CriteriaId AND u.TemperamentTypeId = cs.TemperamentId
left  JOIN HrCriteriaEvaluationTexts ce on zz.CategoryId=ce.CategoryId and zz.CriteriaId=ce.CriteriaId 
AND dbo.GetMeritLevel(CAST(zz.EveluationAvg* 0.5 + cs.Score* 0.5 AS int),0,0)=ce.EvaluationLevel
left join VLeadershipNatural ln on zz.UserId=ln.UserId

GO
/****** Object:  View [dbo].[VLeadershipCriteriaAvgTracking]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VLeadershipCriteriaAvgTracking]
AS


SELECT ls.EvaluatedUserId AS UserId, 
			 ls.EveluationCategoryId, 
			 ls.CriteriaId, 
			 CASE WHEN ls.EveluationCategoryId = 16 THEN CAST(ROUND(SUM(ls.Score)/ COUNT(ls.Score), 0) AS int) 
			 ELSE NULL END AS SelfEveluationAvg, 
			 CASE WHEN ls.EveluationCategoryId <> 16 THEN CAST(ROUND(SUM(ls.Score) / COUNT(ls.Score), 0) AS int) 
			 ELSE NULL END AS PerceivedEveluationAvg, 
			 CAST(ROUND((SUM(ls.Score) / COUNT(ls.Score))*0.5+ ls.TemperamentScore*0.5, 0) AS int) AS CriteriaEveluationAvg,
			 ls.TemperamentScore as TemperamentScore
    FROM dbo.HrLeadershipScores AS ls 
	INNER JOIN dbo.HrUserLastSurveyAnswers AS la ON ls.EvaluatedUserId = la.EveluatedUserID AND ls.AnswerId = la.AnswerId 
	  GROUP BY ls.EvaluatedUserId, 
	ls.EveluationCategoryId, 
	ls.CriteriaId,
	TemperamentScore

GO
/****** Object:  View [dbo].[VLeadershipResultAvg]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VLeadershipResultAvg]
AS
SELECT
u.NameSurname,
u.PositionName,
u.PositionId,
u.DepartmentName,
u.DepartmentId,
u.OrganisationName, 
u.OrganisationId,
u.RoleName,
u.RoleId,
u.TemperamentTypeName,
u.TemperamentTypeName_US,
u.TemperamentTypeId,
u.Email,
lr.UserId, 
CAST(AVG(LowLevelEveluationScore) AS INT) AS LowLevelEveluationScoreAvg, 
CAST(AVG(UpLevelEveluationScore) AS INT) AS UpLevelEveluationScoreAvg, 
CAST(AVG(HorizontalLevelEveluationScore) AS INT) AS HorizontalLevelEveluationScoreAvg, 
CAST(AVG(PerceivedEveluationScore) AS INT) AS PerceivedEveluationScoreAvg, 
CAST(AVG(SelfEveluationScore) AS INT) AS SelfEveluationScoreAvg, 
CAST(AVG(EveluationScore) AS INT) AS EveluationScoreAvg, 
CAST(AVG(TemperamentScore) AS INT) AS TemperamentScoreAvg, 
CAST(AVG(LeadershipScore) AS INT) AS LeadershipScoreAvg,
CAST(AVG(CASE WHEN lr.IsNaturalLeadership = 0 THEN lr.LeadershipScore ELSE 0 END) AS INT) AS SyntheticLeadershipScoreAvg, 
CAST(AVG(CASE WHEN lr.IsNaturalLeadership = 1 THEN lr.LeadershipScore ELSE 0 END) AS INT) AS NaturalLeadershipScoreAvg,
CAST(ROUND(AVG(CASE WHEN lr.IsNaturalLeadership = 0 THEN lr.LeadershipScore ELSE 0 END) + AVG(CASE WHEN lr.IsNaturalLeadership = 1 THEN lr.LeadershipScore ELSE 0 END), 0) AS INT) AS GeneralLeadershipScoreAvg
FROM dbo.HrLeadershipResults AS lr
join VUser u on lr.UserId=u.Id
GROUP BY 
u.NameSurname,
u.PositionName,
u.PositionId,
u.DepartmentName,
u.DepartmentId,
u.OrganisationName, 
u.OrganisationId,
u.RoleName,
u.RoleId,
u.TemperamentTypeName,
u.TemperamentTypeId,
u.Email,
lr.UserId,
u.TemperamentTypeName_US
GO
/****** Object:  View [dbo].[VLeadershipResultAvgTracking]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




Create VIEW [dbo].[VLeadershipResultAvgTracking]
AS
SELECT
lr.UserId, 
CAST(AVG(PerceivedEveluationScore) AS INT) AS PerceivedEveluationScoreAvg, 
CAST(AVG(SelfEveluationScore) AS INT) AS SelfEveluationScoreAvg, 
CAST(AVG(TemperamentScore) AS INT) AS TemperamentScoreAvg, 
CAST(AVG(LeadershipScore) AS INT) AS LeadershipScoreAvg,
CAST(AVG(CASE WHEN lr.IsNaturalLeadership = 0 THEN lr.LeadershipScore ELSE 0 END) AS INT) AS SyntheticLeadershipScoreAvg, 
CAST(AVG(CASE WHEN lr.IsNaturalLeadership = 1 THEN lr.LeadershipScore ELSE 0 END) AS INT) AS NaturalLeadershipScoreAvg,
CAST(ROUND(AVG(CASE WHEN lr.IsNaturalLeadership = 0 THEN lr.LeadershipScore ELSE 0 END) + AVG(CASE WHEN lr.IsNaturalLeadership = 1 THEN lr.LeadershipScore ELSE 0 END), 0) AS INT) AS GeneralLeadershipScoreAvg
FROM dbo.HrLeadershipResults AS lr
GROUP BY 
lr.UserId
GO
/****** Object:  View [dbo].[VLeadershipStyleScore]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VLeadershipStyleScore]
AS
SELECT        
ls.EvaluatedUserId AS UserId,
ls.LeadershipTypeId, 
c.CategoryName, 
c.CategoryName_US, 
CAST(ROUND(SUM(ls.Score) / COUNT(ls.Score), 0) AS INT) AS LeadershipEveluationAvg
FROM           
 dbo.HrLeadershipScores AS ls INNER JOIN
 dbo.HrUserLastSurveyAnswers AS la ON ls.EvaluatedUserId = la.EveluatedUserID AND ls.AnswerId = la.AnswerId 
 INNER JOIN dbo.HrCategories AS c ON ls.LeadershipTypeId = c.Id
GROUP BY ls.EvaluatedUserId, 
ls.LeadershipTypeId, 
c.CategoryName,
c.CategoryName_US
GO
/****** Object:  View [dbo].[VPersonalityDevelopmentCriteriaScore]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VPersonalityDevelopmentCriteriaScore]
AS
SELECT
zz.DfnSurveyCriteriaId,
ctemp.CriteriaGroupId,
ctemp.IsNatural,
zz.IsExcessive,
tr.TemperamentId18 as Temp18,
zz.TermId, zz.SolvedUserId,
zz.SolvedUserTemperamentId,
src.SurveyCriteriaName,
src.SurveyCriteriaName_US,
src.SurveyCriteriaDescription,
src.SurveyCriteriaDescription_US,
zz.Score,
crap.ScoreLevel,
crap.[Content],
crap.[Content_US],
crap.ContentType,
zz.SchoolLevel,
crap2.content as Suggestion,
crap3.content as GeneralReport
FROM
(SELECT
DfnSurveyCriteriaId,
TermId,
SolvedUserId,
SolvedUserTemperamentId,
SurveyId,
SchoolLevel,
sub.IsExcessive,
CAST(
            CASE WHEN teacher =0 and leaderTeacher=0 THEN NULL --/Öğretmen çözmemiş ise tüm seviyelerde null/
			WHEN student >0 AND parent >0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.4 + parent * 0.3 + teacher * 0.15 + leaderTeacher*0.15, 0)
            WHEN student >0 AND parent >0 AND teacher >0 and leaderTeacher=0 THEN ROUND(student * 0.4 + parent * 0.3 + teacher * 0.3, 0)
            WHEN student >0 AND parent >0 AND teacher =0 and leaderTeacher>0 THEN ROUND(student * 0.4 + parent * 0.3 + leaderTeacher * 0.3, 0)
            WHEN student >0 AND parent =0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.6 + teacher * 0.2 + leaderTeacher*0.2, 0)
            WHEN student >0 AND parent =0 AND teacher >0 and leaderTeacher=0 THEN ROUND(student * 0.6 + teacher * 0.4, 0)
            WHEN student >0 AND parent =0 AND teacher =0 and leaderTeacher>0 THEN ROUND(student * 0.6 + leaderTeacher * 0.4, 0)
            WHEN student =0 and parent =0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.5 + teacher * 0.5, 0)
            WHEN student =0 and parent =0 AND teacher >0 and leaderTeacher=0 THEN teacher
            WHEN student =0 and parent =0 AND teacher =0 and leaderTeacher>0 THEN leaderTeacher
            WHEN student =0 and parent >0 AND teacher >0 and leaderTeacher>0 THEN ROUND(leaderTeacher * 0.25 + teacher * 0.25 + parent*0.5, 0)
            WHEN student =0 and parent >0 AND teacher >0 and leaderTeacher=0 THEN ROUND (teacher * 0.5 + parent*0.5, 0)
            WHEN student =0 and parent >0 AND teacher =0 and leaderTeacher>0 THEN ROUND (leaderTeacher * 0.5 + parent*0.5, 0)  END AS integer) AS Score
FROM (
SELECT scs.DfnSurveyCriteriaId,
sr.TermId,
sr.SolvedUserId,
sr.SolvedUserTemperamentId,
sr.SurveyId,
sr.SchoolLevel,
sum(scs.IsExcessive) as IsExcessive,
 sum(case when sr.SolverRoleId='DEB470C7-9827-4375-B20A-BEA56511EA49' then scs.Score else 0 end) as student,
 avg(case when sr.SolverRoleId='13676A48-FC7A-4694-82B2-CF0EE8F06313' then scs.Score else 0 end) as parent,
 sum(case when sr.SolverRoleId='46A1C2F2-AA44-41EF-A746-59AC5EC09DCE' then scs.Score else 0 end) as teacher,
 sum(case when sr.SolverRoleId='574D2187-D602-4188-A63C-C2B9DC5133DF' then scs.Score else 0 end) as leaderTeacher
FROM dbo.SurveyResults AS sr
INNER JOIN dbo.SurveyCriteriaScores AS scs ON sr.Id = scs.SurveyResultId
INNER JOIN dbo.UserOrganizationRoles AS uor ON uor.Id = sr.UserOrganizationRoleSolverUserId
left join Users u on uor.UserId = u.Id and sr.SolvedUserTemperamentId = u.TemperamentTypeId
WHERE (sr.SurveyId in(1) )AND (sr.SurveyState = 3) and sr.IsActive=1 
GROUP BY scs.DfnSurveyCriteriaId,
sr.TermId,
sr.SolvedUserId,
sr.SolvedUserTemperamentId,
sr.SurveyId,
sr.SchoolLevel
)
AS sub)
AS zz
INNER JOIN dbo.DfnSurveyCriterias AS src ON zz.DfnSurveyCriteriaId = src.Id
join DfnTemperamentReduces tr on zz.SolvedUserTemperamentId=tr.TemperamentId
INNER JOIN dbo.DfnCriteriaReports AS crap ON src.Id = crap.CriteriaId AND tr.TemperamentId18 = crap.TemperamentId and crap.ScoreLevel = dbo.GetMeritLevel(zz.Score,0,0)  and crap.SchoolLevel=zz.SchoolLevel
left join DfnCriteriaReports crap2 on src.Id = crap2.CriteriaId AND tr.TemperamentId18 = crap2.TemperamentId and crap2.ContentType=(case when zz.IsExcessive>0 then 3 else 0 end) and crap2.SchoolLevel=zz.SchoolLevel
left join DfnCriteriaReports crap3 on src.Id = crap3.CriteriaId AND tr.TemperamentId18 = crap3.TemperamentId and crap3.ContentType=2 and crap3.SchoolLevel=zz.SchoolLevel
left join DfnCriteriaTemperaments ctemp on ctemp.CriteriaId = src.Id and ctemp.TemperamentId = tr.TemperamentId18 and ctemp.SchoolLevel = zz.SchoolLevel 
GO
/****** Object:  View [dbo].[VGlobalLifeSkillsScore]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[VGlobalLifeSkillsScore]
AS
SELECT   
zz.DfnSurveyCriteriaId, 
zz.TermId, 
zz.SolvedUserId, 
zz.SolvedUserAge, 
zz.SolvedUserTemperamentId, 
src.SurveyCriteriaName, 
src.SurveyCriteriaDescription, 
src.SurveyCriteriaName_US, 
src.SurveyCriteriaDescription_US, 
zz.Score,
dbo.GetMeritLevel(zz.Score,0,0) as ScoreLevel, 
crap.Content, 
crap.Content_US, 
crap.ContentType
FROM            
(SELECT        
DfnSurveyCriteriaId, 
TermId, 
SolvedUserId, SolvedUserAge, SolvedUserTemperamentId,SchoolLevel,
 CASE WHEN teacher =0 and leaderTeacher=0 THEN NULL /*Öğretmen çözmemiş ise tüm seviyelerde null*/
            WHEN student >0 AND parent >0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.4 + parent * 0.3 + teacher * 0.15 + leaderTeacher*0.15, 0)
			WHEN student >0 AND parent >0 AND teacher >0 and leaderTeacher=0 THEN ROUND(student * 0.4 + parent * 0.3 + teacher * 0.3, 0)
			WHEN student >0 AND parent >0 AND teacher =0 and leaderTeacher>0 THEN ROUND(student * 0.4 + parent * 0.3 + leaderTeacher * 0.3, 0)

			WHEN student >0 AND parent =0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.6 + teacher * 0.2 + leaderTeacher*0.2, 0)
			WHEN student >0 AND parent =0 AND teacher >0 and leaderTeacher=0 THEN ROUND(student * 0.6 + teacher * 0.4, 0)
			WHEN student >0 AND parent =0 AND teacher =0 and leaderTeacher>0 THEN ROUND(student * 0.6 + leaderTeacher * 0.4, 0)

			WHEN student =0 and parent =0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.5 + teacher * 0.5, 0)
			WHEN student =0 and parent =0 AND teacher >0 and leaderTeacher=0 THEN teacher
			WHEN student =0 and parent =0 AND teacher =0 and leaderTeacher>0 THEN leaderTeacher

			WHEN student =0 and parent >0 AND teacher >0 and leaderTeacher>0 THEN ROUND(leaderTeacher * 0.25 + teacher * 0.25 + parent*0.5, 0)
			WHEN student =0 and parent >0 AND teacher >0 and leaderTeacher=0 THEN ROUND (teacher * 0.5 + parent*0.5, 0)
			WHEN student =0 and parent >0 AND teacher =0 and leaderTeacher>0 THEN ROUND (leaderTeacher * 0.5 + parent*0.5, 0)  END as Score
FROM   
(SELECT        scs.DfnSurveyCriteriaId, sr.TermId, sr.SolvedUserId, sr.SolvedUserAge, sr.SolvedUserTemperamentId, sr.SchoolLevel,
  sum(case when sr.SolverRoleId='DEB470C7-9827-4375-B20A-BEA56511EA49' then scs.Score else 0 end) as student,
  avg(case when sr.SolverRoleId='13676A48-FC7A-4694-82B2-CF0EE8F06313' then scs.Score else 0 end) as parent,  
  sum(case when sr.SolverRoleId='46A1C2F2-AA44-41EF-A746-59AC5EC09DCE' then scs.Score else 0 end) as teacher, 
  sum(case when sr.SolverRoleId='574D2187-D602-4188-A63C-C2B9DC5133DF' then scs.Score else 0 end) as leaderTeacher
     FROM  dbo.SurveyResults AS sr 
	 INNER JOIN dbo.SurveyCriteriaScores AS scs ON sr.Id = scs.SurveyResultId 
	 INNER JOIN dbo.UserOrganizationRoles AS uor ON uor.Id = sr.UserOrganizationRoleSolverUserId
	
    WHERE(sr.SurveyId IN (8, 9,13,14,19,20)) AND (sr.SurveyState = 3)  -- and sr.SolvedUserTemperamentId = u.TemperamentTypeId
    GROUP BY scs.DfnSurveyCriteriaId, sr.TermId, sr.SolvedUserId, sr.SolvedUserAge, sr.SolvedUserTemperamentId, sr.SchoolLevel) AS sub) AS zz 
	INNER JOIN    dbo.DfnSurveyCriterias AS src ON zz.DfnSurveyCriteriaId = src.Id 
	left JOIN  dbo.DfnCriteriaReports AS crap ON src.Id = crap.CriteriaId AND crap.ScoreLevel = dbo.GetMeritLevel(zz.Score,0,0) and crap.CriteriaGroupId = src.CriteriaGroupId and crap.SchoolLevel = zz.SchoolLevel
	 left join Users u on zz.SolvedUserId = u.Id
	where zz.SolvedUserTemperamentId = u.TemperamentTypeId
GO
/****** Object:  View [dbo].[VGlobalUsersScore]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VGlobalUsersScore]
AS
SELECT
	scs.DfnSurveyCriteriaId,
	crt.SurveyCriteriaName, 
	sr.TermId, 
	sr.SolvedUserId, 
	sr.SchoolLevel, 
	sr.SurveyState,
	sr.SolvedUserTemperamentId,
	sr.SurveyId,
  sum(case when sr.SolverRoleId='DEB470C7-9827-4375-B20A-BEA56511EA49' then scs.Score else 0 end) as student,
  sum(case when sr.SolverRoleId='13676A48-FC7A-4694-82B2-CF0EE8F06313' then scs.Score else 0 end) as parent,  
  sum(case when sr.SolverRoleId='46A1C2F2-AA44-41EF-A746-59AC5EC09DCE' then scs.Score else 0 end) as teacher, 
  sum(case when sr.SolverRoleId='574D2187-D602-4188-A63C-C2B9DC5133DF' then scs.Score else 0 end) as leaderTeacher
     FROM  dbo.SurveyResults AS sr 
	 INNER JOIN dbo.SurveyCriteriaScores AS scs ON sr.Id = scs.SurveyResultId 
	 INNER JOIN dbo.UserOrganizationRoles AS uor ON uor.Id = sr.UserOrganizationRoleSolverUserId
	 Inner Join DfnSurveyCriterias as crt on crt.Id = scs.DfnSurveyCriteriaId
	 left join Users u on uor.UserId = u.Id and sr.SolvedUserTemperamentId = u.TemperamentTypeId
    WHERE(sr.SurveyId IN (8, 9,13,14,19,20)) AND (sr.SurveyState = 3)
    GROUP BY scs.DfnSurveyCriteriaId, sr.TermId, sr.SolvedUserId, sr.SchoolLevel, sr.SolvedUserTemperamentId,crt.SurveyCriteriaName,sr.SurveyState,sr.SurveyId
GO
/****** Object:  View [dbo].[VLeadershipEvaluation]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VLeadershipEvaluation]
AS
SELECT        
lr.UserId, 
lr.GeneralLeadershipScoreAvg, 
lr.NaturalLeadershipScoreAvg, 
lr.SyntheticLeadershipScoreAvg, 
lr.SelfEveluationScoreAvg, 
lr.PerceivedEveluationScoreAvg, 
dbo.GetMeritLevel(lr.GeneralLeadershipScoreAvg,0,0) AS GeneralLeadershipScoreAvgLevel,
dbo.GetMeritLevel(lr.NaturalLeadershipScoreAvg,0,0) AS NaturalLeadershipScoreAvgLevel,
dbo.GetMeritLevel(lr.SyntheticLeadershipScoreAvg,0,0) AS SyntheticLeadershipScoreAvgLevel, 
dbo.GetMeritLevel(lr.SelfEveluationScoreAvg,0,0) AS SelfEveluationScoreAvgLevel, 
dbo.GetMeritLevel(lr.PerceivedEveluationScoreAvg,0,0) AS PerceivedEveluationScoreAvgLevel, 
l.LeadershipTypeId AS NaturalLeadershipTypeId, 
ld.LeadershipName AS NaturalLeadershipName, 
ld.LeadershipName_US AS NaturalLeadershipName_US, 
ld.LeadershipDescription AS NaturalLeadershipDescription,
ld.LeadershipDescription_US AS NaturalLeadershipDescription_US
FROM  dbo.VLeadershipResultAvg AS lr 
LEFT OUTER JOIN dbo.HrLeadershipResults AS l ON lr.UserId = l.UserId AND l.IsNaturalLeadership = 1 
LEFT OUTER JOIN dbo.HrLeadershipDescriptions AS ld ON l.LeadershipTypeId = ld.LeadershipTypeId
GO
/****** Object:  Table [dbo].[HrMeritDevelopmentTracking]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrMeritDevelopmentTracking](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[EvaluationCategoryId] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[GeneralScore] [tinyint] NULL,
	[SelfScore] [tinyint] NULL,
	[PerceivedScore] [tinyint] NULL,
	[TemperamentScore] [tinyint] NULL,
	[IsLastEveluation] [tinyint] NULL,
	[CreateDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_HrMeritDevelopmentTracking] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VHrMeritEvaluationAvg]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VHrMeritEvaluationAvg]
AS
SELECT        
	zz.UserId, 
	zz.EvaluationCategoryId as CategoryID, 
	zz.PerceivedScore AS CriteriaPerceivedEveluationAvg,
	zz.SelfScore AS CriteriaSelfEveluationAvg,
	zz.GeneralScore AS CriteriaScoreAvg,
	zz.TemperamentScore as CriteriaTemperamentScore,
	CAST(0 as tinyint)  as CriteriaEveluationAvg,
	dbo.GetScoreLevel(zz.GeneralScore) AS CriteriaScoreAvgLevel, 
	dbo.GetScoreDegree(zz.GeneralScore) AS CriteriaScoreAvgDegree,
	zz.CriteriaId, 
	cr.CriteriaName, 
	cr.CriteriaName_US, 
	cr.CriteriaDescription, 
	cr.CriteriaDescription_US, 
	ctx.EvaluationText, 
	ctx.EvaluationText_US,
	u.NameSurname, 
	u.PositionId, 
	u.PositionName, 
	u.DepartmentName, 
	u.DepartmentId, 
	u.OrganisationId, 
	u.OrganisationName, 
	u.TemperamentTypeId, 
	u.TemperamentTypeName, 
	u.TemperamentTypeName_US, 
	u.RoleId, 
	u.RoleName,
	 u.RoleName_US, 
	ct.CategoryName,
	ct.CategoryName_US
    FROM dbo.HrMeritDevelopmentTracking AS zz
	INNER JOIN dbo.VUser AS u ON zz.UserId = u.Id 
	INNER JOIN dbo.HrCriterias AS cr ON zz.CriteriaId = cr.Id 
	INNER JOIN dbo.HrCategories AS ct ON zz.EvaluationCategoryId = ct.Id 
	INNER JOIN dbo.HrCriteriaEvaluationTexts AS ctx ON zz.CriteriaId = ctx.CriteriaId AND zz.EvaluationCategoryId = ctx.CategoryId AND ctx.EvaluationLevel = dbo.GetScoreLevel(zz.GeneralScore)
	where zz.IsLastEveluation=1
	
GO
/****** Object:  View [dbo].[VHrMeritEvaluationAvgDevelopmentTracking]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[VHrMeritEvaluationAvgDevelopmentTracking]
AS
SELECT        
	UserId, 
	CriteriaId, 
	c.CriteriaName,
	c.CriteriaName_US,
	c.CriteriaDescription,
	c.CriteriaDescription_US,
	EvaluationCategoryId as CategoryId, 
	GeneralScore,
	SelfScore,
	PerceivedScore,
	TemperamentScore,
	CreateDate
    FROM dbo.HrMeritDevelopmentTracking t
	join HrCriterias c on t.CriteriaId=c.Id

GO
/****** Object:  Table [dbo].[HrMeritScores]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrMeritScores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RatedUserID] [uniqueidentifier] NOT NULL,
	[EvaluatedUserId] [uniqueidentifier] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[AnswerID] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[Score] [tinyint] NOT NULL,
	[TemperamentScore] [tinyint] NULL,
	[RawScore] [tinyint] NULL,
	[TemperamentManipulationType] [tinyint] NULL,
 CONSTRAINT [PK_HrMeritScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VHrMeritEvaluationAvgTracking]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VHrMeritEvaluationAvgTracking]
AS
SELECT        
	EvaluatedUserId, 
	ss.CriteriaId, 
	CategoryID, 
	CAST((ROUND(AVG(CASE WHEN ss.CategoryID <> 41 THEN ss.Score END), 0)) AS int) AS CriteriaPerceivedEveluationAvg, 
    CAST(ROUND(AVG(CASE WHEN ss.CategoryID = 41 THEN ss.Score END), 0) AS int) AS CriteriaSelfEveluationAvg, 
	CAST(ROUND(AVG(ss.Score)*0.6 + AVG(ss.TemperamentScore) *0.4, 0) AS int) AS CriteriaEveluationAvg,
	AVG(ss.TemperamentScore) as TemperamentScore
    FROM dbo.HrMeritScores AS ss
	INNER JOIN dbo.HrUserLastSurveyAnswers AS ula ON ss.EvaluatedUserId = ula.EveluatedUserID AND ss.AnswerID = ula.AnswerId 
	GROUP BY 
	EvaluatedUserId,
	CriteriaId, 
	CategoryID,
	TemperamentScore
GO
/****** Object:  View [dbo].[VHrMeritAvg]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VHrMeritAvg]
AS
SELECT        
UserId, 
NameSurname,
TemperamentTypeName,
TemperamentTypeName_US,
TemperamentTypeId,
PositionName, 
DepartmentName, 
DepartmentId,
OrganisationName,
OrganisationId,
PositionId,
CAST(AVG(CriteriaScoreAvg) AS int) AS GeneralAvg, 
dbo.GetScoreLevel(CAST(AVG(CriteriaScoreAvg) AS int)) AS GeneralAvgLevel, 
dbo.GetScoreDegree(CAST(AVG(CriteriaScoreAvg) AS int)) AS GeneralAvgDegree, 
CAST(AVG(CriteriaEveluationAvg) AS int) AS EveluationAvg, 
dbo.GetScoreLevel(CAST(AVG(CriteriaEveluationAvg) AS int)) AS EveluationAvgLevel, 
dbo.GetScoreDegree(CAST(AVG(CriteriaEveluationAvg) AS int)) AS EveluationAvgDegree, 
CAST(AVG(CriteriaSelfEveluationAvg) AS int) AS SelfEveluationAvg, 
dbo.GetScoreLevel(CAST(AVG(CriteriaSelfEveluationAvg) AS int)) AS SelfEveluationAvgLevel, 
dbo.GetScoreDegree(CAST(AVG(CriteriaSelfEveluationAvg) AS int)) AS SelfEveluationAvgDegree, 
CAST(AVG(CriteriaPerceivedEveluationAvg) AS int) AS PerceivedEveluationAvg, 
dbo.GetScoreLevel(CAST(AVG(CriteriaPerceivedEveluationAvg) AS int)) AS PerceivedEveluationAvgLevel, 
dbo.GetScoreDegree(CAST(AVG(CriteriaPerceivedEveluationAvg) AS int)) AS PerceivedEveluationAvgDegree
FROM  dbo.VHrMeritEvaluationAvg AS sa
GROUP BY 
UserId,
PositionName, 
DepartmentName,
DepartmentId,
PositionId,
NameSurname,
TemperamentTypeName,
TemperamentTypeId,
OrganisationName,
OrganisationId,
TemperamentTypeName_US
GO
/****** Object:  View [dbo].[VHrMeritAvgDevelopmentTracking]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VHrMeritAvgDevelopmentTracking]
AS
SELECT        
	UserId, 
	Avg(GeneralScore) as GeneralScore,
	Avg(SelfScore) as SelfScore,
	Avg(PerceivedScore) as PerceivedScore,
	Avg(TemperamentScore) as TemperamentScore,
	CreateDate
    FROM dbo.HrMeritDevelopmentTracking t
	group by 
	UserId,
	CreateDate


GO
/****** Object:  Table [dbo].[HrSocialQualificationDevelopmentTracking]    Script Date: 14.11.2019 09:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrSocialQualificationDevelopmentTracking](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[EvaluationCategoryId] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[GeneralScore] [tinyint] NULL,
	[SelfScore] [tinyint] NULL,
	[PerceivedScore] [tinyint] NULL,
	[TemperamentScore] [tinyint] NULL,
	[IsLastEveluation] [tinyint] NULL,
	[CreateDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_HrSocialQualificationDevelopmentTracking] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VHrSocialQualificationEvaluationAvg]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[VHrSocialQualificationEvaluationAvg]
AS
	SELECT        
	zz.UserId, 
	zz.EvaluationCategoryId as CategoryID, 
	zz.PerceivedScore AS CriteriaPerceivedEveluationAvg,
	zz.SelfScore AS CriteriaSelfEveluationAvg,
	zz.GeneralScore AS CriteriaScoreAvg,
	zz.TemperamentScore as CriteriaTemperamentScore,
	CAST(0 as tinyint)  as CriteriaEveluationAvg,
	dbo.GetScoreLevel(zz.GeneralScore) AS CriteriaScoreAvgLevel, 
	dbo.GetScoreDegree(zz.GeneralScore) AS CriteriaScoreAvgDegree,
	zz.CriteriaId, 
	cr.CriteriaName, 
	cr.CriteriaDescription, 
	ctx.EvaluationText, 
	cr.CriteriaName_US, 
	cr.CriteriaDescription_US, 
	ctx.EvaluationText_US, 
	u.NameSurname, 
	u.PositionId, 
	u.PositionName, 
	u.DepartmentName, 
	u.DepartmentId, 
	u.OrganisationId, 
	u.OrganisationName, 
	u.TemperamentTypeId, 
	u.TemperamentTypeName, 
	u.TemperamentTypeName_US,
	u.RoleId, 
	u.RoleName, 
	ct.CategoryName,
	u.RoleName_US, 
	ct.CategoryName_US
    FROM dbo.HrSocialQualificationDevelopmentTracking AS zz
	INNER JOIN dbo.VUser AS u ON zz.UserId = u.Id 
	INNER JOIN dbo.HrCriterias AS cr ON zz.CriteriaId = cr.Id 
	INNER JOIN dbo.HrCategories AS ct ON zz.EvaluationCategoryId = ct.Id 
	INNER JOIN dbo.HrCriteriaEvaluationTexts AS ctx ON zz.CriteriaId = ctx.CriteriaId AND zz.EvaluationCategoryId = ctx.CategoryId AND ctx.EvaluationLevel = dbo.GetScoreLevel(zz.GeneralScore)
	where zz.IsLastEveluation=1
GO
/****** Object:  View [dbo].[VHrSocialQualificationEvaluationAvgDevelopmentTracking]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[VHrSocialQualificationEvaluationAvgDevelopmentTracking]
AS
SELECT        
	UserId, 
	CriteriaId, 
	c.CriteriaName,
	c.CriteriaDescription,
	c.CriteriaName_US,
	c.CriteriaDescription_US,
	EvaluationCategoryId as CategoryId, 
	GeneralScore,
	SelfScore,
	PerceivedScore,
	TemperamentScore,
	CreateDate
    FROM dbo.HrSocialQualificationDevelopmentTracking t
	join HrCriterias c on t.CriteriaId=c.Id

GO
/****** Object:  Table [dbo].[HrSocialQualificationScores]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrSocialQualificationScores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RatedUserID] [uniqueidentifier] NOT NULL,
	[EvaluatedUserId] [uniqueidentifier] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[AnswerID] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[Score] [tinyint] NOT NULL,
	[TemperamentScore] [tinyint] NULL,
	[RawScore] [tinyint] NULL,
	[TemperamentManipulationType] [tinyint] NULL,
 CONSTRAINT [PK_HrSocialQualificationScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VHrSocialQualificationEvaluationAvgTracking]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create VIEW [dbo].[VHrSocialQualificationEvaluationAvgTracking]
AS
SELECT        
	EvaluatedUserId, 
	ss.CriteriaId, 
	CategoryID, 
	CAST((ROUND(AVG(CASE WHEN ss.CategoryID <> 54 THEN ss.Score END), 0)) AS int) AS CriteriaPerceivedEveluationAvg, 
    CAST(ROUND(AVG(CASE WHEN ss.CategoryID = 54 THEN ss.Score END), 0) AS int) AS CriteriaSelfEveluationAvg, 
	CAST(ROUND(AVG(ss.Score)*0.6 + AVG(ss.TemperamentScore) *0.4, 0) AS int) AS CriteriaEveluationAvg,
	AVG(ss.TemperamentScore) as TemperamentScore
    FROM dbo.HrSocialQualificationScores AS ss
	INNER JOIN dbo.HrUserLastSurveyAnswers AS ula ON ss.EvaluatedUserId = ula.EveluatedUserID AND ss.AnswerID = ula.AnswerId 
	GROUP BY 
	EvaluatedUserId,
	CriteriaId, 
	CategoryID,
	TemperamentScore
GO
/****** Object:  View [dbo].[VHrSocialQualificationAvg]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VHrSocialQualificationAvg]
AS
SELECT        
UserId, 
NameSurname,
TemperamentTypeName,
TemperamentTypeName_US,
TemperamentTypeId,
PositionName, 
DepartmentName, 
DepartmentId,
OrganisationName,
OrganisationId,
PositionId,
CAST(AVG(CriteriaScoreAvg) AS int) AS GeneralAvg, 
dbo.GetScoreLevel(CAST(AVG(CriteriaScoreAvg) AS int)) AS GeneralAvgLevel, 
dbo.GetScoreDegree(CAST(AVG(CriteriaScoreAvg) AS int)) AS GeneralAvgDegree, 
CAST(AVG(CriteriaEveluationAvg) AS int) AS EveluationAvg, 
dbo.GetScoreLevel(CAST(AVG(CriteriaEveluationAvg) AS int)) AS EveluationAvgLevel, 
dbo.GetScoreDegree(CAST(AVG(CriteriaEveluationAvg) AS int)) AS EveluationAvgDegree, 
CAST(AVG(CriteriaSelfEveluationAvg) AS int) AS SelfEveluationAvg, 
dbo.GetScoreLevel(CAST(AVG(CriteriaSelfEveluationAvg) AS int)) AS SelfEveluationAvgLevel, 
dbo.GetScoreDegree(CAST(AVG(CriteriaSelfEveluationAvg) AS int)) AS SelfEveluationAvgDegree, 
CAST(AVG(CriteriaPerceivedEveluationAvg) AS int) AS PerceivedEveluationAvg, 
dbo.GetScoreLevel(CAST(AVG(CriteriaPerceivedEveluationAvg) AS int)) AS PerceivedEveluationAvgLevel, 
dbo.GetScoreDegree(CAST(AVG(CriteriaPerceivedEveluationAvg) AS int)) AS PerceivedEveluationAvgDegree
FROM  dbo.VHrSocialQualificationEvaluationAvg AS sa
GROUP BY 
UserId,
PositionName, 
DepartmentName,
DepartmentId,
PositionId,
NameSurname,
TemperamentTypeName,
TemperamentTypeId,
OrganisationName,
OrganisationId,
TemperamentTypeName_US
GO
/****** Object:  View [dbo].[VHrSocialQualificationAvgDevelopmentTracking]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[VHrSocialQualificationAvgDevelopmentTracking]
AS
SELECT        
	UserId, 
	Avg(GeneralScore) as GeneralScore,
	Avg(SelfScore) as SelfScore,
	Avg(PerceivedScore) as PerceivedScore,
	Avg(TemperamentScore) as TemperamentScore,
	CreateDate
    FROM dbo.HrSocialQualificationDevelopmentTracking t
	group by 
	UserId,
	CreateDate


GO
/****** Object:  Table [dbo].[HrPerfectionDevelopmentTracking]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrPerfectionDevelopmentTracking](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[EvaluationCategoryId] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[GeneralScore] [tinyint] NULL,
	[SelfScore] [tinyint] NULL,
	[PerceivedScore] [tinyint] NULL,
	[TemperamentScore] [tinyint] NULL,
	[IsLastEveluation] [tinyint] NULL,
	[CreateDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_HrPerfectionDevelopmentTracking] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrPerfectionEvaluationTexts]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrPerfectionEvaluationTexts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[Level] [int] NOT NULL,
	[EvaluationLevel] [int] NOT NULL,
	[EvaluationText] [nvarchar](max) NULL,
	[EvaluationText_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_HrPerfectionEvaluationTexts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrPerfections]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrPerfections](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AbilityName] [nvarchar](max) NULL,
	[AbilityName_US] [nvarchar](max) NULL,
	[AbilityDescription] [nvarchar](max) NULL,
	[AbilityDescription_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_HrPerfections] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VHrPerfectionEvaluationAvg]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[VHrPerfectionEvaluationAvg]
AS
SELECT        
	zz.UserId, 
	zz.EvaluationCategoryId as CategoryID, 
	zz.PerceivedScore AS CriteriaPerceivedEveluationAvg,
	zz.SelfScore AS CriteriaSelfEveluationAvg,
	zz.GeneralScore AS CriteriaScoreAvg,
	zz.TemperamentScore as CriteriaTemperamentScore,
	CAST(0 as tinyint)  as CriteriaEveluationAvg,
	dbo.GetScoreLevel(zz.GeneralScore) AS CriteriaScoreAvgLevel, 
	dbo.GetScoreDegree(zz.GeneralScore) AS CriteriaScoreAvgDegree,
	zz.CriteriaId, 
	cr.AbilityName as CriteriaName, 
	cr.AbilityName_US as CriteriaName_US, 
	cr.AbilityDescription as CriteriaDescription, 
	cr.AbilityDescription_US as CriteriaDescription_US, 
	ctx.EvaluationText, 
	ctx.EvaluationText_US, 
	u.NameSurname, 
	u.PositionId, 
	u.PositionName, 
	u.DepartmentName, 
	u.DepartmentId, 
	u.OrganisationId, 
	u.OrganisationName, 
	u.TemperamentTypeId, 
	u.TemperamentTypeName, 
	u.TemperamentTypeName_US,
	u.RoleId, 
	u.RoleName, 
	ct.CategoryName,
	u.RoleName_US, 
	ct.CategoryName_US
    FROM dbo.HrPerfectionDevelopmentTracking AS zz
	INNER JOIN dbo.VUser AS u ON zz.UserId = u.Id 
	INNER JOIN dbo.HrPerfections AS cr ON zz.CriteriaId = cr.Id 
	INNER JOIN dbo.HrCategories AS ct ON zz.EvaluationCategoryId = ct.Id 
	INNER JOIN dbo.HrPerfectionEvaluationTexts AS ctx ON zz.CriteriaId = ctx.CriteriaId and ctx.[Level]=(case when u.PositionLevel is not null then u.PositionLevel else 1 end) AND ctx.EvaluationLevel = dbo.GetScoreLevel(zz.GeneralScore)
	where zz.IsLastEveluation=1
GO
/****** Object:  View [dbo].[VHrPerfectionEvaluationAvgDevelopmentTracking]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[VHrPerfectionEvaluationAvgDevelopmentTracking]
AS
SELECT        
	UserId, 
	CriteriaId, 
	c.CriteriaName,
	c.CriteriaDescription,
	c.CriteriaName_US,
	c.CriteriaDescription_US,
	EvaluationCategoryId as CategoryId, 
	GeneralScore,
	SelfScore,
	PerceivedScore,
	TemperamentScore,
	CreateDate
    FROM dbo.HrPerfectionDevelopmentTracking t
	join HrCriterias c on t.CriteriaId=c.Id

GO
/****** Object:  Table [dbo].[HrPerfectionScores]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrPerfectionScores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RatedUserID] [uniqueidentifier] NOT NULL,
	[EvaluatedUserId] [uniqueidentifier] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[PositionLevel] [tinyint] NOT NULL,
	[AnswerID] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[Score] [tinyint] NOT NULL,
	[TemperamentScore] [tinyint] NULL,
	[RawScore] [tinyint] NULL,
	[TemperamentManipulationType] [tinyint] NULL,
 CONSTRAINT [PK_HrPerfectionScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VHrPerfectionEvaluationAvgTracking]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VHrPerfectionEvaluationAvgTracking]
AS
SELECT        
	EvaluatedUserId, 
	ss.CriteriaId, 
	CategoryID, 
	CAST((ROUND(AVG(CASE WHEN ss.CategoryID <> 48 THEN ss.Score END), 0)) AS int) AS CriteriaPerceivedEveluationAvg, 
    CAST(ROUND(AVG(CASE WHEN ss.CategoryID = 48 THEN ss.Score END), 0) AS int) AS CriteriaSelfEveluationAvg, 
	CAST(ROUND(AVG(ss.Score)*0.6 + AVG(ss.TemperamentScore) *0.4, 0) AS int) AS CriteriaEveluationAvg,
	AVG(ss.TemperamentScore) as TemperamentScore
    FROM dbo.HrPerfectionScores AS ss
	INNER JOIN dbo.HrUserLastSurveyAnswers AS ula ON ss.EvaluatedUserId = ula.EveluatedUserID AND ss.AnswerID = ula.AnswerId 
	GROUP BY 
	EvaluatedUserId,
	CriteriaId, 
	CategoryID,
	TemperamentScore
GO
/****** Object:  View [dbo].[VHrPerfectionAvg]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VHrPerfectionAvg]
AS
SELECT        
UserId, 
NameSurname,
TemperamentTypeName,
TemperamentTypeName_US,
TemperamentTypeId,
PositionName, 
DepartmentName, 
DepartmentId,
OrganisationName,
OrganisationId,
PositionId,
CAST(AVG(CriteriaScoreAvg) AS int) AS GeneralAvg, 
dbo.GetScoreLevel(CAST(AVG(CriteriaScoreAvg) AS int)) AS GeneralAvgLevel, 
dbo.GetScoreDegree(CAST(AVG(CriteriaScoreAvg) AS int)) AS GeneralAvgDegree, 
CAST(AVG(CriteriaEveluationAvg) AS int) AS EveluationAvg, 
dbo.GetScoreLevel(CAST(AVG(CriteriaEveluationAvg) AS int)) AS EveluationAvgLevel, 
dbo.GetScoreDegree(CAST(AVG(CriteriaEveluationAvg) AS int)) AS EveluationAvgDegree, 
CAST(AVG(CriteriaSelfEveluationAvg) AS int) AS SelfEveluationAvg, 
dbo.GetScoreLevel(CAST(AVG(CriteriaSelfEveluationAvg) AS int)) AS SelfEveluationAvgLevel, 
dbo.GetScoreDegree(CAST(AVG(CriteriaSelfEveluationAvg) AS int)) AS SelfEveluationAvgDegree, 
CAST(AVG(CriteriaPerceivedEveluationAvg) AS int) AS PerceivedEveluationAvg, 
dbo.GetScoreLevel(CAST(AVG(CriteriaPerceivedEveluationAvg) AS int)) AS PerceivedEveluationAvgLevel, 
dbo.GetScoreDegree(CAST(AVG(CriteriaPerceivedEveluationAvg) AS int)) AS PerceivedEveluationAvgDegree
FROM  dbo.VHrPerfectionEvaluationAvg AS sa
GROUP BY 
UserId,
PositionName, 
DepartmentName,
DepartmentId,
PositionId,
NameSurname,
TemperamentTypeName,
TemperamentTypeId,
OrganisationName,
OrganisationId,
TemperamentTypeName_US
GO
/****** Object:  View [dbo].[VHrPerfectionAvgDevelopmentTracking]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[VHrPerfectionAvgDevelopmentTracking]
AS
SELECT        
	UserId, 
	Avg(GeneralScore) as GeneralScore,
	Avg(SelfScore) as SelfScore,
	Avg(PerceivedScore) as PerceivedScore,
	Avg(TemperamentScore) as TemperamentScore,
	CreateDate
    FROM dbo.HrPerfectionDevelopmentTracking t
	group by 
	UserId,
	CreateDate


GO
/****** Object:  Table [dbo].[SelectedStudentConsultancies]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SelectedStudentConsultancies](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LeaderTeacherUserId] [uniqueidentifier] NOT NULL,
	[StudentUserId] [uniqueidentifier] NOT NULL,
	[StudentTemperamentId] [int] NOT NULL,
	[ClassId] [uniqueidentifier] NOT NULL,
	[TermId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SelectedStudentConsultancies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnSurveyCategories]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnSurveyCategories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SurveyCategoryName] [nvarchar](max) NULL,
	[SurveyCategoryName_US] [nvarchar](max) NULL,
	[DfnSurveyCategoryTypeId] [int] NOT NULL,
	[CategoryDescription] [nvarchar](max) NULL,
	[CategoryDescription_Us] [nvarchar](max) NULL,
	[CategoryNickname] [nvarchar](max) NULL,
	[CategoryNickname_Us] [nvarchar](max) NULL,
 CONSTRAINT [PK_DfnSurveyCategories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VSurveysNeedConsultancy]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VSurveysNeedConsultancy]
AS

select 
	  SelectedStudentConsultancies.IsActive
	 ,aa.TermId
     ,aa.SolvedUserId
	 ,aa.DfnSurveyCriteriaIdorGroupId  as DfnSurveyCriteriaIdorGroupId
	 ,temp.Id as SolvedUserTemperamentId
	 ,temp.TemperamentTypeName as SolvedUserTemperament
	 ,temp.TemperamentTypeName_US as SolvedUserTemperament_US
	 ,aa.SurveyCriteriaNameOrGroupName as SurveyCriteriaNameOrGroupName
	 ,aa.SurveyCriteriaNameOrGroupName_US as SurveyCriteriaNameOrGroupName_US
	 ,DfnSurveyCategories.SurveyCategoryName as CategoriaName
	 ,DfnSurveyCategories.SurveyCategoryName_US as CategoriaName_US
	 ,aa.CategoryId as CategoryId
	 ,aa.ScoreLevel as ScoreLevel
	 ,CAST(case when aa.Score is null then 0 else aa.Score end as int) as Score
	 ,Users.Name as studentName
	 ,UserOrganizationRoles.OrganizationId
	 ,Organizations.Name as className
	 ,SelectedStudentConsultancies.Id as TeacherListId 
	 ,Case when Users.Sex = 1 then 'Erkek' else 'Kız' end As Sex
	 ,Case when Users.Sex = 1 then 'Male' else 'Female' end As Sex_US,
	 	 Users.Sex as SexType
	 ,UserOrganizationRoles.Id as UserOrganizationRoleId  from (
  SELECT
     0 as groupId,
	 mental.TermId
     ,mental.SolvedUserId
	 ,mental.DfnSurveyCriteriaId  as DfnSurveyCriteriaIdorGroupId
	 ,mental.SurveyCriteriaName as SurveyCriteriaNameOrGroupName
	 ,mental.SurveyCriteriaName_US as SurveyCriteriaNameOrGroupName_US
	 ,mental.NormStatus as ScoreLevel
	 ,4 as CategoryId
	 ,CAST(mental.Score as int) as Score
  FROM VMentalCriteriaScore mental WITH (NOLOCK)
  where ContentType = 0 and NormStatus in (5) and Score is not null
  union
  SELECT 0 as groupId,
      personality.TermId
      ,personality.SolvedUserId
	  ,personality.DfnSurveyCriteriaId as DfnSurveyCriteriaIdorGroupId
      ,personality.SurveyCriteriaName as SurveyCriteriaNameOrGroupName
	  ,personality.SurveyCriteriaName_US as SurveyCriteriaNameOrGroupName_US
	  ,personality.ScoreLevel as ScoreLevel
	  ,1 as CategoryId

	  ,CAST(personality.Score as int) as Score
  FROM VPersonalityDevelopmentCriteriaScore personality WITH (NOLOCK)
  where personality.IsNatural = 1 and personality.Score is not null and (ScoreLevel in (4,5) or (personality.IsExcessive = 1 and ScoreLevel = 1)) 
  union 
SELECT 1 as groupId,
	   social.TermId
	  ,social.SolvedUserId
      ,social.CriteriaGroupId as DfnSurveyCriteriaIdorGroupId
	  ,social.GroupName as SurveyCriteriaNameOrGroupName
	  ,social.GroupName_US as SurveyCriteriaNameOrGroupName_US
      ,social.normstatu as ScoreLevel
	  ,3 as CategoryId
	  ,Cast(social.StudentGroupScore as int) as Score
  FROM VSocialSkillGroupScore social WITH (NOLOCK)
  where social.ContentType = 0 and social.normstatu = 5 and social.StudentGroupScore is not null 
  union 
  SELECT 
  0 as groupId,
	   merit.TermId
	  ,merit.SolvedUserId
	  ,merit.DfnSurveyCriteriaId as DfnSurveyCriteriaIdorGroupId
	  ,merit.SurveyCriteriaName as SurveyCriteriaNameOrGroupName
	  ,merit.SurveyCriteriaName_US as SurveyCriteriaNameOrGroupName_US
	 ,dbo.GetMeritLevel(merit.Score,0,0) as ScoreLevel
	  ,6 as CategoryId

	  ,Cast(merit.Score as int) as Score
  FROM VMeritCriteriaScore merit WITH (NOLOCK)
  where (merit.Score is not null and ((merit.IsNatural = 0 and merit.ScoreLevel = 5) or (merit.IsNatural = 1 and merit.ScoreLevel = 1 )))
  union
  	 SELECT
	  0 as groupId,
	  global.TermId,
	  global.SolvedUserId,
	  global.DfnSurveyCriteriaId as DfnSurveyCriteriaIdorGroupId,
      global.SurveyCriteriaName as SurveyCriteriaNameOrGroupName,
	  global.SurveyCriteriaName_US as SurveyCriteriaNameOrGroupName_US,
	  global.ScoreLevel,
	  7 as CategoryId,
	  Cast(global.Score as int) as Score
  FROM VGlobalLifeSkillsScore as global WITH (NOLOCK)
  where global.ContentType = 1 and global.ScoreLevel = 5 and global.Score is not null
  union 
	SELECT 
	  0 as groupId,
	   universal.TermId
      ,universal.SolvedUserId
	  ,universal.DfnSurveyCriteriaId as DfnSurveyCriteriaIdorGroupId
      ,universal.SurveyCriteriaName as SurveyCriteriaNameOrGroupName
	  ,universal.SurveyCriteriaName_US as SurveyCriteriaNameOrGroupName_US
	  ,universal.ScoreLevel as ScoreLevel
	  ,9 as CategoryId
	  ,CAST(universal.Score as int) as Score
  FROM dbo.VUniversalLifeSkillsScore as universal WITH (NOLOCK)
	where universal.ContentType = 1 and universal.ScoreLevel = 5 and universal.Score is not null) as aa
	
	Left Join Users WITH (NOLOCK) on Users.Id = aa.SolvedUserId and Users.IsActive = 1
    Left Join UserOrganizationRoles WITH (NOLOCK) on UserOrganizationRoles.UserId = aa.SolvedUserId and UserOrganizationRoles.IsActive = 1
    Left Join Organizations WITH (NOLOCK) on Organizations.Id = UserOrganizationRoles.OrganizationId
    Left Join SelectedStudentConsultancies WITH (NOLOCK) on SelectedStudentConsultancies.StudentUserId = Users.Id
    Left Join DfnSurveyCriterias WITH (NOLOCK) on DfnSurveyCriterias.Id = aa.DfnSurveyCriteriaIdorGroupId and aa.groupId  = 0
    Left Join DfnSurveyCriteriaGroups WITH (NOLOCK) on DfnSurveyCriteriaGroups.Id = aa.DfnSurveyCriteriaIdorGroupId and aa.groupId = 1 
    Left Join DfnSurveyCategories WITH (NOLOCK) on DfnSurveyCategories.Id = aa.CategoryId
    left join DfnTemperamentTypes temp WITH (NOLOCK) on temp.Id = Users.TemperamentTypeId 
GO
/****** Object:  Table [dbo].[SelectedStudentConsultancyCriterias]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SelectedStudentConsultancyCriterias](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CriteriaId] [int] NULL,
	[GroupId] [int] NULL,
	[StatusId] [int] NOT NULL,
	[SelectedStudentConsultancyId] [int] NULL,
 CONSTRAINT [PK_SelectedStudentConsultancyCriterias] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SelectedStudentConsultancyNotes]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SelectedStudentConsultancyNotes](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Note] [nvarchar](max) NULL,
	[SelectedStudentConsultancyCriteriasId] [int] NULL,
 CONSTRAINT [PK_SelectedStudentConsultancyNotes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VLeaderTeacherConsultancyList]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VLeaderTeacherConsultancyList]
AS
SELECT
   ssc.IsActive as isActive,
   ssc.Id AS SelectedStudentConsultancyId,
   ssc.LeaderTeacherUserId as LeaderTeacherUserId,
   ssc.StudentUserId as StudentUserId,
   CONCAT(uTeacher.Name, ' ',uTeacher.Surname) as LeaderTeacherName,
   uStudent.NAME AS StudentName,
   temp.Id as StudentTemperamentId,
   temp.TemperamentTypeName as StudentTemperament,
   temp.TemperamentTypeName_US as StudentTemperament_US,
   ssc.ClassId,
   org.NAME AS OrganizationName,
   ssc.TermId,
   sscc.Id AS SelectedStudentConsultancyCriteriaId,
   sscc.CriteriaId as CriteriaId,
   sscc.GroupId as GroupId,
   Case when sscc.CriteriaId is null then DfnSurveyCriteriaGroups.GroupName else dsc.SurveyCriteriaName end as CriteriaName,
   dsc.SurveyCriteriaName_US as CriteriaName_US,
   DfnSurveyCategories.Id as CategoryId,
   DfnSurveyCategories.SurveyCategoryName as CriteriaCategoryName,
   DfnSurveyCategories.SurveyCategoryName_US as CriteriaCategoryName_US,
   sscc.StatusId as Status,
   sscn.Id AS SelectedStudentConsultancyNoteId,
   sscn.note as Note,
   sscn.DateCreated as NoteAddedDate
FROM
   dbo.selectedstudentconsultancies AS ssc 
   LEFT OUTER JOIN dbo.selectedstudentconsultancycriterias AS sscc ON sscc.SelectedStudentConsultancyId = ssc.Id
   LEFT OUTER JOIN dbo.selectedstudentconsultancynotes AS sscn ON sscn.SelectedStudentConsultancyCriteriasId = sscc.Id 
   LEFT OUTER JOIN dbo.organizations AS org ON ssc.ClassId = org.Id 
   LEFT OUTER JOIN dbo.dfnsurveycriterias AS dsc ON dsc.Id = sscc.CriteriaId 
   Left join DfnSurveyCriteriaGroups on (DfnSurveyCriteriaGroups.Id = dsc.CriteriaGroupId or DfnSurveyCriteriaGroups.Id = sscc.GroupId)
   Left Join DfnSurveyCategories on DfnSurveyCategories.Id = DfnSurveyCriteriaGroups.SurveyCategoryId
   LEFT OUTER JOIN Users uStudent ON uStudent.Id = ssc.StudentUserId 
   left join Users uTeacher on uTeacher.Id = ssc.LeaderTeacherUserId
   left join DfnTemperamentTypes temp on temp.Id = uStudent.TemperamentTypeId 
   where uStudent.TemperamentTypeId is not null 
GO
/****** Object:  Table [dbo].[HrSkillScores]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrSkillScores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RatedUserID] [uniqueidentifier] NOT NULL,
	[EvaluatedUserId] [uniqueidentifier] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[AnswerID] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[Score] [tinyint] NOT NULL,
 CONSTRAINT [PK_HrSkillScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VHrSkill]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VHrSkill]
AS
SELECT distinct
  zz.EvaluatedUserId AS UserId, 
  u.NameSurname, 
  u.PositionId, 
  u.PositionName, 
  u.DepartmentName, 
  u.DepartmentId, 
  u.OrganisationId, 
  u.OrganisationName, 
  u.TemperamentTypeId, 
  u.TemperamentTypeName,
  u.TemperamentTypeName_US
FROM 
 dbo.HrSkillScores AS zz 
 INNER JOIN dbo.VUser AS u ON zz.EvaluatedUserId = u.Id 

GO
/****** Object:  Table [dbo].[HrCategoryTags]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrCategoryTags](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryTagName] [nvarchar](max) NULL,
	[CategoryTagName_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_HrCategoryTags] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VHrSkillCategoryEvaluation]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[VHrSkillCategoryEvaluation]
AS
SELECT
  zz.EvaluatedUserId AS UserId, 
  u.NameSurname, 
  u.PositionId, 
  u.PositionName, 
  u.DepartmentName, 
  u.DepartmentId, 
  u.OrganisationId, 
  u.OrganisationName, 
  u.TemperamentTypeId, 
  u.TemperamentTypeName, 
  u.TemperamentTypeName_US, 
  u.RoleId, 
  u.RoleName, 
  ct.CategoryName, 
  u.RoleName_US, 
  ct.CategoryName_US, 
  ct.Id AS CategoryId, 
  ct.CategoryTagId,
  ctag.CategoryTagName,
  ctag.CategoryTagName_US,
  CAST(ROUND(AVG(zz.Score),0) as int) as CategoryScoreAvg, 
  CAST(ROUND(AVG(zz.Score*1.5),0) as int) as CategoryScoreNormalizedAvg,
   dbo.GetSkillDegree(CAST(ROUND(AVG(zz.Score),0) as int),'tr') as CategoryScoreNormalizedAvgDegree,
   dbo.GetSkillDegree(CAST(ROUND(AVG(zz.Score),0) as int),'us') as CategoryScoreNormalizedAvgDegree_US
FROM 
 dbo.HrSkillScores AS zz 
 INNER JOIN dbo.VUser AS u ON zz.EvaluatedUserId = u.Id 
 INNER JOIN dbo.HrUserLastSurveyAnswers AS ula ON zz.EvaluatedUserId = ula.EveluatedUserID AND zz.AnswerID = ula.AnswerId 
 INNER JOIN dbo.HrCriterias AS cr ON zz.CriteriaId = cr.Id 
 INNER JOIN dbo.HrCategories AS ct ON zz.CategoryID = ct.Id 
 INNER JOIN HrCategoryTags ctag on ct.CategoryTagId=ctag.Id
 --LEFT OUTER JOIN dbo.HrCategoryEvaluationTexts AS ctx ON zz.CriteriaId = ctx.CategoryID AND zz.CategoryID = ctx.CategoryId AND ctx.EvaluationLevel = dbo.GetSkillLevel(zz.Score)
 Group by 
   zz.EvaluatedUserId  ,
  u.NameSurname, 
  u.PositionId, 
  u.PositionName, 
  u.DepartmentName, 
  u.DepartmentId, 
  u.OrganisationId, 
  u.OrganisationName, 
  u.TemperamentTypeId, 
  u.TemperamentTypeName, 
  u.RoleId, 
  u.RoleName, 
  ct.CategoryName, 
  ct.Id,
  ct.CategoryTagId,
  ctag.CategoryTagName,
  RoleName_US,
  CategoryName_US,
  TemperamentTypeName_US,
  CategoryTagName_US

GO
/****** Object:  View [dbo].[VHrSkillCategoryTagEvaluation]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[VHrSkillCategoryTagEvaluation]
AS
SELECT
  zz.EvaluatedUserId AS UserId, 
  u.NameSurname, 
  u.PositionId, 
  u.PositionName, 
  u.DepartmentName, 
  u.DepartmentId, 
  u.OrganisationId, 
  u.OrganisationName, 
  u.TemperamentTypeId, 
  u.TemperamentTypeName, 
  u.TemperamentTypeName_US, 
  u.RoleId, 
  u.RoleName, 
  u.RoleName_US, 
  ct.CategoryTagId,
  ctag.CategoryTagName,
  ctag.CategoryTagName_US,
  CAST(ROUND(AVG(zz.Score),0) as int) as CategoryTagScoreAvg, 
  CAST(ROUND(AVG(zz.Score*1.5),0) as int) as CategoryTagScoreNormalizedAvg,
  dbo.GetSkilldegree(CAST(ROUND(AVG(zz.Score),0) as int),'tr') as CategoryTagScoreNormalizedAvgDegree,
  dbo.GetSkilldegree(CAST(ROUND(AVG(zz.Score),0) as int),'us') as CategoryTagScoreNormalizedAvgDegree_US
FROM 
 dbo.HrSkillScores AS zz 
 INNER JOIN dbo.VUser AS u ON zz.EvaluatedUserId = u.Id 
 INNER JOIN dbo.HrUserLastSurveyAnswers AS ula ON zz.EvaluatedUserId = ula.EveluatedUserID AND zz.AnswerID = ula.AnswerId 
 INNER JOIN dbo.HrCriterias AS cr ON zz.CriteriaId = cr.Id 
 INNER JOIN dbo.HrCategories AS ct ON zz.CategoryID = ct.Id 
 INNER JOIN HrCategoryTags ctag on ct.CategoryTagId=ctag.Id
 Group by 
   zz.EvaluatedUserId  ,
  u.NameSurname, 
  u.PositionId, 
  u.PositionName, 
  u.DepartmentName, 
  u.DepartmentId, 
  u.OrganisationId, 
  u.OrganisationName, 
  u.TemperamentTypeId, 
  u.TemperamentTypeName, 
  u.RoleId, 
  u.RoleName, 
  ct.CategoryTagId,
  ctag.CategoryTagName,
    ctag.CategoryTagName_US,
	  u.RoleName_US, 
	    u.TemperamentTypeName_US
GO
/****** Object:  View [dbo].[VHrSkillCriteriaEvaluation]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VHrSkillCriteriaEvaluation]
AS
SELECT
  zz.EvaluatedUserId AS UserId, 
  u.NameSurname, 
  u.PositionId, 
  u.PositionName, 
  u.DepartmentName, 
  u.DepartmentId, 
  u.OrganisationId, 
  u.OrganisationName, 
  u.TemperamentTypeId, 
  u.TemperamentTypeName, 
  u.TemperamentTypeName_US, 
  u.RoleId, 
  u.RoleName,
  u.RoleName_US, 
  ct.CategoryName, 
  ct.CategoryName_US, 
  ct.Id AS CategoryId, 
  zz.CriteriaId, 
  cr.CriteriaName, 
  cr.CriteriaName_US, 
  ct.CategoryTagId,
  ctag.CategoryTagName,
  ctag.CategoryTagName_US,
  cr.CriteriaDescription, 
  ctx.EvaluationText, 
  cr.CriteriaDescription_US, 
  ctx.EvaluationText_US, 
  zz.Score AS CriteriaScore, 
  CAST(ROUND(zz.Score * 1.5, 0) AS int) AS CriteriaScoreNormalized, 
  dbo.GetSkillLevel(zz.Score) AS CriteriaScoreNormalizedLevel, 
  dbo.GetSkillDegree(zz.Score,'tr') AS CriteriaScoreNormalizedDegree,
  dbo.GetSkillDegree(zz.Score,'us') AS CriteriaScoreNormalizedDegree_US
FROM 
 dbo.HrSkillScores AS zz 
 INNER JOIN dbo.VUser AS u ON zz.EvaluatedUserId = u.Id 
 INNER JOIN dbo.HrUserLastSurveyAnswers AS ula ON zz.EvaluatedUserId = ula.EveluatedUserID AND zz.AnswerID = ula.AnswerId 
 INNER JOIN dbo.HrCriterias AS cr ON zz.CriteriaId = cr.Id 
 INNER JOIN dbo.HrCategories AS ct ON zz.CategoryID = ct.Id 
 INNER JOIN HrCategoryTags ctag on ct.CategoryTagId=ctag.Id
 LEFT OUTER JOIN dbo.HrCriteriaEvaluationTexts AS ctx ON zz.CriteriaId = ctx.CriteriaId AND zz.CategoryID = ctx.CategoryId AND ctx.EvaluationLevel = dbo.GetSkillLevel(zz.Score)
GO
/****** Object:  Table [dbo].[Parents]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parents](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[UserParentId] [uniqueidentifier] NOT NULL,
	[UserStudentId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Parents] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VLeaderTeacherParentConsultancyList]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VLeaderTeacherParentConsultancyList]
AS
SELECT DISTINCT 
	   userStudent.Id as StudentUserId
      ,userStudent.[Name] as StudentName
      ,userStudent.[Sex] as StudentGender
      ,userStudent.[TemperamentTypeId] as StudentTempId
	  ,tempStudent.TemperamentTypeName as StudentTempName
	  ,par.UserParentId as ParentUserId
	  ,userParent.Name as ParentName
	  ,tempParent.Id as ParentTempId
	  ,tempParent.TemperamentTypeName as ParentTempName
	  ,uor.Id as StudentUORId
	  ,org.Id as StudentOrgId
	  ,org.Name as StudentOrgName
	  ,uorParent.Id as parentUORId
  FROM [dbo].[Users] as userStudent
	left join UserOrganizationRoles uor on uor.UserId = userStudent.Id and uor.TermId = (select Id from Terms where IsActive = 1)
	left join Organizations org on org.Id = uor.OrganizationId
	left join Parents par on par.UserStudentId = uor.UserId
	left join Users userParent on userParent.Id = par.UserParentId
	left join DfnTemperamentTypes tempStudent on tempStudent.Id = userStudent.TemperamentTypeId
	left join DfnTemperamentTypes tempParent on tempParent.Id = userParent.TemperamentTypeId
	left join UserOrganizationRoles uorParent on uorParent.UserId = userParent.Id
	where userStudent.TemperamentTypeId is not null and uor.RoleId = 'DEB470C7-9827-4375-B20A-BEA56511EA49' 
GO
/****** Object:  Table [dbo].[DfnGuidanceSurveys]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnGuidanceSurveys](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SurveyName] [nvarchar](max) NULL,
	[SurveyName_US] [nvarchar](max) NULL,
	[SurveyContent] [nvarchar](max) NULL,
	[SurveyContent_US] [nvarchar](max) NULL,
	[NumberOfAnswerOptions] [int] NOT NULL,
	[DfnSurveyCriteriaGroupId] [int] NOT NULL,
	[SchoolLevel] [int] NOT NULL,
	[SurveyType] [int] NOT NULL,
 CONSTRAINT [PK_DfnGuidanceSurveys] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GuidanceSurveyResults]    Script Date: 14.11.2019 09:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GuidanceSurveyResults](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SolverUserId] [uniqueidentifier] NOT NULL,
	[SolvedUserId] [uniqueidentifier] NOT NULL,
	[DfnGuidanceSurveyId] [int] NOT NULL,
	[TermId] [uniqueidentifier] NULL,
	[SchoolLevel] [int] NOT NULL,
	[SolvedUserTemperamentId] [int] NULL,
	[State] [tinyint] NOT NULL,
 CONSTRAINT [PK_GuidanceSurveyResults] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GuidanceUserSurveys]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GuidanceUserSurveys](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AssignmentUserId] [uniqueidentifier] NOT NULL,
	[EvaluatedUserId] [uniqueidentifier] NOT NULL,
	[StudentUserId] [uniqueidentifier] NOT NULL,
	[DfnGuidanceSurveyId] [int] NOT NULL,
	[StudentTemperamentId] [int] NOT NULL,
	[SurveyState] [tinyint] NOT NULL,
	[AnswerId] [int] NOT NULL,
 CONSTRAINT [PK_GuidanceUserSurveys] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VGuidanceAssignedSurvey]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VGuidanceAssignedSurvey]
AS
SELECT  
	  gus.[Id] as GuidanceUserSurveyId
      ,gus.[AssignmentUserId]
	  ,uAssign.Name as AssignmentUserName
      ,gus.[EvaluatedUserId]
	  ,uEva.Name as EvaluedUserName
	  ,rol.Id as RoleId
	  ,rol.RoleName
	  ,rol.RoleName_US
      ,gus.[DfnGuidanceSurveyId] as SurveyId
	  ,dgs.SurveyName as SurveyName
	  ,dgs.SurveyName_US 
      ,gus.[StudentTemperamentId] 
	  ,temp.TemperamentTypeName as StudentTemperamentName
	  ,temp.TemperamentTypeName_US as StudentTemperamentName_US
      ,gus.[StudentUserId]
	  ,u.Name as StudentName
	  ,gus.SurveyState as SurveyState
	  ,uor.TermId as UORTermId
	  ,org.Id as StudentOrgId
  FROM [dbo].[GuidanceUserSurveys] gus
		left join Users as u on u.Id = gus.StudentUserId
		left join DfnGuidanceSurveys dgs on dgs.Id = gus.DfnGuidanceSurveyId
		left join DfnTemperamentTypes temp on temp.Id = gus.StudentTemperamentId
		left join Users uEva on uEva.Id = gus.EvaluatedUserId
		left join Users uAssign on uAssign.Id = gus.AssignmentUserId
		left join GuidanceSurveyResults sr on sr.SolvedUserId = gus.StudentUserId and sr.SolverUserId = gus.EvaluatedUserId and sr.SolvedUserTemperamentId = gus.StudentTemperamentId
		left join UserOrganizationRoles uor on uor.UserId = uEva.Id and uor.TermId=(Select Id from Terms t where t.IsActive=1 ) and uor.IsDeleted=0
		left join Roles rol on rol.Id = uor.RoleId
		left join UserOrganizationRoles uorStudent on uorStudent.UserId = gus.StudentUserId and uorStudent.TermId=(Select Id from Terms t where t.IsActive=1 ) and uorStudent.IsDeleted=0
		left join Organizations org on org.Id = uorStudent.OrganizationId
		where gus.IsActive = 1
GO
/****** Object:  Table [dbo].[HrGeneralMeritDevelopmentTracking]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrGeneralMeritDevelopmentTracking](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[EvaluationCategoryId] [int] NOT NULL,
	[GeneralScore] [tinyint] NOT NULL,
	[SelfScore] [tinyint] NULL,
	[PerceivedScore] [tinyint] NULL,
	[TemperamentScore] [tinyint] NULL,
	[PositionId] [int] NOT NULL,
	[PositionLevel] [tinyint] NOT NULL,
	[IsLastEveluation] [tinyint] NULL,
	[CreateDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_HrGeneralMeritDevelopmentTracking] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VHrGeneralMeritDevelopmentTracking]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VHrGeneralMeritDevelopmentTracking]
AS
SELECT        
	zz.UserId, 
	zz.PerceivedScore AS PerceivedScore,
	zz.SelfScore AS SelfScore,
	zz.GeneralScore AS GeneralScore,
	zz.TemperamentScore as TemperamentScore,
	u.NameSurname, 
	u.PositionId, 
	u.PositionName, 
	u.DepartmentName, 
	u.DepartmentId, 
	u.OrganisationId, 
	u.OrganisationName, 
	u.TemperamentTypeId, 
	u.TemperamentTypeName,
	u.TemperamentTypeName_US,
	zz.IsLastEveluation,
	zz.CreateDate
    FROM dbo.HrGeneralMeritDevelopmentTracking AS zz
	INNER JOIN dbo.VUser AS u ON zz.UserId = u.Id 
	
GO
/****** Object:  Table [dbo].[TalentIntelligenceTemperamentCategoryScores]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TalentIntelligenceTemperamentCategoryScores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemperamentTypeId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[Score] [int] NOT NULL,
	[ScorePercent] [int] NULL,
 CONSTRAINT [PK_TalentIntelligenceTemperamentCategoryScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VTalentIntelligenceCategoryScore]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[VTalentIntelligenceCategoryScore]
AS

select zz.UserId,
            SurveyId,
            SolvedUserTemperamentId,
            TermId,
            SolvedUserAge,
            ClassNo,
			SurveyCriteriaName_US,
			SurveyCriteriaDescription_US,
            SurveyCriteriaName,
            SurveyCriteriaDescription,
            DfnSurveyCriteriaId, 
			cast (round(zz.Score*0.5+ts.ScorePercent*0.5,0) as integer) as Score,
			cast (round(zz.Score*0.5+ts.ScorePercent*0.5,0)*1.5 as integer) as NormalizeScore,
			dbo.GetSkillDegree(round(zz.Score*0.5+ts.ScorePercent*0.5,0),'tr') as CriteriaScoreNormalizedAvgDegree, 
			dbo.GetSkillDegree(round(zz.Score*0.5+ts.ScorePercent*0.5,0),'us') as CriteriaScoreNormalizedAvgDegree_US ,
			dbo.GetSkillNormalizeLevel(round(zz.Score*0.5+ts.ScorePercent*0.5,0) * 1.5) as CriteriaScoreLevel
	from (
			SELECT
			SolvedUserId as UserId,
            SurveyId,
            SolvedUserTemperamentId,
            TermId,
            SolvedUserAge,
            classNo as ClassNo,
			SurveyCriteriaName_US,
			SurveyCriteriaDescription_US,
            SurveyCriteriaName,
            SurveyCriteriaDescription,
            DfnSurveyCriteriaId,
           CAST( CASE WHEN teacher =0 and leaderTeacher=0 THEN NULL /*Öğretmen çözmemiş ise tüm seviyelerde null*/
            WHEN student >0 AND parent >0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.4 + parent * 0.3 + teacher * 0.15 + leaderTeacher*0.15, 0)
			WHEN student >0 AND parent >0 AND teacher >0 and leaderTeacher=0 THEN ROUND(student * 0.4 + parent * 0.3 + teacher * 0.3, 0)
			WHEN student >0 AND parent >0 AND teacher =0 and leaderTeacher>0 THEN ROUND(student * 0.4 + parent * 0.3 + leaderTeacher * 0.3, 0)

			WHEN student >0 AND parent =0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.6 + teacher * 0.2 + leaderTeacher*0.2, 0)
			WHEN student >0 AND parent =0 AND teacher >0 and leaderTeacher=0 THEN ROUND(student * 0.6 + teacher * 0.4, 0)
			WHEN student >0 AND parent =0 AND teacher =0 and leaderTeacher>0 THEN ROUND(student * 0.6 + leaderTeacher * 0.4, 0)

			WHEN student =0 and parent =0 AND teacher >0 and leaderTeacher>0 THEN ROUND(student * 0.5 + teacher * 0.5, 0)
			WHEN student =0 and parent =0 AND teacher >0 and leaderTeacher=0 THEN teacher
			WHEN student =0 and parent =0 AND teacher =0 and leaderTeacher>0 THEN leaderTeacher

			WHEN student =0 and parent >0 AND teacher >0 and leaderTeacher>0 THEN ROUND(leaderTeacher * 0.25 + teacher * 0.25 + parent*0.5, 0)
			WHEN student =0 and parent >0 AND teacher >0 and leaderTeacher=0 THEN ROUND (teacher * 0.5 + parent*0.5, 0)
			WHEN student =0 and parent >0 AND teacher =0 and leaderTeacher>0 THEN ROUND (leaderTeacher * 0.5 + parent*0.5, 0) END as integer) AS Score
            FROM
                (SELECT
                sr.SurveyId,
                sr.SolvedUserId,
                sr.SolvedUserTemperamentId,
                sr.TermId,
                sr.SolvedUserAge,
                sr.ClassId AS classNo,
                cr.GroupName as SurveyCriteriaName,
				cr.GroupName_US as SurveyCriteriaName_US,
				'' as SurveyCriteriaDescription_US,
                '' as SurveyCriteriaDescription,
                scs.DfnSurveyCriteriaId,
				sum(case when sr.SolverRoleId='DEB470C7-9827-4375-B20A-BEA56511EA49' then scs.Score else 0 end) as student,
				sum(case when sr.SolverRoleId='13676A48-FC7A-4694-82B2-CF0EE8F06313' then scs.Score else 0 end) as parent,  
				sum(case when sr.SolverRoleId='46A1C2F2-AA44-41EF-A746-59AC5EC09DCE' then scs.Score else 0 end) as teacher, 
				sum(case when sr.SolverRoleId='574D2187-D602-4188-A63C-C2B9DC5133DF' then scs.Score else 0 end) as leaderTeacher
	
                FROM
                dbo.SurveyResults AS sr
                INNER JOIN dbo.SurveyCriteriaScores AS scs ON sr.Id = scs.SurveyResultId
                inner JOIN dbo.DfnSurveyCriteriaGroups AS cr ON scs.DfnSurveyCriteriaId = cr.Id
                INNER JOIN dbo.UserOrganizationRoles AS uor ON sr.UserOrganizationRoleSolverUserId = uor.Id
                where sr.SurveyState=3 and sr.SurveyId in (23,24,25) and sr.IsActive=1
				group by
				sr.SurveyId,
                sr.SolvedUserId,
                sr.SolvedUserTemperamentId,
                sr.TermId,
                sr.SolvedUserAge,
                sr.ClassId,
                cr.GroupName,
                cr.GroupName_US,
                scs.DfnSurveyCriteriaId
				) 
				AS sub
                group by
                sub.SurveyId,
                sub.SolvedUserId,
                sub.SolvedUserTemperamentId,
                sub.TermId,
                sub.SolvedUserAge,
                sub.classNo,
                sub.SurveyCriteriaName,
                sub.SurveyCriteriaDescription,
                sub.DfnSurveyCriteriaId,
                sub.parent,
                sub.teacher,
				student,
				leaderTeacher,
				SurveyCriteriaName_US,
				SurveyCriteriaDescription_US
				) as zz
				join TalentIntelligenceTemperamentCategoryScores ts on zz.SolvedUserTemperamentId=ts.TemperamentTypeId and ts.CategoryId=zz.DfnSurveyCriteriaId
GO
/****** Object:  View [dbo].[VTalentIntelligenceCategoryAvg]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[VTalentIntelligenceCategoryAvg]
AS
SELECT        
t.UserId, 
t.TermId,
t.SolvedUserTemperamentId,
ct.Id AS CategoryId, 
ct.SurveyCategoryName, 
ct.SurveyCategoryName_US, 
AVG(t.Score) AS CategoryAvg, 
dbo.GetSkillDegree(AVG(t.Score), 'tr') AS CategoriAvgDegree,
dbo.GetSkillDegree(AVG(t.Score), 'us')  AS CategoriAvgDegree_US,
dbo.GetSkillNormalizeLevel(Avg(t.Score * 1.5)) as CategoryScoreLevel
FROM            
dbo.VTalentIntelligenceCategoryScore AS t 
INNER JOIN dbo.DfnSurveyCriteriaGroups AS cg ON t.DfnSurveyCriteriaId = cg.Id 
INNER JOIN dbo.DfnSurveyCategories AS ct ON cg.SurveyCategoryId = ct.Id
GROUP BY 
t.UserId, 
ct.Id, 
t.SolvedUserTemperamentId,
ct.SurveyCategoryName, 
ct.SurveyCategoryName_US,
t.TermId
GO
/****** Object:  View [dbo].[VHrTemperamentAnalysis]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create VIEW [dbo].[VHrTemperamentAnalysis]
AS
select 
uor.Id as UserOrganizationRoleId,
u.Id as UserId
,u.Name as NameSurname
,u.Email
,u.BirthDate
,r.Id as RoleId
,r.RoleName
,r.RoleName_US
,u.TemperamentTypeId
,o.Id as OrganisationId
,o.Name as OrganisationName
,tem.TemperamentTypeName
,tem.TemperamentTypeName_US
,p.Id as PositionId
,p.PositionName
,d.Id as DepartmentId
,d.DepartmentName
 from Users u
join UserOrganizationRoles uor on u.Id=uor.UserId 
join Organizations o on uor.OrganizationId=o.Id
join Roles r on uor.RoleId=r.Id
left join HrPositions p on u.PositionID=p.Id
left join HrDepartments d on p.DepartmentId=d.Id
left join DfnTemperamentTypes tem on u.TemperamentTypeId=tem.Id
where u.IsActive=1 and u.IsDeleted=0

GO
/****** Object:  Table [dbo].[HrPositionCriterias]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrPositionCriterias](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PositionId] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
 CONSTRAINT [PK_HrPositionCriterias] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VHrPositionMeritCriteria]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create VIEW [dbo].[VHrPositionMeritCriteria]
AS
  select 
  u.Id as UserId,
  CONCAT(u.Name,' ', u.Surname) as NameSurname,
  pc.CriteriaId,
  u.PositionID,
  pc.CategoryID,
  p.PositionLevel,
  case when cr.CriteriaName is not null then cr.CriteriaName
	   when pr.AbilityName is not null then pr.AbilityName end as CriteriaName,
  case when cr.CriteriaDescription is not null then cr.CriteriaDescription
	   when pr.AbilityDescription is not null then pr.AbilityDescription end as CriteriaDescription,
  case when cr.CriteriaName_US is not null then cr.CriteriaName_US
	   when pr.AbilityName_US is not null then pr.AbilityName_US end as CriteriaName_US,
  case when cr.CriteriaDescription_US is not null then cr.CriteriaDescription_US
	   when pr.AbilityDescription_US is not null then pr.AbilityDescription_US end as CriteriaDescription_US,
  case when et1.EvaluationText is not null then et1.EvaluationText
	   when et2.EvaluationText is not null then et2.EvaluationText
	   when et3.EvaluationText is not null then et3.EvaluationText end as EvaluationText,
  case when et1.EvaluationText_US is not null then et1.EvaluationText_US
	   when et2.EvaluationText_US is not null then et2.EvaluationText_US
	   when et3.EvaluationText_US is not null then et3.EvaluationText_US end as EvaluationText_US,
  case when mt.GeneralScore is not null then mt.GeneralScore
	   when st.GeneralScore is not null then st.GeneralScore
	   when pt.GeneralScore is not null then pt.GeneralScore end as GeneralScore,
[dbo].[GetScoreLevel](case when mt.GeneralScore is not null then mt.GeneralScore
	   when st.GeneralScore is not null then st.GeneralScore
	   when pt.GeneralScore is not null then pt.GeneralScore end) as GeneralScoreLevel,
[dbo].[GetScoreDegree](case when mt.GeneralScore is not null then mt.GeneralScore
	   when st.GeneralScore is not null then st.GeneralScore
	   when pt.GeneralScore is not null then pt.GeneralScore end) as GeneralScoreDegree
  from Users u
  join HrPositions p on u.PositionID=p.Id
  join HrPositionCriterias pc on p.Id=pc.PositionId
  left join HrCriterias cr on pc.CriteriaId=cr.Id and pc.CategoryID<>80
  left join HrPerfections pr on pc.CriteriaId=pr.Id and pc.CategoryID=80
  left join HrSocialQualificationDevelopmentTracking st on pc.CriteriaId=st.CriteriaId and pc.CategoryID=54 and u.Id=st.UserId and st.IsLastEveluation=1 
  left join HrPerfectionDevelopmentTracking pt on pc.CriteriaId=pt.CriteriaId and pc.CategoryID=80 and u.Id=pt.UserId and pt.IsLastEveluation=1 
  left join HrMeritDevelopmentTracking mt on pc.CriteriaId=mt.CriteriaId and pc.CategoryID=41 and u.Id=mt.UserId and mt.IsLastEveluation=1 
  left join HrCriteriaEvaluationTexts et1 on st.CriteriaId=et1.CriteriaId and et1.CategoryId=54 and [dbo].[GetScoreLevel](st.GeneralScore)=et1.EvaluationLevel
  left join HrCriteriaEvaluationTexts et2 on mt.CriteriaId=et2.CriteriaId and et2.CategoryId=41 and [dbo].[GetScoreLevel](mt.GeneralScore)=et2.EvaluationLevel
  left join HrPerfectionEvaluationTexts et3 on pt.CriteriaId=et3.CriteriaId and p.PositionLevel=et3.[Level] and [dbo].[GetScoreLevel](st.GeneralScore)=et3.EvaluationLevel

GO
/****** Object:  View [dbo].[VHrPositionMeritAvg]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VHrPositionMeritAvg]
AS
SELECT        
u.Id AS UserId, 
CONCAT(u.Name,' ', u.Surname) as NameSurname,
u.PositionID, 
p.PositionName, 
p.PositionLevel, 
p.DepartmentId, 
d.DepartmentName, 
tt.TemperamentTypeName,
tt.TemperamentTypeName_US,
uor.OrganizationId as OrganisationId, 
AVG(CASE WHEN mt.GeneralScore IS NOT NULL 
   THEN mt.GeneralScore WHEN st.GeneralScore IS NOT NULL 
   THEN st.GeneralScore WHEN pt.GeneralScore IS NOT NULL 
   THEN pt.GeneralScore END) AS PositionMeritAvg
FROM            
dbo.Users AS u 
join DfnTemperamentTypes tt on u.TemperamentTypeId=tt.Id
INNER JOIN dbo.UserOrganizationRoles AS uor ON u.Id = uor.UserId AND u.IsActive = 1 AND u.IsDeleted = 0 
AND uor.RoleId NOT IN ('DEB470C7-9827-4375-B20A-BEA56511EA49', '13676A48-FC7A-4694-82B2-CF0EE8F06313') 
INNER JOIN dbo.Terms AS t ON uor.TermId = t.Id AND t.IsActive = 1 
LEFT OUTER JOIN dbo.HrPositions AS p ON u.PositionID = p.Id 
LEFT OUTER JOIN dbo.HrDepartments AS d ON p.DepartmentId = d.Id 
LEFT OUTER JOIN dbo.HrPositionCriterias AS pc ON p.Id = pc.PositionId 
LEFT OUTER JOIN dbo.HrCriterias AS cr ON pc.CriteriaId = cr.Id AND pc.CategoryID <> 80 
LEFT OUTER JOIN dbo.HrPerfections AS pr ON pc.CriteriaId = pr.Id AND pc.CategoryID = 80 
LEFT OUTER JOIN dbo.HrSocialQualificationDevelopmentTracking AS st ON pc.CriteriaId = st.CriteriaId AND pc.CategoryID = 54 AND u.Id = st.UserId AND st.IsLastEveluation = 1 
LEFT OUTER JOIN dbo.HrPerfectionDevelopmentTracking AS pt ON pc.CriteriaId = pt.CriteriaId AND pc.CategoryID = 80 AND u.Id = pt.UserId AND pt.IsLastEveluation = 1 
LEFT OUTER JOIN dbo.HrMeritDevelopmentTracking AS mt ON pc.CriteriaId = mt.CriteriaId AND pc.CategoryID = 41 AND u.Id = mt.UserId AND mt.IsLastEveluation = 1
GROUP BY 
u.Id, 
u.Name,
u.Surname,
u.PositionID, 
p.PositionName,
p.PositionLevel, 
p.DepartmentId, 
d.DepartmentName, 
uor.OrganizationId,
tt.TemperamentTypeName,
tt.TemperamentTypeName_US
GO
/****** Object:  View [dbo].[VHrPositionMeritAvgByCategory]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VHrPositionMeritAvgByCategory]
AS
SELECT        
u.Id AS UserId, 
pc.CategoryID, 
AVG(st.GeneralScore) AS SocialQualificationAvg, 
AVG(mt.GeneralScore) AS MeritAvg, 
AVG(pt.GeneralScore) AS PerfectionAvg
FROM 
dbo.Users AS u 
INNER JOIN dbo.HrPositions AS p ON u.PositionID = p.Id 
INNER JOIN dbo.HrPositionCriterias AS pc ON p.Id = pc.PositionId 
LEFT OUTER JOIN dbo.HrSocialQualificationDevelopmentTracking AS st ON pc.CriteriaId = st.CriteriaId AND pc.CategoryID = 54 AND u.Id = st.UserId AND st.IsLastEveluation = 1 
LEFT OUTER JOIN dbo.HrPerfectionDevelopmentTracking AS pt ON pc.CriteriaId = pt.CriteriaId AND pc.CategoryID = 80 AND u.Id = pt.UserId AND pt.IsLastEveluation = 1 
LEFT OUTER JOIN dbo.HrMeritDevelopmentTracking AS mt ON pc.CriteriaId = mt.CriteriaId AND pc.CategoryID = 41 AND u.Id = mt.UserId AND mt.IsLastEveluation = 1
GROUP BY u.Id, u.PositionID, pc.CategoryID
GO
/****** Object:  Table [dbo].[DfnGuidanceSurveyCriteriaReports]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnGuidanceSurveyCriteriaReports](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DfnSurveyCriteriaGroupId] [int] NOT NULL,
	[SchoolLevel] [int] NOT NULL,
	[ScoreLevel] [int] NOT NULL,
	[Content] [nvarchar](max) NULL,
 CONSTRAINT [PK_DfnGuidanceSurveyCriteriaReports] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GuidanceSurveyScores]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GuidanceSurveyScores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RatedUserID] [uniqueidentifier] NOT NULL,
	[EvaluatedUserId] [uniqueidentifier] NOT NULL,
	[Category] [int] NOT NULL,
	[SurveyID] [int] NOT NULL,
	[AnswerID] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[Score] [tinyint] NOT NULL,
 CONSTRAINT [PK_GuidanceSurveyScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GuidanceUserLastSurveyAnswers]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GuidanceUserLastSurveyAnswers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RatedUserId] [uniqueidentifier] NOT NULL,
	[EveluatedUserID] [uniqueidentifier] NOT NULL,
	[SurveyId] [int] NOT NULL,
	[AnswerId] [int] NOT NULL,
	[CreateDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_GuidanceUserLastSurveyAnswers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VGuidanceUserEvaluation]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create VIEW [dbo].[VGuidanceUserEvaluation]
AS
select zz.*,
cr.Content,'' as Content_US
from (
select 
gs.EvaluatedUserId as UserId,
gs.Category as CategoryId , 
AVG(gs.Score) as ScoreAvg,
[dbo].[GetScoreLevel](AVG(gs.Score)) as ScoreLevel,
sr.SchoolLevel 
from GuidanceSurveyScores gs
join GuidanceUserLastSurveyAnswers ls on gs.AnswerID=ls.AnswerId and gs.EvaluatedUserId=ls.EveluatedUserID
join GuidanceSurveyResults sr on gs.EvaluatedUserId=sr.SolvedUserId and gs.RatedUserID=sr.SolverUserId and sr.DfnGuidanceSurveyId=gs.SurveyID
group by gs.EvaluatedUserId,gs.Category,sr.SchoolLevel
) zz 
join DfnGuidanceSurveyCriteriaReports cr on zz.SchoolLevel=cr.SchoolLevel 
and zz.CategoryId=cr.DfnSurveyCriteriaGroupId 
and zz.ScoreLevel=cr.ScoreLevel
GO
/****** Object:  View [dbo].[VGuidanceCriteriaUserEvaluation]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create VIEW [dbo].[VGuidanceCriteriaUserEvaluation]
AS
select zz.*,
dc.SurveyCriteriaName,
dc.SurveyCriteriaName_US,
dc.SurveyCriteriaDescription,
dc.SurveyCriteriaDescription_US
from (
select 
gs.EvaluatedUserId as UserId,
gs.CriteriaId,
gs.Category as CategoryId , 
AVG(gs.Score) as ScoreAvg,
[dbo].[GetScoreLevel](AVG(gs.Score)) as ScoreLevel,
sr.SchoolLevel 
from GuidanceSurveyScores gs
join GuidanceUserLastSurveyAnswers ls on gs.AnswerID=ls.AnswerId and gs.EvaluatedUserId=ls.EveluatedUserID
join GuidanceSurveyResults sr on gs.EvaluatedUserId=sr.SolvedUserId and gs.RatedUserID=sr.SolverUserId and sr.DfnGuidanceSurveyId=gs.SurveyID
group by gs.EvaluatedUserId,gs.Category,sr.SchoolLevel,gs.CriteriaId
) zz 
join DfnSurveyCriterias dc on zz.CriteriaId=dc.Id
GO
/****** Object:  View [dbo].[VMentalUsersCriteriaScore]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[VMentalUsersCriteriaScore]
AS
 SELECT scs.DfnSurveyCriteriaId, 
 crt.SurveyCriteriaName,
 sr.TermId, 
 sr.SolvedUserId, 
 sr.SolvedUserAge, 
 sr.SolvedUserTemperamentId,
 sr.SurveyId,
  sr.SurveyState,
 sum(case when sr.SolverRoleId='DEB470C7-9827-4375-B20A-BEA56511EA49' then scs.Score else 0 end) as student,
 sum(case when sr.SolverRoleId='13676A48-FC7A-4694-82B2-CF0EE8F06313' then scs.Score else 0 end) as parent,  
 sum(case when sr.SolverRoleId='46A1C2F2-AA44-41EF-A746-59AC5EC09DCE' then scs.Score else 0 end) as teacher, 
 sum(case when sr.SolverRoleId='574D2187-D602-4188-A63C-C2B9DC5133DF' then scs.Score else 0 end) as leaderTeacher
  FROM dbo.SurveyResults AS sr 
  INNER JOIN dbo.SurveyCriteriaScores AS scs ON sr.Id = scs.SurveyResultId 
  INNER JOIN dbo.UserOrganizationRoles AS uor ON uor.Id = sr.UserOrganizationRoleSolverUserId
  Left Join DfnSurveyCriterias as crt on crt.Id = scs.DfnSurveyCriteriaId
  left join Users u on uor.UserId = u.Id and sr.SolvedUserTemperamentId = u.TemperamentTypeId
  WHERE (sr.SurveyId in(2,3,4,5) )AND (sr.SurveyState = 3) and sr.IsActive=1
  GROUP BY scs.DfnSurveyCriteriaId, 
  sr.TermId, 
  sr.SolvedUserId, 
  sr.SolvedUserAge, 
  sr.SolvedUserTemperamentId,
  sr.SurveyId,
  crt.SurveyCriteriaName,
   sr.SurveyState
GO
/****** Object:  View [dbo].[VPersonalityUsersCriteriaScore]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[VPersonalityUsersCriteriaScore]
AS

SELECT scs.DfnSurveyCriteriaId,
crt.SurveyCriteriaName,
sr.TermId,
sr.SolvedUserId,
sr.SolvedUserTemperamentId,
sr.SurveyState,
sr.SurveyId,
sr.SchoolLevel,
 sum(case when sr.SolverRoleId='DEB470C7-9827-4375-B20A-BEA56511EA49' then scs.Score else 0 end) as student,
 sum(case when sr.SolverRoleId='13676A48-FC7A-4694-82B2-CF0EE8F06313' then scs.Score else 0 end) as parent,
 sum(case when sr.SolverRoleId='46A1C2F2-AA44-41EF-A746-59AC5EC09DCE' then scs.Score else 0 end) as teacher,
 sum(case when sr.SolverRoleId='574D2187-D602-4188-A63C-C2B9DC5133DF' then scs.Score else 0 end) as leaderTeacher
FROM dbo.SurveyResults AS sr
INNER JOIN dbo.SurveyCriteriaScores AS scs ON sr.Id = scs.SurveyResultId
INNER JOIN dbo.UserOrganizationRoles AS uor ON uor.Id = sr.UserOrganizationRoleSolverUserId
left join Users u on uor.UserId = u.Id and sr.SolvedUserTemperamentId = u.TemperamentTypeId
Inner Join DfnSurveyCriterias as crt on crt.Id = scs.DfnSurveyCriteriaId
WHERE (sr.SurveyId in(1) ) and sr.IsActive=1
GROUP BY scs.DfnSurveyCriteriaId,
sr.TermId,
sr.SolvedUserId,
sr.SolvedUserTemperamentId,
sr.SurveyId,
sr.SchoolLevel,
sr.SurveyState,
crt.SurveyCriteriaName

GO
/****** Object:  Table [dbo].[SurveyCriteriaGroupScores]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyCriteriaGroupScores](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[SurveyResultId] [int] NOT NULL,
	[DfnSurveyCriteriaGroupId] [int] NOT NULL,
	[Score] [int] NOT NULL,
 CONSTRAINT [PK_SurveyCriteriaGroupScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VSocialUsersGroupScore]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



Create VIEW [dbo].[VSocialUsersGroupScore]
AS
 SELECT scs.DfnSurveyCriteriaGroupId, 
 grp.GroupName,
 sr.TermId, 
 sr.SolvedUserId, 
 sr.SchoolLevel,
 sr.SolvedUserTemperamentId,
 sr.SurveyId,
 sr.SurveyState,
 sum(case when sr.SolverRoleId='DEB470C7-9827-4375-B20A-BEA56511EA49' then scs.Score else 0 end) as student,
 sum(case when sr.SolverRoleId='13676A48-FC7A-4694-82B2-CF0EE8F06313' then scs.Score else 0 end) as parent,  
 sum(case when sr.SolverRoleId='46A1C2F2-AA44-41EF-A746-59AC5EC09DCE' then scs.Score else 0 end) as teacher, 
 sum(case when sr.SolverRoleId='574D2187-D602-4188-A63C-C2B9DC5133DF' then scs.Score else 0 end) as leaderTeacher
  FROM dbo.SurveyResults AS sr 
  INNER JOIN dbo.SurveyCriteriaGroupScores AS scs ON sr.Id = scs.SurveyResultId 
  INNER JOIN dbo.UserOrganizationRoles AS uor ON uor.Id = sr.UserOrganizationRoleSolverUserId
  Left Join DfnSurveyCriteriaGroups as grp on grp.Id = scs.DfnSurveyCriteriaGroupId
  WHERE (sr.SurveyId in(6,10,11,12,17,18) )AND (sr.SurveyState = 3) and sr.IsActive=1
  GROUP BY scs.DfnSurveyCriteriaGroupId, 
  sr.TermId, 
  sr.SolvedUserId, 
  sr.SchoolLevel, 
  sr.SolvedUserTemperamentId,
  sr.SurveyId,
  grp.GroupName,
  sr.SurveyState
GO
/****** Object:  Table [dbo].[HrRelCandidateUserPositions]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrRelCandidateUserPositions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrganizationId] [uniqueidentifier] NOT NULL,
	[HrPositionId] [int] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_HrRelCandidateUserPositions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VHrCandidatePerfectionEvaluationAvg]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[VHrCandidatePerfectionEvaluationAvg]
AS
SELECT        
	zz.UserId, 
	zz.GeneralScore AS CriteriaScoreAvg,
	dbo.GetScoreLevel(zz.GeneralScore) AS CriteriaScoreAvgLevel, 
	dbo.GetScoreDegree(zz.GeneralScore) AS CriteriaScoreAvgDegree,
	zz.CriteriaId, 
	cr.AbilityName as CriteriaName, 
	cr.AbilityName_US as CriteriaName_US, 
	cr.AbilityDescription as CriteriaDescription, 
	cr.AbilityDescription_US as CriteriaDescription_US, 
	ctx.EvaluationText, 
	ctx.EvaluationText_US, 
	u.Name,u.Surname, 
	pc.PositionId as PositionId, 
	p.PositionName, 
	d.DepartmentName , 
	d.Id as DepartmentId, 
	ct.CategoryName,
	ct.CategoryName_US,
	pc.PositionId AS PositionCriteriaId
    FROM dbo.HrPerfectionDevelopmentTracking AS zz
	INNER JOIN dbo.Users AS u ON zz.UserId = u.Id 
	INNER JOIN HrRelCandidateUserPositions as hrel on hrel.UserId=u.Id
	inner JOIN HrPositionCriterias pc on zz.CriteriaId=pc.CriteriaId  and pc.CategoryID=80 and pc.PositionId=hrel.HrPositionId
	LEFT JOIN dbo.HrPerfections AS cr ON zz.CriteriaId = cr.Id 
	LEFT JOIN HrPositions p on pc.PositionId=p.Id
	LEFT JOIN HrDepartments d on p.DepartmentId=d.Id
	LEFT JOIN dbo.HrCategories AS ct ON zz.EvaluationCategoryId = ct.Id 
	LEFT JOIN dbo.HrPerfectionEvaluationTexts AS ctx ON zz.CriteriaId = ctx.CriteriaId and ctx.[Level]=(case when p.PositionLevel is not null then p.PositionLevel else 1 end) AND ctx.EvaluationLevel = dbo.GetScoreLevel(zz.GeneralScore)
	where zz.IsLastEveluation=1  

GO
/****** Object:  View [dbo].[VHrCandidatePerfectionAvg]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VHrCandidatePerfectionAvg]
AS
SELECT        
UserId, 
Name,
Surname,
PositionName, 
DepartmentName, 
DepartmentId,
PositionId,
CAST(AVG(CriteriaScoreAvg) AS int) AS GeneralAvg, 
dbo.GetScoreLevel(CAST(AVG(CriteriaScoreAvg) AS int)) AS GeneralAvgLevel, 
dbo.GetScoreDegree(CAST(AVG(CriteriaScoreAvg) AS int)) AS GeneralAvgDegree
FROM  dbo.VHrCandidatePerfectionEvaluationAvg AS sa
GROUP BY 
UserId,
PositionName, 
DepartmentName,
DepartmentId,
PositionId,
Name,
Surname

GO
/****** Object:  View [dbo].[VHrCandidateMeritEvaluationAvg]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[VHrCandidateMeritEvaluationAvg]
AS
SELECT        
	zz.UserId, 
	zz.GeneralScore AS CriteriaScoreAvg,
	dbo.GetScoreLevel(zz.GeneralScore) AS CriteriaScoreAvgLevel, 
	dbo.GetScoreDegree(zz.GeneralScore) AS CriteriaScoreAvgDegree,
	zz.CriteriaId, 
	cr.CriteriaName as CriteriaName, 
	cr.CriteriaName_US as CriteriaName_US, 
	cr.CriteriaDescription as CriteriaDescription, 
	cr.CriteriaDescription_US as CriteriaDescription_US, 
	ctx.EvaluationText, 
	ctx.EvaluationText_US, 
	u.Name,u.Surname, 
	pc.PositionId as PositionId, 
	p.PositionName, 
	d.DepartmentName , 
	d.Id as DepartmentId, 
	ct.CategoryName,
	ct.CategoryName_US,
	pc.PositionId AS PositionCriteriaId
    FROM dbo.HrMeritDevelopmentTracking AS zz
	INNER JOIN dbo.Users AS u ON zz.UserId = u.Id 
	INNER JOIN HrRelCandidateUserPositions as hrel on hrel.UserId=u.Id
	inner JOIN HrPositionCriterias pc on zz.CriteriaId=pc.CriteriaId  and pc.CategoryID=41 and pc.PositionId=hrel.HrPositionId
	LEFT JOIN dbo.HrCriterias AS cr ON zz.CriteriaId = cr.Id 
	LEFT JOIN HrPositions p on pc.PositionId=p.Id
	LEFT JOIN HrDepartments d on p.DepartmentId=d.Id
	LEFT JOIN dbo.HrCategories AS ct ON zz.EvaluationCategoryId = ct.Id 
	LEFT JOIN dbo.HrCriteriaEvaluationTexts AS ctx ON zz.CriteriaId = ctx.CriteriaId and ctx.EvaluationLevel=dbo.GetMeritLevel(ZZ.GeneralScore,0,0) and ctx.CategoryId=41
	where zz.IsLastEveluation=1  

GO
/****** Object:  View [dbo].[VHrCandidateMeritAvg]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VHrCandidateMeritAvg]
AS
SELECT        
UserId, 
Name,
Surname,
PositionName, 
DepartmentName, 
DepartmentId,
PositionId,
CAST(AVG(CriteriaScoreAvg) AS int) AS GeneralAvg, 
dbo.GetScoreLevel(CAST(AVG(CriteriaScoreAvg) AS int)) AS GeneralAvgLevel, 
dbo.GetScoreDegree(CAST(AVG(CriteriaScoreAvg) AS int)) AS GeneralAvgDegree
FROM  dbo.VHrCandidateMeritEvaluationAvg AS sa
GROUP BY 
UserId,
PositionName, 
DepartmentName,
DepartmentId,
PositionId,
Name,
Surname
GO
/****** Object:  View [dbo].[VHrCandidateSocialEvaluationAvg]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VHrCandidateSocialEvaluationAvg]
AS
SELECT        
	zz.UserId, 
	zz.GeneralScore AS CriteriaScoreAvg,
	dbo.GetScoreLevel(zz.GeneralScore) AS CriteriaScoreAvgLevel, 
	dbo.GetScoreDegree(zz.GeneralScore) AS CriteriaScoreAvgDegree,
	zz.CriteriaId, 
	cr.CriteriaName as CriteriaName, 
	cr.CriteriaName_US as CriteriaName_US, 
	cr.CriteriaDescription as CriteriaDescription, 
	cr.CriteriaDescription_US as CriteriaDescription_US, 
	ctx.EvaluationText, 
	ctx.EvaluationText_US, 
	u.Name,u.Surname, 
	pc.PositionId as PositionId, 
	p.PositionName, 
	d.DepartmentName , 
	d.Id as DepartmentId, 
	ct.CategoryName,
	ct.CategoryName_US,
	pc.PositionId AS PositionCriteriaId
    FROM dbo.HrSocialQualificationDevelopmentTracking AS zz
	INNER JOIN dbo.Users AS u ON zz.UserId = u.Id 
	INNER JOIN HrRelCandidateUserPositions as hrel on hrel.UserId=u.Id
	inner JOIN HrPositionCriterias pc on zz.CriteriaId=pc.CriteriaId  and pc.CategoryID=54 and pc.PositionId=hrel.HrPositionId
	LEFT JOIN dbo.HrCriterias AS cr ON zz.CriteriaId = cr.Id 
	LEFT JOIN HrPositions p on pc.PositionId=p.Id
	LEFT JOIN HrDepartments d on p.DepartmentId=d.Id
	LEFT JOIN dbo.HrCategories AS ct ON zz.EvaluationCategoryId = ct.Id 
	LEFT JOIN dbo.HrCriteriaEvaluationTexts AS ctx ON zz.CriteriaId = ctx.CriteriaId and ctx.EvaluationLevel=dbo.GetMeritLevel(ZZ.GeneralScore,0,0) and ctx.CategoryId=54
	where zz.IsLastEveluation=1  

GO
/****** Object:  View [dbo].[VHrCandidateSocialAvg]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VHrCandidateSocialAvg]
AS
SELECT        
UserId, 
Name,
Surname,
PositionName, 
DepartmentName, 
DepartmentId,
PositionId,
CAST(AVG(CriteriaScoreAvg) AS int) AS GeneralAvg, 
dbo.GetScoreLevel(CAST(AVG(CriteriaScoreAvg) AS int)) AS GeneralAvgLevel, 
dbo.GetScoreDegree(CAST(AVG(CriteriaScoreAvg) AS int)) AS GeneralAvgDegree
FROM  dbo.VHrCandidateSocialEvaluationAvg AS sa
GROUP BY 
UserId,
PositionName, 
DepartmentName,
DepartmentId,
PositionId,
Name,
Surname

GO
/****** Object:  View [dbo].[VHrDepartmentRiskEveluation]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VHrDepartmentRiskEveluation]
AS
SELECT       
DepartmentId, 
CASE WHEN DepartmentName IS NOT NULL THEN DepartmentName ELSE '' END AS DepartmentName, 
AVG(Score) AS ScoreAvg, 
CategoryName, 
CategoryName_US, 
CategoryID, 
OrganisationId, 
OrganisationName, 
EvaluationText, 
EvaluationText_US, 
EvaluationLevel, 
0 AS UserCount
FROM            
dbo.VHrUserRiskEveluation
GROUP BY DepartmentId,
CategoryID, DepartmentName,
OrganisationId, CategoryName, 
CategoryName, 
CategoryName_US, CategoryID, OrganisationName, EvaluationText, EvaluationText_US, EvaluationLevel
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Name_US] [nvarchar](max) NULL,
	[StateId] [int] NOT NULL,
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClassroomDistributionTemplates]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClassroomDistributionTemplates](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[SchoolId] [uniqueidentifier] NOT NULL,
	[Level] [int] NOT NULL,
	[ClassroomDistributionType] [nvarchar](max) NULL,
	[ClassroomDistributionTypeName] [nvarchar](max) NULL,
 CONSTRAINT [PK_ClassroomDistributionTemplates] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClassroomSittingPlanTemplates]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClassroomSittingPlanTemplates](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TeacherTableLocation] [nvarchar](max) NULL,
	[ClassroomDoorLocation] [nvarchar](max) NULL,
	[isLeftWindow] [bit] NOT NULL,
	[isRightWindow] [bit] NOT NULL,
	[isRearWindow] [bit] NOT NULL,
	[SittingPlanType] [nvarchar](max) NULL,
	[ClassroomId] [uniqueidentifier] NOT NULL,
	[TermId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ClassroomSittingPlanTemplates] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 14.11.2019 09:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Sortname] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NULL,
	[Name_US] [nvarchar](max) NULL,
	[Phonecode] [int] NOT NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnCategoryEvaluationTexts]    Script Date: 14.11.2019 09:31:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnCategoryEvaluationTexts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[NormCase] [int] NULL,
	[NormStatus] [tinyint] NOT NULL,
	[Content] [nvarchar](max) NULL,
	[Content_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_DfnCategoryEvaluationTexts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnClassDistributionOrders]    Script Date: 14.11.2019 09:31:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnClassDistributionOrders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemperamentTypeId] [int] NOT NULL,
	[DistributionOrder] [int] NOT NULL,
	[StudentType] [int] NOT NULL,
	[EffectType] [int] NOT NULL,
 CONSTRAINT [PK_DfnClassDistributionOrders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnClasses]    Script Date: 14.11.2019 09:31:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnClasses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClassName] [nvarchar](max) NULL,
 CONSTRAINT [PK_DfnClasses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnConsultancySuggestions]    Script Date: 14.11.2019 09:31:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnConsultancySuggestions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CriteriaId] [int] NULL,
	[CriteriaGroupId] [int] NULL,
	[TemperamentId] [int] NULL,
	[ScoreLevel] [int] NULL,
	[SchoolLevel] [int] NOT NULL,
	[CounseleeType] [int] NOT NULL,
	[SuggestionText] [nvarchar](max) NULL,
	[SuggestionText_US] [nvarchar](max) NULL,
	[Age] [int] NULL,
 CONSTRAINT [PK_DfnConsultancySuggestions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnCriteriaNames]    Script Date: 14.11.2019 09:31:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnCriteriaNames](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[CriteriaName] [nvarchar](max) NULL,
	[CriteriaName_US] [nvarchar](max) NULL,
	[Age] [int] NULL,
 CONSTRAINT [PK_DfnCriteriaNames] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dfnDashboardModules]    Script Date: 14.11.2019 09:31:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dfnDashboardModules](
	[IdDashboard] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[IdLanguage] [int] NOT NULL,
 CONSTRAINT [PK_dfnDashboardModules] PRIMARY KEY CLUSTERED 
(
	[IdDashboard] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnGuidanceTemperamentSurveys]    Script Date: 14.11.2019 09:31:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnGuidanceTemperamentSurveys](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DfnGuidanceSurveyId] [int] NOT NULL,
	[MainTemperamentId] [int] NOT NULL,
	[WingMainTemperamentId] [int] NULL,
	[SchoolLevel] [int] NOT NULL,
 CONSTRAINT [PK_DfnGuidanceTemperamentSurveys] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnHarmony]    Script Date: 14.11.2019 09:31:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnHarmony](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentType] [int] NOT NULL,
	[EffectType] [int] NOT NULL,
	[TemperamentType1Id] [int] NOT NULL,
	[TemperamentType2Id] [int] NOT NULL,
	[GroupOrder] [int] NOT NULL,
	[GeneralHarmonyScore] [int] NOT NULL,
	[AcademicHarmonyScore] [int] NOT NULL,
	[SocialHarmonyScore] [int] NOT NULL,
	[DeveloperHarmonyScore] [int] NOT NULL,
	[GeneralHarmony] [nvarchar](max) NULL,
	[GeneralHarmony_US] [nvarchar](max) NULL,
	[AcademicHarmony] [nvarchar](max) NULL,
	[AcademicHarmony_US] [nvarchar](max) NULL,
	[Socialharmony] [nvarchar](max) NULL,
	[Socialharmony_US] [nvarchar](max) NULL,
	[Developerharmony] [nvarchar](max) NULL,
	[Developerharmony_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_DfnHarmony] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnInterviewNoteCriterias]    Script Date: 14.11.2019 09:31:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnInterviewNoteCriterias](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SchoolLevel] [int] NOT NULL,
	[Type] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NULL,
	[Name_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_DfnInterviewNoteCriterias] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnReportTypeParagraphs]    Script Date: 14.11.2019 09:31:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnReportTypeParagraphs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemperamentId] [int] NOT NULL,
	[ParagraphTitle_US] [nvarchar](max) NULL,
	[ParagraphContent_US] [nvarchar](max) NULL,
	[ParagraphTitle] [nvarchar](max) NULL,
	[ParagraphContent] [nvarchar](max) NULL,
	[Order] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[ReportTypeId] [int] NOT NULL,
	[SchoolLevel] [int] NULL,
 CONSTRAINT [PK_DfnReportTypeParagraphs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnReportTypes]    Script Date: 14.11.2019 09:31:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnReportTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReportTypeName_US] [nvarchar](max) NULL,
	[ReportTypeName] [nvarchar](max) NULL,
	[ReportTypeOwnerRoles] [nvarchar](max) NULL,
	[OwnerStudentTypes] [nvarchar](max) NULL,
	[AccessRoleTypes] [nvarchar](max) NULL,
	[Order] [int] NOT NULL,
	[ModuleType] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_DfnReportTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnSurveyCategoryQuestions]    Script Date: 14.11.2019 09:31:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnSurveyCategoryQuestions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionNumber] [int] NOT NULL,
	[isReverse] [bit] NOT NULL,
	[DfnSurveyCategoryId] [int] NOT NULL,
	[Age] [int] NULL,
	[ClassId] [int] NULL,
	[SchoolLevel] [int] NULL,
	[IsSelf] [tinyint] NULL,
 CONSTRAINT [PK_DfnSurveyCategoryQuestions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnSurveyCategoryTypes]    Script Date: 14.11.2019 09:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnSurveyCategoryTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SurveyCategoryTypeName] [nvarchar](max) NULL,
	[SurveyCategoryTypeName_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_DfnSurveyCategoryTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnSurveyCriteriaGroups01]    Script Date: 14.11.2019 09:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnSurveyCriteriaGroups01](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](max) NULL,
	[GroupName_US] [nvarchar](max) NULL,
	[SurveyCategoryId] [int] NOT NULL,
 CONSTRAINT [PK_DfnSurveyCriteriaGroups] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnSurveyCriteriaQuestions]    Script Date: 14.11.2019 09:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnSurveyCriteriaQuestions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionNumber] [int] NOT NULL,
	[Content] [nvarchar](max) NULL,
	[Content_US] [nvarchar](max) NULL,
	[isStraight] [bit] NOT NULL,
	[DfnSurveyCriteriaId] [int] NULL,
	[Age] [int] NULL,
	[ClassId] [int] NULL,
	[SchoolLevel] [int] NULL,
	[IsSelf] [tinyint] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_DfnSurveyCriteriaQuestions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnTeacherDistributionOrders]    Script Date: 14.11.2019 09:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnTeacherDistributionOrders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemperamentTypeId] [int] NOT NULL,
	[DistributionOrder] [int] NOT NULL,
	[ClassroomTemperamentState] [int] NOT NULL,
	[StudentType] [int] NOT NULL,
 CONSTRAINT [PK_DfnTeacherDistributionOrders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DfnTemperamentProfileCardContents]    Script Date: 14.11.2019 09:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DfnTemperamentProfileCardContents](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemperamentId] [int] NOT NULL,
	[HrCategoryId] [int] NOT NULL,
	[Order] [int] NOT NULL,
	[Content] [nvarchar](max) NULL,
	[Content_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_DfnTemperamentProfileCardContents] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GuidanceSurveyAnswers]    Script Date: 14.11.2019 09:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GuidanceSurveyAnswers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[SurveyId] [int] NOT NULL,
 CONSTRAINT [PK_GuidanceSurveyAnswers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GuidanceSurveyCriteriaAndGroupScores]    Script Date: 14.11.2019 09:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GuidanceSurveyCriteriaAndGroupScores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GuidanceSurveyResultId] [int] NOT NULL,
	[DfnSurveyCriteriaGroupId] [int] NOT NULL,
	[DfnSurveyCriteriaId] [int] NOT NULL,
	[CriteriaScore] [int] NOT NULL,
	[GroupScore] [int] NOT NULL,
 CONSTRAINT [PK_GuidanceSurveyCriteriaAndGroupScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GuidanceSurveyQuestionAnswers]    Script Date: 14.11.2019 09:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GuidanceSurveyQuestionAnswers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionNumber] [int] NOT NULL,
	[Answer] [int] NOT NULL,
	[GuidanceSurveyResultId] [int] NOT NULL,
 CONSTRAINT [PK_GuidanceSurveyQuestionAnswers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GuidanceUserSurveyAnswers]    Script Date: 14.11.2019 09:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GuidanceUserSurveyAnswers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RatedUserId] [uniqueidentifier] NOT NULL,
	[EveluatedUserID] [uniqueidentifier] NOT NULL,
	[SurveyId] [int] NOT NULL,
	[AnswerId] [int] NOT NULL,
	[CreateDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_GuidanceUserSurveyAnswers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GuidanceUserSurveyQAs]    Script Date: 14.11.2019 09:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GuidanceUserSurveyQAs](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserSurveyID] [int] NOT NULL,
	[QuestionNo] [int] NOT NULL,
	[Answer] [float] NOT NULL,
 CONSTRAINT [PK_GuidanceUserSurveyQAs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrAnswers]    Script Date: 14.11.2019 09:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrAnswers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[SurveyId] [int] NOT NULL,
 CONSTRAINT [PK_HrAnswers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrCategoryConsultancies]    Script Date: 14.11.2019 09:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrCategoryConsultancies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[CategoryLevel] [tinyint] NOT NULL,
	[ConsultancyId] [int] NOT NULL,
 CONSTRAINT [PK_HrCategoryConsultancies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrCategoryTrainings]    Script Date: 14.11.2019 09:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrCategoryTrainings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[PositionLevel] [tinyint] NOT NULL,
	[CategoryLevel] [tinyint] NOT NULL,
	[TrainingId] [int] NOT NULL,
 CONSTRAINT [PK_HrCategoryTrainings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrConsultancies]    Script Date: 14.11.2019 09:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrConsultancies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ConsultancyName] [nvarchar](max) NULL,
	[ConsultancyName_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_HrConsultancies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrCriteriaConsultancies]    Script Date: 14.11.2019 09:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrCriteriaConsultancies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[ConsultancyId] [int] NOT NULL,
 CONSTRAINT [PK_HrCriteriaConsultancies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrCriteriaQuestions]    Script Date: 14.11.2019 09:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrCriteriaQuestions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[QuestionNo] [int] NOT NULL,
	[IsReverse] [bit] NOT NULL,
 CONSTRAINT [PK_HrCriteriaQuestions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrCriteriaTrainings]    Script Date: 14.11.2019 09:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrCriteriaTrainings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[TrainigId] [int] NOT NULL,
 CONSTRAINT [PK_HrCriteriaTrainings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrLeadershipCriteriaDevelopmentTracking]    Script Date: 14.11.2019 09:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrLeadershipCriteriaDevelopmentTracking](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[EvaluationCategoryId] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[GeneralScore] [tinyint] NULL,
	[SelfScore] [tinyint] NULL,
	[PerceivedScore] [tinyint] NULL,
	[TemperamentScore] [tinyint] NULL,
	[IsLastEveluation] [tinyint] NULL,
	[CreateDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_HrLeadershipCriteriaDevelopmentTracking] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrLeadershipEveluationTexts]    Script Date: 14.11.2019 09:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrLeadershipEveluationTexts](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[EveluationText] [nvarchar](max) NULL,
	[EveluationText_US] [nvarchar](max) NULL,
	[LevelText] [nvarchar](max) NULL,
	[LevelText_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_HrLeadershipEveluationTexts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrLeadershipGeneralDevelopmentTracking]    Script Date: 14.11.2019 09:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrLeadershipGeneralDevelopmentTracking](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[EveluationCategoryId] [int] NOT NULL,
	[GeneralScore] [tinyint] NULL,
	[SelfScore] [tinyint] NULL,
	[PerceivedScore] [tinyint] NULL,
	[TemperamentScore] [tinyint] NULL,
	[IsLastEveluation] [tinyint] NULL,
	[CreateDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_HrLeadershipGeneralDevelopmentTracking] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrLeadershipLowCompetencies]    Script Date: 14.11.2019 09:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrLeadershipLowCompetencies](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[Score] [int] NOT NULL,
 CONSTRAINT [PK_HrLeadershipLowCompetencies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrLeadershipPerceptions]    Script Date: 14.11.2019 09:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrLeadershipPerceptions](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[LeadershipTypeId] [int] NOT NULL,
	[LeadershipPerception] [nvarchar](max) NULL,
	[LeadershipPerception_US] [nvarchar](max) NULL,
	[IsNaturalLeadership] [bit] NOT NULL,
 CONSTRAINT [PK_HrLeadershipPerceptions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrLeadershipReportTexts]    Script Date: 14.11.2019 09:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrLeadershipReportTexts](
	[Id] [uniqueidentifier] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[ScoreLevel] [nvarchar](max) NULL,
	[Text] [nvarchar](max) NULL,
	[Text_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_HrLeadershipReportTexts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrLeadershipStrongWeaknesses]    Script Date: 14.11.2019 09:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrLeadershipStrongWeaknesses](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[StrongWeakness] [bit] NOT NULL,
	[Text] [nvarchar](max) NULL,
	[Text_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_HrLeadershipStrongWeaknesses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrLeadershipStyleDevelopmentTracking]    Script Date: 14.11.2019 09:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrLeadershipStyleDevelopmentTracking](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[EveluationCategoryId] [int] NOT NULL,
	[ScoreAvg] [tinyint] NOT NULL,
	[IsLastEveluation] [tinyint] NULL,
	[CreateDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_HrLeadershipStyleDevelopmentTracking] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrLeadershipStyleReportTexts]    Script Date: 14.11.2019 09:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrLeadershipStyleReportTexts](
	[Id] [uniqueidentifier] NOT NULL,
	[LeadershipTypeId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[ReportType] [int] NOT NULL,
	[Text] [nvarchar](max) NULL,
	[Text_US] [nvarchar](max) NULL,
	[NaturalType] [nvarchar](max) NULL,
	[NaturalType_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_HrLeadershipStyleReportTexts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrLeadershipSyntheticTypes]    Script Date: 14.11.2019 09:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrLeadershipSyntheticTypes](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[SyntheticTypeId] [int] NOT NULL,
	[Score] [int] NOT NULL,
	[ScoreLevel] [nvarchar](max) NULL,
 CONSTRAINT [PK_HrLeadershipSyntheticTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrLeadershipTemperamentScores]    Script Date: 14.11.2019 09:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrLeadershipTemperamentScores](
	[Id] [uniqueidentifier] NOT NULL,
	[TemperamentId] [int] NOT NULL,
	[LeadershipTypeId] [int] NOT NULL,
	[IsNatural] [bit] NOT NULL,
	[Score] [int] NOT NULL,
 CONSTRAINT [PK_HrLeadershipTemperamentScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrLeadershipTemperamentTexts]    Script Date: 14.11.2019 09:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrLeadershipTemperamentTexts](
	[Id] [uniqueidentifier] NOT NULL,
	[MainTemperamentId] [int] NOT NULL,
	[WingTemperamentId] [int] NOT NULL,
	[StressEasyText] [nvarchar](max) NULL,
	[StressEasyText_US] [nvarchar](max) NULL,
	[SpecialFeatures] [nvarchar](max) NULL,
	[SpecialFeatures_US] [nvarchar](max) NULL,
	[StrongSides] [nvarchar](max) NULL,
	[StrongSides_US] [nvarchar](max) NULL,
	[RiskySides] [nvarchar](max) NULL,
	[RiskySides_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_HrLeadershipTemperamentTexts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrMeritCriteriaTemperamentScores]    Script Date: 14.11.2019 09:31:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrMeritCriteriaTemperamentScores](
	[Id] [uniqueidentifier] NOT NULL,
	[TemperamentTypeId] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[Score] [int] NOT NULL,
 CONSTRAINT [PK_HrMeritCriteriaTemperamentScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrPerfectionCriteriaQuestions]    Script Date: 14.11.2019 09:31:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrPerfectionCriteriaQuestions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SurveyId] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[CriteriaLevel] [int] NOT NULL,
	[QuestionNo] [int] NOT NULL,
	[IsReverse] [bit] NOT NULL,
 CONSTRAINT [PK_HrPerfectionCriteriaQuestions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrPerfectionCriteriaTemperamentScores]    Script Date: 14.11.2019 09:31:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrPerfectionCriteriaTemperamentScores](
	[Id] [uniqueidentifier] NOT NULL,
	[TemperamentTypeId] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[Score] [int] NOT NULL,
 CONSTRAINT [PK_HrPerfectionCriteriaTemperamentScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrPositionMeritAverageScores]    Script Date: 14.11.2019 09:31:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrPositionMeritAverageScores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PositionId] [int] NOT NULL,
	[QualificationAverage] [real] NOT NULL,
	[SkillAverage] [real] NOT NULL,
	[PerfectionAverage] [real] NOT NULL,
	[WorthyAverage] [real] NOT NULL,
 CONSTRAINT [PK_HrPositionMeritAverageScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrPreparedTemplateDetails]    Script Date: 14.11.2019 09:31:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrPreparedTemplateDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemplateId] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[HrPreparedTemplateId] [int] NULL,
 CONSTRAINT [PK_HrPreparedTemplateDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrPreparedTemplates]    Script Date: 14.11.2019 09:31:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrPreparedTemplates](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrganizationId] [uniqueidentifier] NOT NULL,
	[TemplateName] [nvarchar](max) NULL,
 CONSTRAINT [PK_HrPreparedTemplates] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrReportTypes]    Script Date: 14.11.2019 09:31:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrReportTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReportName] [nvarchar](200) NULL,
	[ReportName_US] [nvarchar](200) NULL,
 CONSTRAINT [PK_HrReportTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrRiskCategoryQuestions]    Script Date: 14.11.2019 09:31:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrRiskCategoryQuestions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[QuestionNo] [int] NOT NULL,
	[IsReverse] [bit] NOT NULL,
 CONSTRAINT [PK_HrRiskCategoryQuestions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrSkillCorrectedScores]    Script Date: 14.11.2019 09:31:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrSkillCorrectedScores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[CategoryTagID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Level] [int] NOT NULL,
	[CorrectedScore] [tinyint] NOT NULL,
	[Score] [tinyint] NOT NULL,
	[AnswerID] [int] NOT NULL,
 CONSTRAINT [PK_HrSkillCorrectedScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrSkillDevelopmentTracking]    Script Date: 14.11.2019 09:31:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrSkillDevelopmentTracking](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[EvaluationCategoryId] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[Score] [int] NULL,
	[CreateDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_HrSkillDevelopmentTracking] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrSocialQualificationCriteriaTemperamentScores]    Script Date: 14.11.2019 09:31:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrSocialQualificationCriteriaTemperamentScores](
	[Id] [uniqueidentifier] NOT NULL,
	[TemperamentTypeId] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[Score] [int] NOT NULL,
 CONSTRAINT [PK_HrSocialQualificationCriteriaTemperamentScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrSurveyAbilityQuestions]    Script Date: 14.11.2019 09:31:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrSurveyAbilityQuestions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SurveyID] [int] NOT NULL,
	[AbilityId] [int] NOT NULL,
	[QuestionNo] [int] NOT NULL,
	[IsReverse] [bit] NOT NULL,
 CONSTRAINT [PK_HrSurveyAbilityQuestions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrTemperamentCriteriaScores]    Script Date: 14.11.2019 09:31:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrTemperamentCriteriaScores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemperamentTypeId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[Score] [int] NOT NULL,
 CONSTRAINT [PK_HrTemperamentCriteriaScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrTemperamentProfileCardTexts]    Script Date: 14.11.2019 09:31:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrTemperamentProfileCardTexts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemperamentTypeId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[Content] [nvarchar](max) NULL,
	[Content_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_HrTemperamentProfileCardTexts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrTemperamentReports]    Script Date: 14.11.2019 09:31:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrTemperamentReports](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemperamentTypeId] [int] NOT NULL,
	[ReportTypeId] [tinyint] NOT NULL,
	[Content] [nvarchar](max) NULL,
	[Content_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_HrTemperamentReports] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrTrainings]    Script Date: 14.11.2019 09:31:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrTrainings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TrainingName] [nvarchar](max) NULL,
	[TrainingName_US] [nvarchar](max) NULL,
	[TrainingType] [tinyint] NOT NULL,
 CONSTRAINT [PK_HrTrainings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrUserSurveyAnswers]    Script Date: 14.11.2019 09:31:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrUserSurveyAnswers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RatedUserId] [uniqueidentifier] NOT NULL,
	[EveluatedUserID] [uniqueidentifier] NOT NULL,
	[SurveyId] [int] NOT NULL,
	[AnswerId] [int] NOT NULL,
	[CreateDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_HrUserSurveyAnswers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HrUserSurveyQAs]    Script Date: 14.11.2019 09:31:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HrUserSurveyQAs](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserSurveyID] [int] NOT NULL,
	[QuestionNo] [int] NOT NULL,
	[Answer] [float] NOT NULL,
	[HrUserSurveysId] [int] NULL,
 CONSTRAINT [PK_HrUserSurveyQAs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InterviewNotes]    Script Date: 14.11.2019 09:31:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InterviewNotes](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentUserId] [uniqueidentifier] NOT NULL,
	[TeacherUserId] [uniqueidentifier] NOT NULL,
	[DfnInterviewNoteCriteriaId] [int] NOT NULL,
	[Answer] [nvarchar](max) NULL,
 CONSTRAINT [PK_InterviewNotes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Languages]    Script Date: 14.11.2019 09:31:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Languages](
	[IdLanguage] [int] IDENTITY(1,1) NOT NULL,
	[NameLanguage] [nvarchar](max) NOT NULL,
	[NameLanguage_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED 
(
	[IdLanguage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MenuActions]    Script Date: 14.11.2019 09:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuActions](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[Name_TR] [nvarchar](150) NOT NULL,
	[Name_EN] [nvarchar](150) NOT NULL,
	[ParentId] [uniqueidentifier] NOT NULL,
	[Rank] [int] NOT NULL,
	[Link] [nvarchar](max) NULL,
	[Icon] [nvarchar](max) NULL,
	[IsAction] [bit] NOT NULL,
	[Hierarchy] [nvarchar](max) NULL,
 CONSTRAINT [PK_MenuActions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MeritQuestions]    Script Date: 14.11.2019 09:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MeritQuestions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Question] [nvarchar](max) NULL,
	[Question_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_MeritQuestions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrganTypes]    Script Date: 14.11.2019 09:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrganTypes](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[TypeName] [nvarchar](150) NOT NULL,
	[TypeName_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_OrganTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Properties]    Script Date: 14.11.2019 09:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Properties](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[PropertyName] [nvarchar](150) NOT NULL,
	[PropertyTitle_US] [nvarchar](150) NOT NULL,
	[PropertyTitle] [nvarchar](150) NOT NULL,
	[Type] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Properties] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PropertyRoles]    Script Date: 14.11.2019 09:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyRoles](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[PropertyId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_PropertyRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelGuidanceSurveyCriteriaQuestions]    Script Date: 14.11.2019 09:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelGuidanceSurveyCriteriaQuestions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SchoolLevel] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[QuestionNumber] [int] NOT NULL,
	[IsSelf] [bit] NOT NULL,
	[GuidanceSurveyId] [int] NOT NULL,
	[IsStraight] [bit] NOT NULL,
 CONSTRAINT [PK_RelGuidanceSurveyCriteriaQuestions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelMeritCriteriaQuestions]    Script Date: 14.11.2019 09:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelMeritCriteriaQuestions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[ClassId] [int] NOT NULL,
	[QuestionId] [int] NOT NULL,
	[TemperamentId] [int] NULL,
 CONSTRAINT [PK_RelMeritCriteriaQuestions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelMeritQuestionOptions]    Script Date: 14.11.2019 09:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelMeritQuestionOptions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[Option] [nvarchar](max) NULL,
	[Option_US] [nvarchar](max) NULL,
	[IsSelf] [bit] NULL,
 CONSTRAINT [PK_RelMeritQuestionOptions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelOrganisations]    Script Date: 14.11.2019 09:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelOrganisations](
	[Id] [uniqueidentifier] NOT NULL,
	[ParentOrganisationId] [uniqueidentifier] NOT NULL,
	[ChildOrganisationId] [uniqueidentifier] NOT NULL,
	[ParentOrganisationType] [uniqueidentifier] NOT NULL,
	[ChildOrganisationType] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_RelOrganisations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelOrganizationMenuActions]    Script Date: 14.11.2019 09:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelOrganizationMenuActions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrganizationId] [uniqueidentifier] NOT NULL,
	[MenuActionId] [uniqueidentifier] NOT NULL,
	[IsPassive] [bit] NULL,
 CONSTRAINT [PK_RelOrganizationMenuActions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelPersonalityDevelopmentCriteriaQuestions]    Script Date: 14.11.2019 09:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelPersonalityDevelopmentCriteriaQuestions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SchoolLevel] [int] NOT NULL,
	[TemperamentId] [int] NOT NULL,
	[CriteriaId] [int] NOT NULL,
	[QuestionId] [int] NOT NULL,
	[IsSelf] [bit] NULL,
 CONSTRAINT [PK_RelPersonalityDevelopmentCriteriaQuestions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelSurveyRoles]    Script Date: 14.11.2019 09:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelSurveyRoles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SurveyId] [int] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[StudentType] [int] NOT NULL,
 CONSTRAINT [PK_RelSurveyRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleMenuActions]    Script Date: 14.11.2019 09:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleMenuActions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[MenuActionId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_RoleMenuActions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SchoolSettings]    Script Date: 14.11.2019 09:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SchoolSettings](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[SchoolId] [uniqueidentifier] NOT NULL,
	[SchoolUserLimit] [int] NULL,
 CONSTRAINT [PK_SchoolSettings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SchoolTemperamentConfirmationSettings]    Script Date: 14.11.2019 09:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SchoolTemperamentConfirmationSettings](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[SchoolId] [uniqueidentifier] NOT NULL,
	[ClassroomId] [uniqueidentifier] NOT NULL,
	[ConfirmingRoleIds] [nvarchar](max) NULL,
 CONSTRAINT [PK_SchoolTemperamentConfirmationSettings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SelectedStudentTemperamentNotes]    Script Date: 14.11.2019 09:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SelectedStudentTemperamentNotes](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentUserId] [uniqueidentifier] NOT NULL,
	[TeacherUserId] [uniqueidentifier] NOT NULL,
	[Note] [nvarchar](max) NULL,
 CONSTRAINT [PK_SelectedStudentTemperamentNotes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/* Setting Tables create script eklendi */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Settings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Key] [tinyint] NOT NULL,
	[Value] [int] NOT NULL,
	[Name] [nvarchar](max) NULL
 CONSTRAINT [PK_Settings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/*********************************/



/****** Object:  Table [dbo].[SittingPlanClassroomDesks]    Script Date: 14.11.2019 09:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SittingPlanClassroomDesks](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ColumnNo] [int] NOT NULL,
	[DeskNo] [int] NOT NULL,
	[ChairNo] [int] NOT NULL,
	[isNearWindow] [bit] NOT NULL,
	[isNearRear] [bit] NOT NULL,
	[isNearDoor] [bit] NOT NULL,
	[isNearTeacherTable] [bit] NOT NULL,
	[SittingPlanId] [int] NOT NULL,
	[StudentId] [uniqueidentifier] NULL,
	[isFixed] [bit] NOT NULL,
 CONSTRAINT [PK_SittingPlanClassroomDesks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SittingPlansTemperamentRules]    Script Date: 14.11.2019 09:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SittingPlansTemperamentRules](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemperamentTypeId] [int] NOT NULL,
	[isSittingWindowNear] [bit] NOT NULL,
	[isSittingDoorNear] [bit] NOT NULL,
	[isSittingRearNear] [bit] NOT NULL,
 CONSTRAINT [PK_SittingPlansTemperamentRules] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[States]    Script Date: 14.11.2019 09:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[States](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Name_US] [nvarchar](max) NULL,
	[CountryId] [int] NOT NULL,
 CONSTRAINT [PK_States] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentDistributions]    Script Date: 14.11.2019 09:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentDistributions](
	[Id] [uniqueidentifier] NOT NULL,
	[StudentId] [uniqueidentifier] NOT NULL,
	[StudentUorId] [uniqueidentifier] NOT NULL,
	[StudentName] [nvarchar](max) NULL,
	[StudentGender] [bit] NOT NULL,
	[StudentTemperamentName] [nvarchar](max) NULL,
	[StudentTemperamentId] [int] NULL,
	[IsFixed] [bit] NOT NULL,
	[AcademicDegree] [int] NOT NULL,
	[NumaricalDegree] [int] NOT NULL,
	[VerbalDegree] [int] NOT NULL,
	[LanguageDegree] [int] NOT NULL,
	[TempClassroomId] [uniqueidentifier] NOT NULL,
	[DistributeGroup] [int] NOT NULL,
	[FixedOrder] [nvarchar](1) NULL,
 CONSTRAINT [PK_StudentDistributions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SurveyQuestionAnswers]    Script Date: 14.11.2019 09:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyQuestionAnswers](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[QuestionNumber] [int] NOT NULL,
	[Answer] [int] NOT NULL,
	[IsExcessive] [bit] NULL,
	[SurveyResultId] [int] NOT NULL,
 CONSTRAINT [PK_SurveyQuestionAnswers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Surveys]    Script Date: 14.11.2019 09:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Surveys](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SurveyName] [nvarchar](max) NOT NULL,
	[SurveyName_US] [nvarchar](max) NULL,
	[SurveyContent] [nvarchar](max) NULL,
	[SurveyContent_US] [nvarchar](max) NULL,
	[DfnSurveyCategoryId] [int] NOT NULL,
	[SurveyAccessAge] [int] NULL,
	[SchoolLevel] [int] NULL,
	[NumberOfAnswerOptions] [int] NOT NULL,
 CONSTRAINT [PK_Surveys] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TalentSkillCorrectedScores]    Script Date: 14.11.2019 09:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TalentSkillCorrectedScores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[TermId] [uniqueidentifier] NOT NULL,
	[CategoryTagID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Level] [int] NOT NULL,
	[CorrectedScore] [tinyint] NOT NULL,
	[Score] [tinyint] NOT NULL,
	[SurveyResultId] [int] NOT NULL,
 CONSTRAINT [PK_TalentSkillCorrectedScores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeacherTemperamentStyles]    Script Date: 14.11.2019 09:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeacherTemperamentStyles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemparementId] [int] NOT NULL,
	[StyleTitle] [nvarchar](max) NULL,
	[StyleTitle_US] [nvarchar](max) NULL,
	[StyleText] [nvarchar](max) NULL,
	[StyleText_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_TeacherTemperamentStyles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TempClassrooms]    Script Date: 14.11.2019 09:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempClassrooms](
	[Id] [uniqueidentifier] NOT NULL,
	[ClassId] [nvarchar](max) NULL,
	[ClassName] [nvarchar](max) NULL,
	[ClassCapacity] [int] NOT NULL,
	[ClassroomType] [nvarchar](max) NULL,
	[ClassProposedTeacherId] [uniqueidentifier] NULL,
	[ClassroomTemperamentState] [int] NOT NULL,
	[ClassroomDistributionTemplateId] [uniqueidentifier] NOT NULL,
	[EducationGroup] [int] NOT NULL,
	[HarmonyScore] [int] NOT NULL,
 CONSTRAINT [PK_TempClassrooms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TemperamentConfirmationLogs]    Script Date: 14.11.2019 09:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TemperamentConfirmationLogs](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[TemperamentId] [uniqueidentifier] NOT NULL,
	[ProcessingUserOrgRoleId] [uniqueidentifier] NOT NULL,
	[BeforeTemperamentTypeId] [int] NULL,
	[AfterTemperamentTypeId] [int] NULL,
 CONSTRAINT [PK_TemperamentConfirmationLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TemperamentProfileCardTexts]    Script Date: 14.11.2019 09:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TemperamentProfileCardTexts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemperamentTypeId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[Content] [nvarchar](max) NULL,
	[Content_US] [nvarchar](max) NULL,
 CONSTRAINT [PK_TemperamentProfileCardTexts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Temperaments]    Script Date: 14.11.2019 09:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Temperaments](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[UserOrgRoleId] [uniqueidentifier] NOT NULL,
	[SolverUserOrgRoleId] [uniqueidentifier] NOT NULL,
	[MizacTestId] [uniqueidentifier] NOT NULL,
	[Result] [nvarchar](max) NULL,
	[IsSelected] [bit] NOT NULL,
 CONSTRAINT [PK_Temperaments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userDashboardModules]    Script Date: 14.11.2019 09:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userDashboardModules](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[UserDashboard] [uniqueidentifier] NOT NULL,
	[IdDashboard] [int] NOT NULL,
	[UserOrganizationRoleId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_userDashboardModules] PRIMARY KEY CLUSTERED 
(
	[UserDashboard] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserExtraMenuActions]    Script Date: 14.11.2019 09:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserExtraMenuActions](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[MenuActionId] [uniqueidentifier] NOT NULL,
	[UserOrganizationRoleId] [uniqueidentifier] NOT NULL,
	[IsAccess] [bit] NOT NULL,
 CONSTRAINT [PK_UserExtraMenuActions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserProperties]    Script Date: 14.11.2019 09:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProperties](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[PropertyId] [uniqueidentifier] NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_UserProperties] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [IX_Cities_StateId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_Cities_StateId] ON [dbo].[Cities]
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClassroomSittingPlanTemplates_ClassroomId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_ClassroomSittingPlanTemplates_ClassroomId] ON [dbo].[ClassroomSittingPlanTemplates]
(
	[ClassroomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClassroomSittingPlanTemplates_TermId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_ClassroomSittingPlanTemplates_TermId] ON [dbo].[ClassroomSittingPlanTemplates]
(
	[TermId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnClassDistributionOrders_TemperamentTypeId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnClassDistributionOrders_TemperamentTypeId] ON [dbo].[DfnClassDistributionOrders]
(
	[TemperamentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnCriteriaNames_CriteriaId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnCriteriaNames_CriteriaId] ON [dbo].[DfnCriteriaNames]
(
	[CriteriaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnCriteriaNorms_CriteriaId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnCriteriaNorms_CriteriaId] ON [dbo].[DfnCriteriaNorms]
(
	[CriteriaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnCriteriaNorms_TemperamentId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnCriteriaNorms_TemperamentId] ON [dbo].[DfnCriteriaNorms]
(
	[TemperamentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnCriteriaReports_CriteriaGroupId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnCriteriaReports_CriteriaGroupId] ON [dbo].[DfnCriteriaReports]
(
	[CriteriaGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnCriteriaReports_CriteriaId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnCriteriaReports_CriteriaId] ON [dbo].[DfnCriteriaReports]
(
	[CriteriaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnCriteriaReports_TemperamentId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnCriteriaReports_TemperamentId] ON [dbo].[DfnCriteriaReports]
(
	[TemperamentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnCriteriaTemperaments_CriteriaGroupId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnCriteriaTemperaments_CriteriaGroupId] ON [dbo].[DfnCriteriaTemperaments]
(
	[CriteriaGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnCriteriaTemperaments_CriteriaId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnCriteriaTemperaments_CriteriaId] ON [dbo].[DfnCriteriaTemperaments]
(
	[CriteriaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnCriteriaTemperaments_TemperamentId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnCriteriaTemperaments_TemperamentId] ON [dbo].[DfnCriteriaTemperaments]
(
	[TemperamentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_dfnDashboardModules_IdLanguage]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_dfnDashboardModules_IdLanguage] ON [dbo].[dfnDashboardModules]
(
	[IdLanguage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnGroupNorms_GroupId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnGroupNorms_GroupId] ON [dbo].[DfnGroupNorms]
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnGroupNorms_TemperamentId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnGroupNorms_TemperamentId] ON [dbo].[DfnGroupNorms]
(
	[TemperamentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnGuidanceSurveys_DfnSurveyCriteriaGroupId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnGuidanceSurveys_DfnSurveyCriteriaGroupId] ON [dbo].[DfnGuidanceSurveys]
(
	[DfnSurveyCriteriaGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnGuidanceTemperamentSurveys_DfnGuidanceSurveyId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnGuidanceTemperamentSurveys_DfnGuidanceSurveyId] ON [dbo].[DfnGuidanceTemperamentSurveys]
(
	[DfnGuidanceSurveyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnHarmony_TemperamentType1Id]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnHarmony_TemperamentType1Id] ON [dbo].[DfnHarmony]
(
	[TemperamentType1Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnHarmony_TemperamentType2Id]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnHarmony_TemperamentType2Id] ON [dbo].[DfnHarmony]
(
	[TemperamentType2Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnMentalTalentReports_DfnSurveyCriteriaGroupId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnMentalTalentReports_DfnSurveyCriteriaGroupId] ON [dbo].[DfnMentalTalentReports]
(
	[DfnSurveyCriteriaGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnReportTypeParagraphs_ReportTypeId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnReportTypeParagraphs_ReportTypeId] ON [dbo].[DfnReportTypeParagraphs]
(
	[ReportTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnSurveyCategories_DfnSurveyCategoryTypeId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnSurveyCategories_DfnSurveyCategoryTypeId] ON [dbo].[DfnSurveyCategories]
(
	[DfnSurveyCategoryTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnSurveyCriteriaGroups_SurveyCategoryId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnSurveyCriteriaGroups_SurveyCategoryId] ON [dbo].[DfnSurveyCriteriaGroups01]
(
	[SurveyCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnSurveyCriteriaQuestions_DfnSurveyCriteriaId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnSurveyCriteriaQuestions_DfnSurveyCriteriaId] ON [dbo].[DfnSurveyCriteriaQuestions]
(
	[DfnSurveyCriteriaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnSurveyCriterias_CriteriaGroupId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnSurveyCriterias_CriteriaGroupId] ON [dbo].[DfnSurveyCriterias]
(
	[CriteriaGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DfnTeacherDistributionOrders_TemperamentTypeId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_DfnTeacherDistributionOrders_TemperamentTypeId] ON [dbo].[DfnTeacherDistributionOrders]
(
	[TemperamentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_GuidanceSurveyCriteriaAndGroupScores_DfnSurveyCriteriaGroupId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_GuidanceSurveyCriteriaAndGroupScores_DfnSurveyCriteriaGroupId] ON [dbo].[GuidanceSurveyCriteriaAndGroupScores]
(
	[DfnSurveyCriteriaGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_GuidanceSurveyCriteriaAndGroupScores_DfnSurveyCriteriaId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_GuidanceSurveyCriteriaAndGroupScores_DfnSurveyCriteriaId] ON [dbo].[GuidanceSurveyCriteriaAndGroupScores]
(
	[DfnSurveyCriteriaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_GuidanceSurveyCriteriaAndGroupScores_GuidanceSurveyResultId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_GuidanceSurveyCriteriaAndGroupScores_GuidanceSurveyResultId] ON [dbo].[GuidanceSurveyCriteriaAndGroupScores]
(
	[GuidanceSurveyResultId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_GuidanceSurveyQuestionAnswers_GuidanceSurveyResultId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_GuidanceSurveyQuestionAnswers_GuidanceSurveyResultId] ON [dbo].[GuidanceSurveyQuestionAnswers]
(
	[GuidanceSurveyResultId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_GuidanceSurveyResults_DfnGuidanceSurveyId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_GuidanceSurveyResults_DfnGuidanceSurveyId] ON [dbo].[GuidanceSurveyResults]
(
	[DfnGuidanceSurveyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_GuidanceUserSurveys_DfnGuidanceSurveyId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_GuidanceUserSurveys_DfnGuidanceSurveyId] ON [dbo].[GuidanceUserSurveys]
(
	[DfnGuidanceSurveyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_HrCategories_HrCategoryTagId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_HrCategories_HrCategoryTagId] ON [dbo].[HrCategories]
(
	[HrCategoryTagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_HrCriterias_HrCategoryId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_HrCriterias_HrCategoryId] ON [dbo].[HrCriterias]
(
	[HrCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_HrDepartments_OrganizationId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_HrDepartments_OrganizationId] ON [dbo].[HrDepartments]
(
	[OrganizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_HrPositions_DepartmentId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_HrPositions_DepartmentId] ON [dbo].[HrPositions]
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_HrPreparedTemplateDetails_HrPreparedTemplateId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_HrPreparedTemplateDetails_HrPreparedTemplateId] ON [dbo].[HrPreparedTemplateDetails]
(
	[HrPreparedTemplateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_HrUserSurveyQAs_HrUserSurveysId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_HrUserSurveyQAs_HrUserSurveysId] ON [dbo].[HrUserSurveyQAs]
(
	[HrUserSurveysId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_InterviewNotes_DfnInterviewNoteCriteriaId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_InterviewNotes_DfnInterviewNoteCriteriaId] ON [dbo].[InterviewNotes]
(
	[DfnInterviewNoteCriteriaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_MenuActions_ParentId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_MenuActions_ParentId] ON [dbo].[MenuActions]
(
	[ParentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Organizations_OrganTypeId]    Script Date: 14.11.2019 09:31:12 ******/
CREATE NONCLUSTERED INDEX [IX_Organizations_OrganTypeId] ON [dbo].[Organizations]
(
	[OrganTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Organizations_ParentId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_Organizations_ParentId] ON [dbo].[Organizations]
(
	[ParentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Parents_UserParentId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_Parents_UserParentId] ON [dbo].[Parents]
(
	[UserParentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Parents_UserStudentId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_Parents_UserStudentId] ON [dbo].[Parents]
(
	[UserStudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PropertyRoles_PropertyId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_PropertyRoles_PropertyId] ON [dbo].[PropertyRoles]
(
	[PropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PropertyRoles_RoleId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_PropertyRoles_RoleId] ON [dbo].[PropertyRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RelGuidanceSurveyCriteriaQuestions_GuidanceSurveyId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_RelGuidanceSurveyCriteriaQuestions_GuidanceSurveyId] ON [dbo].[RelGuidanceSurveyCriteriaQuestions]
(
	[GuidanceSurveyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RelOrganizationMenuActions_MenuActionId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_RelOrganizationMenuActions_MenuActionId] ON [dbo].[RelOrganizationMenuActions]
(
	[MenuActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RelOrganizationMenuActions_OrganizationId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_RelOrganizationMenuActions_OrganizationId] ON [dbo].[RelOrganizationMenuActions]
(
	[OrganizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RelSurveyRoles_RoleId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_RelSurveyRoles_RoleId] ON [dbo].[RelSurveyRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RelSurveyRoles_SurveyId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_RelSurveyRoles_SurveyId] ON [dbo].[RelSurveyRoles]
(
	[SurveyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RoleMenuActions_MenuActionId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_RoleMenuActions_MenuActionId] ON [dbo].[RoleMenuActions]
(
	[MenuActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RoleMenuActions_RoleId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_RoleMenuActions_RoleId] ON [dbo].[RoleMenuActions]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SelectedStudentConsultancyCriterias_SelectedStudentConsultancyId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_SelectedStudentConsultancyCriterias_SelectedStudentConsultancyId] ON [dbo].[SelectedStudentConsultancyCriterias]
(
	[SelectedStudentConsultancyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SelectedStudentConsultancyNotes_SelectedStudentConsultancyCriteriasId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_SelectedStudentConsultancyNotes_SelectedStudentConsultancyCriteriasId] ON [dbo].[SelectedStudentConsultancyNotes]
(
	[SelectedStudentConsultancyCriteriasId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SittingPlanClassroomDesks_SittingPlanId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_SittingPlanClassroomDesks_SittingPlanId] ON [dbo].[SittingPlanClassroomDesks]
(
	[SittingPlanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SittingPlanClassroomDesks_StudentId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_SittingPlanClassroomDesks_StudentId] ON [dbo].[SittingPlanClassroomDesks]
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SittingPlansTemperamentRules_TemperamentTypeId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_SittingPlansTemperamentRules_TemperamentTypeId] ON [dbo].[SittingPlansTemperamentRules]
(
	[TemperamentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_States_CountryId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_States_CountryId] ON [dbo].[States]
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_StudentDistributions_TempClassroomId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_StudentDistributions_TempClassroomId] ON [dbo].[StudentDistributions]
(
	[TempClassroomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SurveyCriteriaGroupScores_DfnSurveyCriteriaGroupId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_SurveyCriteriaGroupScores_DfnSurveyCriteriaGroupId] ON [dbo].[SurveyCriteriaGroupScores]
(
	[DfnSurveyCriteriaGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SurveyCriteriaGroupScores_SurveyResultId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_SurveyCriteriaGroupScores_SurveyResultId] ON [dbo].[SurveyCriteriaGroupScores]
(
	[SurveyResultId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SurveyCriteriaScores_DfnSurveyCriteriaId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_SurveyCriteriaScores_DfnSurveyCriteriaId] ON [dbo].[SurveyCriteriaScores]
(
	[DfnSurveyCriteriaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SurveyCriteriaScores_SurveyResultId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_SurveyCriteriaScores_SurveyResultId] ON [dbo].[SurveyCriteriaScores]
(
	[SurveyResultId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SurveyQuestionAnswers_SurveyResultId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_SurveyQuestionAnswers_SurveyResultId] ON [dbo].[SurveyQuestionAnswers]
(
	[SurveyResultId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SurveyResults_SolvedUserId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_SurveyResults_SolvedUserId] ON [dbo].[SurveyResults]
(
	[SolvedUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SurveyResults_SurveyId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_SurveyResults_SurveyId] ON [dbo].[SurveyResults]
(
	[SurveyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SurveyResults_TermId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_SurveyResults_TermId] ON [dbo].[SurveyResults]
(
	[TermId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SurveyResults_UserOrganizationRoleId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_SurveyResults_UserOrganizationRoleId] ON [dbo].[SurveyResults]
(
	[UserOrganizationRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SurveyResults_UserOrganizationRoleSolverUserId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_SurveyResults_UserOrganizationRoleSolverUserId] ON [dbo].[SurveyResults]
(
	[UserOrganizationRoleSolverUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Surveys_DfnSurveyCategoryId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_Surveys_DfnSurveyCategoryId] ON [dbo].[Surveys]
(
	[DfnSurveyCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TempClassrooms_ClassProposedTeacherId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_TempClassrooms_ClassProposedTeacherId] ON [dbo].[TempClassrooms]
(
	[ClassProposedTeacherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TempClassrooms_ClassroomDistributionTemplateId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_TempClassrooms_ClassroomDistributionTemplateId] ON [dbo].[TempClassrooms]
(
	[ClassroomDistributionTemplateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TemperamentConfirmationLogs_ProcessingUserOrgRoleId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_TemperamentConfirmationLogs_ProcessingUserOrgRoleId] ON [dbo].[TemperamentConfirmationLogs]
(
	[ProcessingUserOrgRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TemperamentConfirmationLogs_TemperamentId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_TemperamentConfirmationLogs_TemperamentId] ON [dbo].[TemperamentConfirmationLogs]
(
	[TemperamentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Temperaments_SolverUserOrgRoleId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_Temperaments_SolverUserOrgRoleId] ON [dbo].[Temperaments]
(
	[SolverUserOrgRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Temperaments_UserOrgRoleId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_Temperaments_UserOrgRoleId] ON [dbo].[Temperaments]
(
	[UserOrgRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_userDashboardModules_IdDashboard]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_userDashboardModules_IdDashboard] ON [dbo].[userDashboardModules]
(
	[IdDashboard] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_userDashboardModules_UserOrganizationRoleId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_userDashboardModules_UserOrganizationRoleId] ON [dbo].[userDashboardModules]
(
	[UserOrganizationRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserExtraMenuActions_MenuActionId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_UserExtraMenuActions_MenuActionId] ON [dbo].[UserExtraMenuActions]
(
	[MenuActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserExtraMenuActions_UserOrganizationRoleId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_UserExtraMenuActions_UserOrganizationRoleId] ON [dbo].[UserExtraMenuActions]
(
	[UserOrganizationRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserOrganizationRoles_OrganizationId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_UserOrganizationRoles_OrganizationId] ON [dbo].[UserOrganizationRoles]
(
	[OrganizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserOrganizationRoles_RoleId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_UserOrganizationRoles_RoleId] ON [dbo].[UserOrganizationRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserOrganizationRoles_TermId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_UserOrganizationRoles_TermId] ON [dbo].[UserOrganizationRoles]
(
	[TermId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserOrganizationRoles_UserDashboardModuleUserDashboard]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_UserOrganizationRoles_UserDashboardModuleUserDashboard] ON [dbo].[UserOrganizationRoles]
(
	[UserDashboardModuleUserDashboard] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserOrganizationRoles_UserId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_UserOrganizationRoles_UserId] ON [dbo].[UserOrganizationRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserProperties_PropertyId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_UserProperties_PropertyId] ON [dbo].[UserProperties]
(
	[PropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserProperties_UserId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_UserProperties_UserId] ON [dbo].[UserProperties]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Users_NationalId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Users_NationalId] ON [dbo].[Users]
(
	[NationalId] ASC
)
WHERE ([NationalId] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Users_TemperamentTypeId]    Script Date: 14.11.2019 09:31:13 ******/
CREATE NONCLUSTERED INDEX [IX_Users_TemperamentTypeId] ON [dbo].[Users]
(
	[TemperamentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TempClassrooms] ADD  DEFAULT ((0)) FOR [EducationGroup]
GO
ALTER TABLE [dbo].[TempClassrooms] ADD  DEFAULT ((0)) FOR [HarmonyScore]
GO
ALTER TABLE [dbo].[Cities]  WITH CHECK ADD  CONSTRAINT [FK_Cities_States_StateId] FOREIGN KEY([StateId])
REFERENCES [dbo].[States] ([Id])
GO
ALTER TABLE [dbo].[Cities] CHECK CONSTRAINT [FK_Cities_States_StateId]
GO
ALTER TABLE [dbo].[ClassroomSittingPlanTemplates]  WITH CHECK ADD  CONSTRAINT [FK_ClassroomSittingPlanTemplates_Organizations_ClassroomId] FOREIGN KEY([ClassroomId])
REFERENCES [dbo].[Organizations] ([Id])
GO
ALTER TABLE [dbo].[ClassroomSittingPlanTemplates] CHECK CONSTRAINT [FK_ClassroomSittingPlanTemplates_Organizations_ClassroomId]
GO
ALTER TABLE [dbo].[ClassroomSittingPlanTemplates]  WITH CHECK ADD  CONSTRAINT [FK_ClassroomSittingPlanTemplates_Terms_TermId] FOREIGN KEY([TermId])
REFERENCES [dbo].[Terms] ([Id])
GO
ALTER TABLE [dbo].[ClassroomSittingPlanTemplates] CHECK CONSTRAINT [FK_ClassroomSittingPlanTemplates_Terms_TermId]
GO
ALTER TABLE [dbo].[DfnClassDistributionOrders]  WITH CHECK ADD  CONSTRAINT [FK_DfnClassDistributionOrders_DfnTemperamentTypes_TemperamentTypeId] FOREIGN KEY([TemperamentTypeId])
REFERENCES [dbo].[DfnTemperamentTypes] ([Id])
GO
ALTER TABLE [dbo].[DfnClassDistributionOrders] CHECK CONSTRAINT [FK_DfnClassDistributionOrders_DfnTemperamentTypes_TemperamentTypeId]
GO
ALTER TABLE [dbo].[DfnCriteriaNames]  WITH CHECK ADD  CONSTRAINT [FK_DfnCriteriaNames_DfnSurveyCriterias_CriteriaId] FOREIGN KEY([CriteriaId])
REFERENCES [dbo].[DfnSurveyCriterias] ([Id])
GO
ALTER TABLE [dbo].[DfnCriteriaNames] CHECK CONSTRAINT [FK_DfnCriteriaNames_DfnSurveyCriterias_CriteriaId]
GO
ALTER TABLE [dbo].[DfnCriteriaNorms]  WITH CHECK ADD  CONSTRAINT [FK_DfnCriteriaNorms_DfnSurveyCriterias_CriteriaId] FOREIGN KEY([CriteriaId])
REFERENCES [dbo].[DfnSurveyCriterias] ([Id])
GO
ALTER TABLE [dbo].[DfnCriteriaNorms] CHECK CONSTRAINT [FK_DfnCriteriaNorms_DfnSurveyCriterias_CriteriaId]
GO
ALTER TABLE [dbo].[DfnCriteriaNorms]  WITH CHECK ADD  CONSTRAINT [FK_DfnCriteriaNorms_DfnTemperamentTypes_TemperamentId] FOREIGN KEY([TemperamentId])
REFERENCES [dbo].[DfnTemperamentTypes] ([Id])
GO
ALTER TABLE [dbo].[DfnCriteriaNorms] CHECK CONSTRAINT [FK_DfnCriteriaNorms_DfnTemperamentTypes_TemperamentId]
GO
ALTER TABLE [dbo].[DfnCriteriaReports]  WITH CHECK ADD  CONSTRAINT [FK_DfnCriteriaReports_DfnSurveyCriteriaGroups_CriteriaGroupId] FOREIGN KEY([CriteriaGroupId])
REFERENCES [dbo].[DfnSurveyCriteriaGroups01] ([Id])
GO
ALTER TABLE [dbo].[DfnCriteriaReports] CHECK CONSTRAINT [FK_DfnCriteriaReports_DfnSurveyCriteriaGroups_CriteriaGroupId]
GO
ALTER TABLE [dbo].[DfnCriteriaReports]  WITH CHECK ADD  CONSTRAINT [FK_DfnCriteriaReports_DfnSurveyCriterias_CriteriaId] FOREIGN KEY([CriteriaId])
REFERENCES [dbo].[DfnSurveyCriterias] ([Id])
GO
ALTER TABLE [dbo].[DfnCriteriaReports] CHECK CONSTRAINT [FK_DfnCriteriaReports_DfnSurveyCriterias_CriteriaId]
GO
ALTER TABLE [dbo].[DfnCriteriaReports]  WITH CHECK ADD  CONSTRAINT [FK_DfnCriteriaReports_DfnTemperamentTypes_TemperamentId] FOREIGN KEY([TemperamentId])
REFERENCES [dbo].[DfnTemperamentTypes] ([Id])
GO
ALTER TABLE [dbo].[DfnCriteriaReports] CHECK CONSTRAINT [FK_DfnCriteriaReports_DfnTemperamentTypes_TemperamentId]
GO
ALTER TABLE [dbo].[DfnCriteriaTemperaments]  WITH CHECK ADD  CONSTRAINT [FK_DfnCriteriaTemperaments_DfnSurveyCriteriaGroups_CriteriaGroupId] FOREIGN KEY([CriteriaGroupId])
REFERENCES [dbo].[DfnSurveyCriteriaGroups01] ([Id])
GO
ALTER TABLE [dbo].[DfnCriteriaTemperaments] CHECK CONSTRAINT [FK_DfnCriteriaTemperaments_DfnSurveyCriteriaGroups_CriteriaGroupId]
GO
ALTER TABLE [dbo].[DfnCriteriaTemperaments]  WITH CHECK ADD  CONSTRAINT [FK_DfnCriteriaTemperaments_DfnSurveyCriterias_CriteriaId] FOREIGN KEY([CriteriaId])
REFERENCES [dbo].[DfnSurveyCriterias] ([Id])
GO
ALTER TABLE [dbo].[DfnCriteriaTemperaments] CHECK CONSTRAINT [FK_DfnCriteriaTemperaments_DfnSurveyCriterias_CriteriaId]
GO
ALTER TABLE [dbo].[DfnCriteriaTemperaments]  WITH CHECK ADD  CONSTRAINT [FK_DfnCriteriaTemperaments_DfnTemperamentTypes_TemperamentId] FOREIGN KEY([TemperamentId])
REFERENCES [dbo].[DfnTemperamentTypes] ([Id])
GO
ALTER TABLE [dbo].[DfnCriteriaTemperaments] CHECK CONSTRAINT [FK_DfnCriteriaTemperaments_DfnTemperamentTypes_TemperamentId]
GO
ALTER TABLE [dbo].[dfnDashboardModules]  WITH CHECK ADD  CONSTRAINT [FK_dfnDashboardModules_Languages_IdLanguage] FOREIGN KEY([IdLanguage])
REFERENCES [dbo].[Languages] ([IdLanguage])
GO
ALTER TABLE [dbo].[dfnDashboardModules] CHECK CONSTRAINT [FK_dfnDashboardModules_Languages_IdLanguage]
GO
ALTER TABLE [dbo].[DfnGroupNorms]  WITH CHECK ADD  CONSTRAINT [FK_DfnGroupNorms_DfnSurveyCriteriaGroups_GroupId] FOREIGN KEY([GroupId])
REFERENCES [dbo].[DfnSurveyCriteriaGroups01] ([Id])
GO
ALTER TABLE [dbo].[DfnGroupNorms] CHECK CONSTRAINT [FK_DfnGroupNorms_DfnSurveyCriteriaGroups_GroupId]
GO
ALTER TABLE [dbo].[DfnGroupNorms]  WITH CHECK ADD  CONSTRAINT [FK_DfnGroupNorms_DfnTemperamentTypes_TemperamentId] FOREIGN KEY([TemperamentId])
REFERENCES [dbo].[DfnTemperamentTypes] ([Id])
GO
ALTER TABLE [dbo].[DfnGroupNorms] CHECK CONSTRAINT [FK_DfnGroupNorms_DfnTemperamentTypes_TemperamentId]
GO
ALTER TABLE [dbo].[DfnGuidanceSurveys]  WITH CHECK ADD  CONSTRAINT [FK_DfnGuidanceSurveys_DfnSurveyCriteriaGroups_DfnSurveyCriteriaGroupId] FOREIGN KEY([DfnSurveyCriteriaGroupId])
REFERENCES [dbo].[DfnSurveyCriteriaGroups01] ([Id])
GO
ALTER TABLE [dbo].[DfnGuidanceSurveys] CHECK CONSTRAINT [FK_DfnGuidanceSurveys_DfnSurveyCriteriaGroups_DfnSurveyCriteriaGroupId]
GO
ALTER TABLE [dbo].[DfnGuidanceTemperamentSurveys]  WITH CHECK ADD  CONSTRAINT [FK_DfnGuidanceTemperamentSurveys_DfnGuidanceSurveys_DfnGuidanceSurveyId] FOREIGN KEY([DfnGuidanceSurveyId])
REFERENCES [dbo].[DfnGuidanceSurveys] ([Id])
GO
ALTER TABLE [dbo].[DfnGuidanceTemperamentSurveys] CHECK CONSTRAINT [FK_DfnGuidanceTemperamentSurveys_DfnGuidanceSurveys_DfnGuidanceSurveyId]
GO
ALTER TABLE [dbo].[DfnHarmony]  WITH CHECK ADD  CONSTRAINT [FK_DfnHarmony_DfnTemperamentTypes_TemperamentType1Id] FOREIGN KEY([TemperamentType1Id])
REFERENCES [dbo].[DfnTemperamentTypes] ([Id])
GO
ALTER TABLE [dbo].[DfnHarmony] CHECK CONSTRAINT [FK_DfnHarmony_DfnTemperamentTypes_TemperamentType1Id]
GO
ALTER TABLE [dbo].[DfnHarmony]  WITH CHECK ADD  CONSTRAINT [FK_DfnHarmony_DfnTemperamentTypes_TemperamentType2Id] FOREIGN KEY([TemperamentType2Id])
REFERENCES [dbo].[DfnTemperamentTypes] ([Id])
GO
ALTER TABLE [dbo].[DfnHarmony] CHECK CONSTRAINT [FK_DfnHarmony_DfnTemperamentTypes_TemperamentType2Id]
GO
ALTER TABLE [dbo].[DfnMentalTalentReports]  WITH CHECK ADD  CONSTRAINT [FK_DfnMentalTalentReports_DfnSurveyCriteriaGroups_DfnSurveyCriteriaGroupId] FOREIGN KEY([DfnSurveyCriteriaGroupId])
REFERENCES [dbo].[DfnSurveyCriteriaGroups] ([Id])
GO
ALTER TABLE [dbo].[DfnMentalTalentReports] CHECK CONSTRAINT [FK_DfnMentalTalentReports_DfnSurveyCriteriaGroups_DfnSurveyCriteriaGroupId]
GO
ALTER TABLE [dbo].[DfnReportTypeParagraphs]  WITH CHECK ADD  CONSTRAINT [FK_DfnReportTypeParagraphs_DfnReportTypes_ReportTypeId] FOREIGN KEY([ReportTypeId])
REFERENCES [dbo].[DfnReportTypes] ([Id])
GO
ALTER TABLE [dbo].[DfnReportTypeParagraphs] CHECK CONSTRAINT [FK_DfnReportTypeParagraphs_DfnReportTypes_ReportTypeId]
GO
ALTER TABLE [dbo].[DfnSurveyCategories]  WITH CHECK ADD  CONSTRAINT [FK_DfnSurveyCategories_DfnSurveyCategoryTypes_DfnSurveyCategoryTypeId] FOREIGN KEY([DfnSurveyCategoryTypeId])
REFERENCES [dbo].[DfnSurveyCategoryTypes] ([Id])
GO
ALTER TABLE [dbo].[DfnSurveyCategories] CHECK CONSTRAINT [FK_DfnSurveyCategories_DfnSurveyCategoryTypes_DfnSurveyCategoryTypeId]
GO
ALTER TABLE [dbo].[DfnSurveyCriteriaGroups]  WITH CHECK ADD  CONSTRAINT [FK_DfnSurveyCriteriaGroupsCopy_DfnSurveyCategories_SurveyCategoryId] FOREIGN KEY([SurveyCategoryId])
REFERENCES [dbo].[DfnSurveyCategories] ([Id])
GO
ALTER TABLE [dbo].[DfnSurveyCriteriaGroups] CHECK CONSTRAINT [FK_DfnSurveyCriteriaGroupsCopy_DfnSurveyCategories_SurveyCategoryId]
GO
ALTER TABLE [dbo].[DfnSurveyCriteriaGroups01]  WITH CHECK ADD  CONSTRAINT [FK_DfnSurveyCriteriaGroups_DfnSurveyCategories_SurveyCategoryId] FOREIGN KEY([SurveyCategoryId])
REFERENCES [dbo].[DfnSurveyCategories] ([Id])
GO
ALTER TABLE [dbo].[DfnSurveyCriteriaGroups01] CHECK CONSTRAINT [FK_DfnSurveyCriteriaGroups_DfnSurveyCategories_SurveyCategoryId]
GO
ALTER TABLE [dbo].[DfnSurveyCriteriaQuestions]  WITH CHECK ADD  CONSTRAINT [FK_DfnSurveyCriteriaQuestions_DfnSurveyCriterias_DfnSurveyCriteriaId] FOREIGN KEY([DfnSurveyCriteriaId])
REFERENCES [dbo].[DfnSurveyCriterias] ([Id])
GO
ALTER TABLE [dbo].[DfnSurveyCriteriaQuestions] CHECK CONSTRAINT [FK_DfnSurveyCriteriaQuestions_DfnSurveyCriterias_DfnSurveyCriteriaId]
GO
ALTER TABLE [dbo].[DfnSurveyCriterias]  WITH CHECK ADD  CONSTRAINT [FK_DfnSurveyCriterias_DfnSurveyCriteriaGroups_CriteriaGroupId] FOREIGN KEY([CriteriaGroupId])
REFERENCES [dbo].[DfnSurveyCriteriaGroups01] ([Id])
GO
ALTER TABLE [dbo].[DfnSurveyCriterias] CHECK CONSTRAINT [FK_DfnSurveyCriterias_DfnSurveyCriteriaGroups_CriteriaGroupId]
GO
ALTER TABLE [dbo].[DfnTeacherDistributionOrders]  WITH CHECK ADD  CONSTRAINT [FK_DfnTeacherDistributionOrders_DfnTemperamentTypes_TemperamentTypeId] FOREIGN KEY([TemperamentTypeId])
REFERENCES [dbo].[DfnTemperamentTypes] ([Id])
GO
ALTER TABLE [dbo].[DfnTeacherDistributionOrders] CHECK CONSTRAINT [FK_DfnTeacherDistributionOrders_DfnTemperamentTypes_TemperamentTypeId]
GO
ALTER TABLE [dbo].[GuidanceSurveyCriteriaAndGroupScores]  WITH CHECK ADD  CONSTRAINT [FK_GuidanceSurveyCriteriaAndGroupScores_DfnSurveyCriteriaGroups_DfnSurveyCriteriaGroupId] FOREIGN KEY([DfnSurveyCriteriaGroupId])
REFERENCES [dbo].[DfnSurveyCriteriaGroups01] ([Id])
GO
ALTER TABLE [dbo].[GuidanceSurveyCriteriaAndGroupScores] CHECK CONSTRAINT [FK_GuidanceSurveyCriteriaAndGroupScores_DfnSurveyCriteriaGroups_DfnSurveyCriteriaGroupId]
GO
ALTER TABLE [dbo].[GuidanceSurveyCriteriaAndGroupScores]  WITH CHECK ADD  CONSTRAINT [FK_GuidanceSurveyCriteriaAndGroupScores_DfnSurveyCriterias_DfnSurveyCriteriaId] FOREIGN KEY([DfnSurveyCriteriaId])
REFERENCES [dbo].[DfnSurveyCriterias] ([Id])
GO
ALTER TABLE [dbo].[GuidanceSurveyCriteriaAndGroupScores] CHECK CONSTRAINT [FK_GuidanceSurveyCriteriaAndGroupScores_DfnSurveyCriterias_DfnSurveyCriteriaId]
GO
ALTER TABLE [dbo].[GuidanceSurveyCriteriaAndGroupScores]  WITH CHECK ADD  CONSTRAINT [FK_GuidanceSurveyCriteriaAndGroupScores_GuidanceSurveyResults_GuidanceSurveyResultId] FOREIGN KEY([GuidanceSurveyResultId])
REFERENCES [dbo].[GuidanceSurveyResults] ([Id])
GO
ALTER TABLE [dbo].[GuidanceSurveyCriteriaAndGroupScores] CHECK CONSTRAINT [FK_GuidanceSurveyCriteriaAndGroupScores_GuidanceSurveyResults_GuidanceSurveyResultId]
GO
ALTER TABLE [dbo].[GuidanceSurveyQuestionAnswers]  WITH CHECK ADD  CONSTRAINT [FK_GuidanceSurveyQuestionAnswers_GuidanceSurveyResults_GuidanceSurveyResultId] FOREIGN KEY([GuidanceSurveyResultId])
REFERENCES [dbo].[GuidanceSurveyResults] ([Id])
GO
ALTER TABLE [dbo].[GuidanceSurveyQuestionAnswers] CHECK CONSTRAINT [FK_GuidanceSurveyQuestionAnswers_GuidanceSurveyResults_GuidanceSurveyResultId]
GO
ALTER TABLE [dbo].[GuidanceSurveyResults]  WITH CHECK ADD  CONSTRAINT [FK_GuidanceSurveyResults_DfnGuidanceSurveys_DfnGuidanceSurveyId] FOREIGN KEY([DfnGuidanceSurveyId])
REFERENCES [dbo].[DfnGuidanceSurveys] ([Id])
GO
ALTER TABLE [dbo].[GuidanceSurveyResults] CHECK CONSTRAINT [FK_GuidanceSurveyResults_DfnGuidanceSurveys_DfnGuidanceSurveyId]
GO
ALTER TABLE [dbo].[GuidanceUserSurveys]  WITH CHECK ADD  CONSTRAINT [FK_GuidanceUserSurveys_DfnGuidanceSurveys_DfnGuidanceSurveyId] FOREIGN KEY([DfnGuidanceSurveyId])
REFERENCES [dbo].[DfnGuidanceSurveys] ([Id])
GO
ALTER TABLE [dbo].[GuidanceUserSurveys] CHECK CONSTRAINT [FK_GuidanceUserSurveys_DfnGuidanceSurveys_DfnGuidanceSurveyId]
GO
ALTER TABLE [dbo].[HrCategories]  WITH CHECK ADD  CONSTRAINT [FK_HrCategories_HrCategoryTags_HrCategoryTagId] FOREIGN KEY([HrCategoryTagId])
REFERENCES [dbo].[HrCategoryTags] ([Id])
GO
ALTER TABLE [dbo].[HrCategories] CHECK CONSTRAINT [FK_HrCategories_HrCategoryTags_HrCategoryTagId]
GO
ALTER TABLE [dbo].[HrCriterias]  WITH CHECK ADD  CONSTRAINT [FK_HrCriterias_HrCategories_HrCategoryId] FOREIGN KEY([HrCategoryId])
REFERENCES [dbo].[HrCategories] ([Id])
GO
ALTER TABLE [dbo].[HrCriterias] CHECK CONSTRAINT [FK_HrCriterias_HrCategories_HrCategoryId]
GO
ALTER TABLE [dbo].[HrDepartments]  WITH CHECK ADD  CONSTRAINT [FK_HrDepartments_Organizations_OrganizationId] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organizations] ([Id])
GO
ALTER TABLE [dbo].[HrDepartments] CHECK CONSTRAINT [FK_HrDepartments_Organizations_OrganizationId]
GO
ALTER TABLE [dbo].[HrPositions]  WITH CHECK ADD  CONSTRAINT [FK_HrPositions_HrDepartments_DepartmentId] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[HrDepartments] ([Id])
GO
ALTER TABLE [dbo].[HrPositions] CHECK CONSTRAINT [FK_HrPositions_HrDepartments_DepartmentId]
GO
ALTER TABLE [dbo].[HrPreparedTemplateDetails]  WITH CHECK ADD  CONSTRAINT [FK_HrPreparedTemplateDetails_HrPreparedTemplates_HrPreparedTemplateId] FOREIGN KEY([HrPreparedTemplateId])
REFERENCES [dbo].[HrPreparedTemplates] ([Id])
GO
ALTER TABLE [dbo].[HrPreparedTemplateDetails] CHECK CONSTRAINT [FK_HrPreparedTemplateDetails_HrPreparedTemplates_HrPreparedTemplateId]
GO
ALTER TABLE [dbo].[HrUserSurveyQAs]  WITH CHECK ADD  CONSTRAINT [FK_HrUserSurveyQAs_HrUserSurveys_HrUserSurveysId] FOREIGN KEY([HrUserSurveysId])
REFERENCES [dbo].[HrUserSurveys] ([Id])
GO
ALTER TABLE [dbo].[HrUserSurveyQAs] CHECK CONSTRAINT [FK_HrUserSurveyQAs_HrUserSurveys_HrUserSurveysId]
GO
ALTER TABLE [dbo].[InterviewNotes]  WITH CHECK ADD  CONSTRAINT [FK_InterviewNotes_DfnInterviewNoteCriterias_DfnInterviewNoteCriteriaId] FOREIGN KEY([DfnInterviewNoteCriteriaId])
REFERENCES [dbo].[DfnInterviewNoteCriterias] ([Id])
GO
ALTER TABLE [dbo].[InterviewNotes] CHECK CONSTRAINT [FK_InterviewNotes_DfnInterviewNoteCriterias_DfnInterviewNoteCriteriaId]
GO
ALTER TABLE [dbo].[MenuActions]  WITH CHECK ADD  CONSTRAINT [FK_MenuActions_MenuActions_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[MenuActions] ([Id])
GO
ALTER TABLE [dbo].[MenuActions] CHECK CONSTRAINT [FK_MenuActions_MenuActions_ParentId]
GO
ALTER TABLE [dbo].[Organizations]  WITH CHECK ADD  CONSTRAINT [FK_Organizations_Organizations_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[Organizations] ([Id])
GO
ALTER TABLE [dbo].[Organizations] CHECK CONSTRAINT [FK_Organizations_Organizations_ParentId]
GO
ALTER TABLE [dbo].[Organizations]  WITH CHECK ADD  CONSTRAINT [FK_Organizations_OrganTypes_OrganTypeId] FOREIGN KEY([OrganTypeId])
REFERENCES [dbo].[OrganTypes] ([Id])
GO
ALTER TABLE [dbo].[Organizations] CHECK CONSTRAINT [FK_Organizations_OrganTypes_OrganTypeId]
GO
ALTER TABLE [dbo].[Parents]  WITH CHECK ADD  CONSTRAINT [FK_Parents_Users_UserParentId] FOREIGN KEY([UserParentId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Parents] CHECK CONSTRAINT [FK_Parents_Users_UserParentId]
GO
ALTER TABLE [dbo].[Parents]  WITH CHECK ADD  CONSTRAINT [FK_Parents_Users_UserStudentId] FOREIGN KEY([UserStudentId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Parents] CHECK CONSTRAINT [FK_Parents_Users_UserStudentId]
GO
ALTER TABLE [dbo].[PropertyRoles]  WITH CHECK ADD  CONSTRAINT [FK_PropertyRoles_Properties_PropertyId] FOREIGN KEY([PropertyId])
REFERENCES [dbo].[Properties] ([Id])
GO
ALTER TABLE [dbo].[PropertyRoles] CHECK CONSTRAINT [FK_PropertyRoles_Properties_PropertyId]
GO
ALTER TABLE [dbo].[PropertyRoles]  WITH CHECK ADD  CONSTRAINT [FK_PropertyRoles_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[PropertyRoles] CHECK CONSTRAINT [FK_PropertyRoles_Roles_RoleId]
GO
ALTER TABLE [dbo].[RelGuidanceSurveyCriteriaQuestions]  WITH CHECK ADD  CONSTRAINT [FK_RelGuidanceSurveyCriteriaQuestions_DfnGuidanceSurveys_GuidanceSurveyId] FOREIGN KEY([GuidanceSurveyId])
REFERENCES [dbo].[DfnGuidanceSurveys] ([Id])
GO
ALTER TABLE [dbo].[RelGuidanceSurveyCriteriaQuestions] CHECK CONSTRAINT [FK_RelGuidanceSurveyCriteriaQuestions_DfnGuidanceSurveys_GuidanceSurveyId]
GO
ALTER TABLE [dbo].[RelOrganizationMenuActions]  WITH CHECK ADD  CONSTRAINT [FK_RelOrganizationMenuActions_MenuActions_MenuActionId] FOREIGN KEY([MenuActionId])
REFERENCES [dbo].[MenuActions] ([Id])
GO
ALTER TABLE [dbo].[RelOrganizationMenuActions] CHECK CONSTRAINT [FK_RelOrganizationMenuActions_MenuActions_MenuActionId]
GO
ALTER TABLE [dbo].[RelOrganizationMenuActions]  WITH CHECK ADD  CONSTRAINT [FK_RelOrganizationMenuActions_Organizations_OrganizationId] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organizations] ([Id])
GO
ALTER TABLE [dbo].[RelOrganizationMenuActions] CHECK CONSTRAINT [FK_RelOrganizationMenuActions_Organizations_OrganizationId]
GO
ALTER TABLE [dbo].[RelSurveyRoles]  WITH CHECK ADD  CONSTRAINT [FK_RelSurveyRoles_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[RelSurveyRoles] CHECK CONSTRAINT [FK_RelSurveyRoles_Roles_RoleId]
GO
ALTER TABLE [dbo].[RelSurveyRoles]  WITH CHECK ADD  CONSTRAINT [FK_RelSurveyRoles_Surveys_SurveyId] FOREIGN KEY([SurveyId])
REFERENCES [dbo].[Surveys] ([Id])
GO
ALTER TABLE [dbo].[RelSurveyRoles] CHECK CONSTRAINT [FK_RelSurveyRoles_Surveys_SurveyId]
GO
ALTER TABLE [dbo].[RoleMenuActions]  WITH CHECK ADD  CONSTRAINT [FK_RoleMenuActions_MenuActions_MenuActionId] FOREIGN KEY([MenuActionId])
REFERENCES [dbo].[MenuActions] ([Id])
GO
ALTER TABLE [dbo].[RoleMenuActions] CHECK CONSTRAINT [FK_RoleMenuActions_MenuActions_MenuActionId]
GO
ALTER TABLE [dbo].[RoleMenuActions]  WITH CHECK ADD  CONSTRAINT [FK_RoleMenuActions_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[RoleMenuActions] CHECK CONSTRAINT [FK_RoleMenuActions_Roles_RoleId]
GO
ALTER TABLE [dbo].[SelectedStudentConsultancyCriterias]  WITH CHECK ADD  CONSTRAINT [FK_SelectedStudentConsultancyCriterias_SelectedStudentConsultancies_SelectedStudentConsultancyId] FOREIGN KEY([SelectedStudentConsultancyId])
REFERENCES [dbo].[SelectedStudentConsultancies] ([Id])
GO
ALTER TABLE [dbo].[SelectedStudentConsultancyCriterias] CHECK CONSTRAINT [FK_SelectedStudentConsultancyCriterias_SelectedStudentConsultancies_SelectedStudentConsultancyId]
GO
ALTER TABLE [dbo].[SelectedStudentConsultancyNotes]  WITH CHECK ADD  CONSTRAINT [FK_SelectedStudentConsultancyNotes_SelectedStudentConsultancyCriterias_SelectedStudentConsultancyCriteriasId] FOREIGN KEY([SelectedStudentConsultancyCriteriasId])
REFERENCES [dbo].[SelectedStudentConsultancyCriterias] ([Id])
GO
ALTER TABLE [dbo].[SelectedStudentConsultancyNotes] CHECK CONSTRAINT [FK_SelectedStudentConsultancyNotes_SelectedStudentConsultancyCriterias_SelectedStudentConsultancyCriteriasId]
GO
ALTER TABLE [dbo].[SittingPlanClassroomDesks]  WITH CHECK ADD  CONSTRAINT [FK_SittingPlanClassroomDesks_ClassroomSittingPlanTemplates_SittingPlanId] FOREIGN KEY([SittingPlanId])
REFERENCES [dbo].[ClassroomSittingPlanTemplates] ([Id])
GO
ALTER TABLE [dbo].[SittingPlanClassroomDesks] CHECK CONSTRAINT [FK_SittingPlanClassroomDesks_ClassroomSittingPlanTemplates_SittingPlanId]
GO
ALTER TABLE [dbo].[SittingPlanClassroomDesks]  WITH CHECK ADD  CONSTRAINT [FK_SittingPlanClassroomDesks_Users_StudentId] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[SittingPlanClassroomDesks] CHECK CONSTRAINT [FK_SittingPlanClassroomDesks_Users_StudentId]
GO
ALTER TABLE [dbo].[SittingPlansTemperamentRules]  WITH CHECK ADD  CONSTRAINT [FK_SittingPlansTemperamentRules_DfnTemperamentTypes_TemperamentTypeId] FOREIGN KEY([TemperamentTypeId])
REFERENCES [dbo].[DfnTemperamentTypes] ([Id])
GO
ALTER TABLE [dbo].[SittingPlansTemperamentRules] CHECK CONSTRAINT [FK_SittingPlansTemperamentRules_DfnTemperamentTypes_TemperamentTypeId]
GO
ALTER TABLE [dbo].[States]  WITH CHECK ADD  CONSTRAINT [FK_States_Countries_CountryId] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[States] CHECK CONSTRAINT [FK_States_Countries_CountryId]
GO
ALTER TABLE [dbo].[StudentDistributions]  WITH CHECK ADD  CONSTRAINT [FK_StudentDistributions_TempClassrooms_TempClassroomId] FOREIGN KEY([TempClassroomId])
REFERENCES [dbo].[TempClassrooms] ([Id])
GO
ALTER TABLE [dbo].[StudentDistributions] CHECK CONSTRAINT [FK_StudentDistributions_TempClassrooms_TempClassroomId]
GO
ALTER TABLE [dbo].[SurveyCriteriaGroupScores]  WITH CHECK ADD  CONSTRAINT [FK_SurveyCriteriaGroupScores_DfnSurveyCriteriaGroups_DfnSurveyCriteriaGroupId] FOREIGN KEY([DfnSurveyCriteriaGroupId])
REFERENCES [dbo].[DfnSurveyCriteriaGroups01] ([Id])
GO
ALTER TABLE [dbo].[SurveyCriteriaGroupScores] CHECK CONSTRAINT [FK_SurveyCriteriaGroupScores_DfnSurveyCriteriaGroups_DfnSurveyCriteriaGroupId]
GO
ALTER TABLE [dbo].[SurveyCriteriaGroupScores]  WITH CHECK ADD  CONSTRAINT [FK_SurveyCriteriaGroupScores_SurveyResults_SurveyResultId] FOREIGN KEY([SurveyResultId])
REFERENCES [dbo].[SurveyResults] ([Id])
GO
ALTER TABLE [dbo].[SurveyCriteriaGroupScores] CHECK CONSTRAINT [FK_SurveyCriteriaGroupScores_SurveyResults_SurveyResultId]
GO
ALTER TABLE [dbo].[SurveyCriteriaScores]  WITH CHECK ADD  CONSTRAINT [FK_SurveyCriteriaScores_DfnSurveyCriterias_DfnSurveyCriteriaId] FOREIGN KEY([DfnSurveyCriteriaId])
REFERENCES [dbo].[DfnSurveyCriterias] ([Id])
GO
ALTER TABLE [dbo].[SurveyCriteriaScores] CHECK CONSTRAINT [FK_SurveyCriteriaScores_DfnSurveyCriterias_DfnSurveyCriteriaId]
GO
ALTER TABLE [dbo].[SurveyCriteriaScores]  WITH CHECK ADD  CONSTRAINT [FK_SurveyCriteriaScores_SurveyResults_SurveyResultId] FOREIGN KEY([SurveyResultId])
REFERENCES [dbo].[SurveyResults] ([Id])
GO
ALTER TABLE [dbo].[SurveyCriteriaScores] CHECK CONSTRAINT [FK_SurveyCriteriaScores_SurveyResults_SurveyResultId]
GO
ALTER TABLE [dbo].[SurveyQuestionAnswers]  WITH CHECK ADD  CONSTRAINT [FK_SurveyQuestionAnswers_SurveyResults_SurveyResultId] FOREIGN KEY([SurveyResultId])
REFERENCES [dbo].[SurveyResults] ([Id])
GO
ALTER TABLE [dbo].[SurveyQuestionAnswers] CHECK CONSTRAINT [FK_SurveyQuestionAnswers_SurveyResults_SurveyResultId]
GO
ALTER TABLE [dbo].[SurveyResults]  WITH CHECK ADD  CONSTRAINT [FK_SurveyResults_Surveys_SurveyId] FOREIGN KEY([SurveyId])
REFERENCES [dbo].[Surveys] ([Id])
GO
ALTER TABLE [dbo].[SurveyResults] CHECK CONSTRAINT [FK_SurveyResults_Surveys_SurveyId]
GO
ALTER TABLE [dbo].[SurveyResults]  WITH CHECK ADD  CONSTRAINT [FK_SurveyResults_Terms_TermId] FOREIGN KEY([TermId])
REFERENCES [dbo].[Terms] ([Id])
GO
ALTER TABLE [dbo].[SurveyResults] CHECK CONSTRAINT [FK_SurveyResults_Terms_TermId]
GO
ALTER TABLE [dbo].[SurveyResults]  WITH CHECK ADD  CONSTRAINT [FK_SurveyResults_UserOrganizationRoles_UserOrganizationRoleId] FOREIGN KEY([UserOrganizationRoleId])
REFERENCES [dbo].[UserOrganizationRoles] ([Id])
GO
ALTER TABLE [dbo].[SurveyResults] CHECK CONSTRAINT [FK_SurveyResults_UserOrganizationRoles_UserOrganizationRoleId]
GO
ALTER TABLE [dbo].[SurveyResults]  WITH CHECK ADD  CONSTRAINT [FK_SurveyResults_UserOrganizationRoles_UserOrganizationRoleSolverUserId] FOREIGN KEY([UserOrganizationRoleSolverUserId])
REFERENCES [dbo].[UserOrganizationRoles] ([Id])
GO
ALTER TABLE [dbo].[SurveyResults] CHECK CONSTRAINT [FK_SurveyResults_UserOrganizationRoles_UserOrganizationRoleSolverUserId]
GO
ALTER TABLE [dbo].[SurveyResults]  WITH CHECK ADD  CONSTRAINT [FK_SurveyResults_Users_SolvedUserId] FOREIGN KEY([SolvedUserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[SurveyResults] CHECK CONSTRAINT [FK_SurveyResults_Users_SolvedUserId]
GO
ALTER TABLE [dbo].[Surveys]  WITH CHECK ADD  CONSTRAINT [FK_Surveys_DfnSurveyCategories_DfnSurveyCategoryId] FOREIGN KEY([DfnSurveyCategoryId])
REFERENCES [dbo].[DfnSurveyCategories] ([Id])
GO
ALTER TABLE [dbo].[Surveys] CHECK CONSTRAINT [FK_Surveys_DfnSurveyCategories_DfnSurveyCategoryId]
GO
ALTER TABLE [dbo].[TempClassrooms]  WITH CHECK ADD  CONSTRAINT [FK_TempClassrooms_ClassroomDistributionTemplates_ClassroomDistributionTemplateId] FOREIGN KEY([ClassroomDistributionTemplateId])
REFERENCES [dbo].[ClassroomDistributionTemplates] ([Id])
GO
ALTER TABLE [dbo].[TempClassrooms] CHECK CONSTRAINT [FK_TempClassrooms_ClassroomDistributionTemplates_ClassroomDistributionTemplateId]
GO
ALTER TABLE [dbo].[TempClassrooms]  WITH CHECK ADD  CONSTRAINT [FK_TempClassrooms_Users_ClassProposedTeacherId] FOREIGN KEY([ClassProposedTeacherId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[TempClassrooms] CHECK CONSTRAINT [FK_TempClassrooms_Users_ClassProposedTeacherId]
GO
ALTER TABLE [dbo].[TemperamentConfirmationLogs]  WITH CHECK ADD  CONSTRAINT [FK_TemperamentConfirmationLogs_Temperaments_TemperamentId] FOREIGN KEY([TemperamentId])
REFERENCES [dbo].[Temperaments] ([Id])
GO
ALTER TABLE [dbo].[TemperamentConfirmationLogs] CHECK CONSTRAINT [FK_TemperamentConfirmationLogs_Temperaments_TemperamentId]
GO
ALTER TABLE [dbo].[TemperamentConfirmationLogs]  WITH CHECK ADD  CONSTRAINT [FK_TemperamentConfirmationLogs_UserOrganizationRoles_ProcessingUserOrgRoleId] FOREIGN KEY([ProcessingUserOrgRoleId])
REFERENCES [dbo].[UserOrganizationRoles] ([Id])
GO
ALTER TABLE [dbo].[TemperamentConfirmationLogs] CHECK CONSTRAINT [FK_TemperamentConfirmationLogs_UserOrganizationRoles_ProcessingUserOrgRoleId]
GO
ALTER TABLE [dbo].[Temperaments]  WITH CHECK ADD  CONSTRAINT [FK_Temperaments_UserOrganizationRoles_SolverUserOrgRoleId] FOREIGN KEY([SolverUserOrgRoleId])
REFERENCES [dbo].[UserOrganizationRoles] ([Id])
GO
ALTER TABLE [dbo].[Temperaments] CHECK CONSTRAINT [FK_Temperaments_UserOrganizationRoles_SolverUserOrgRoleId]
GO
ALTER TABLE [dbo].[Temperaments]  WITH CHECK ADD  CONSTRAINT [FK_Temperaments_UserOrganizationRoles_UserOrgRoleId] FOREIGN KEY([UserOrgRoleId])
REFERENCES [dbo].[UserOrganizationRoles] ([Id])
GO
ALTER TABLE [dbo].[Temperaments] CHECK CONSTRAINT [FK_Temperaments_UserOrganizationRoles_UserOrgRoleId]
GO
ALTER TABLE [dbo].[userDashboardModules]  WITH CHECK ADD  CONSTRAINT [FK_userDashboardModules_dfnDashboardModules_IdDashboard] FOREIGN KEY([IdDashboard])
REFERENCES [dbo].[dfnDashboardModules] ([IdDashboard])
GO
ALTER TABLE [dbo].[userDashboardModules] CHECK CONSTRAINT [FK_userDashboardModules_dfnDashboardModules_IdDashboard]
GO
ALTER TABLE [dbo].[userDashboardModules]  WITH CHECK ADD  CONSTRAINT [FK_userDashboardModules_UserOrganizationRoles_UserOrganizationRoleId] FOREIGN KEY([UserOrganizationRoleId])
REFERENCES [dbo].[UserOrganizationRoles] ([Id])
GO
ALTER TABLE [dbo].[userDashboardModules] CHECK CONSTRAINT [FK_userDashboardModules_UserOrganizationRoles_UserOrganizationRoleId]
GO
ALTER TABLE [dbo].[UserExtraMenuActions]  WITH CHECK ADD  CONSTRAINT [FK_UserExtraMenuActions_MenuActions_MenuActionId] FOREIGN KEY([MenuActionId])
REFERENCES [dbo].[MenuActions] ([Id])
GO
ALTER TABLE [dbo].[UserExtraMenuActions] CHECK CONSTRAINT [FK_UserExtraMenuActions_MenuActions_MenuActionId]
GO
ALTER TABLE [dbo].[UserExtraMenuActions]  WITH CHECK ADD  CONSTRAINT [FK_UserExtraMenuActions_UserOrganizationRoles_UserOrganizationRoleId] FOREIGN KEY([UserOrganizationRoleId])
REFERENCES [dbo].[UserOrganizationRoles] ([Id])
GO
ALTER TABLE [dbo].[UserExtraMenuActions] CHECK CONSTRAINT [FK_UserExtraMenuActions_UserOrganizationRoles_UserOrganizationRoleId]
GO
ALTER TABLE [dbo].[UserOrganizationRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserOrganizationRoles_Organizations_OrganizationId] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organizations] ([Id])
GO
ALTER TABLE [dbo].[UserOrganizationRoles] CHECK CONSTRAINT [FK_UserOrganizationRoles_Organizations_OrganizationId]
GO
ALTER TABLE [dbo].[UserOrganizationRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserOrganizationRoles_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[UserOrganizationRoles] CHECK CONSTRAINT [FK_UserOrganizationRoles_Roles_RoleId]
GO
ALTER TABLE [dbo].[UserOrganizationRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserOrganizationRoles_Terms_TermId] FOREIGN KEY([TermId])
REFERENCES [dbo].[Terms] ([Id])
GO
ALTER TABLE [dbo].[UserOrganizationRoles] CHECK CONSTRAINT [FK_UserOrganizationRoles_Terms_TermId]
GO
ALTER TABLE [dbo].[UserOrganizationRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserOrganizationRoles_userDashboardModules_UserDashboardModuleUserDashboard] FOREIGN KEY([UserDashboardModuleUserDashboard])
REFERENCES [dbo].[userDashboardModules] ([UserDashboard])
GO
ALTER TABLE [dbo].[UserOrganizationRoles] CHECK CONSTRAINT [FK_UserOrganizationRoles_userDashboardModules_UserDashboardModuleUserDashboard]
GO
ALTER TABLE [dbo].[UserOrganizationRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserOrganizationRoles_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UserOrganizationRoles] CHECK CONSTRAINT [FK_UserOrganizationRoles_Users_UserId]
GO
ALTER TABLE [dbo].[UserProperties]  WITH CHECK ADD  CONSTRAINT [FK_UserProperties_Properties_PropertyId] FOREIGN KEY([PropertyId])
REFERENCES [dbo].[Properties] ([Id])
GO
ALTER TABLE [dbo].[UserProperties] CHECK CONSTRAINT [FK_UserProperties_Properties_PropertyId]
GO
ALTER TABLE [dbo].[UserProperties]  WITH CHECK ADD  CONSTRAINT [FK_UserProperties_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UserProperties] CHECK CONSTRAINT [FK_UserProperties_Users_UserId]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_DfnTemperamentTypes_TemperamentTypeId] FOREIGN KEY([TemperamentTypeId])
REFERENCES [dbo].[DfnTemperamentTypes] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_DfnTemperamentTypes_TemperamentTypeId]
GO
/****** Object:  StoredProcedure [dbo].[SpDevelopmentTracking]    Script Date: 14.11.2019 09:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SpDevelopmentTracking](@UserId uniqueidentifier,@CategoryId int )
AS
BEGIN
declare @CategoryTagId int=0;

 select @CategoryTagId=c.CategoryTagId from HrCategories c where c.Id=@CategoryId

 if (@CategoryTagId=2)
 begin

 update HrRiskTracking set IsLastEveluation=null where UserId=@UserId
   
 insert into HrRiskTracking 
 select NEWID(),@UserId,t.CategoryID,t.Score,1,CURRENT_TIMESTAMP from VHrUserRiskEveluationTracking t
 where t.EvaluatedUserId=@UserId

 end

 if (@CategoryTagId=10)
 begin

 update HrPerfectionDevelopmentTracking set IsLastEveluation=null where UserId=@UserId

 insert into HrPerfectionDevelopmentTracking 
 select NEWID(),t.EvaluatedUserId,t.CategoryID,t.CriteriaId,t.CriteriaEveluationAvg,t.CriteriaSelfEveluationAvg,
 t.CriteriaPerceivedEveluationAvg,t.TemperamentScore,1,CURRENT_TIMESTAMP from VHrPerfectionEvaluationAvgTracking t
 where t.EvaluatedUserId=@UserId
 end

  if (@CategoryTagId=9)
 begin

 update HrMeritDevelopmentTracking set IsLastEveluation=null where UserId=@UserId

 insert into HrMeritDevelopmentTracking 
 select NEWID(),t.EvaluatedUserId,t.CategoryID,t.CriteriaId,t.CriteriaEveluationAvg,t.CriteriaSelfEveluationAvg,
 t.CriteriaPerceivedEveluationAvg,t.TemperamentScore,1,CURRENT_TIMESTAMP from VHrMeritEvaluationAvgTracking t
 where t.EvaluatedUserId=@UserId
 end

 if (@CategoryTagId=11)
 begin

 update HrSocialQualificationDevelopmentTracking set IsLastEveluation=null where UserId=@UserId

 insert into HrSocialQualificationDevelopmentTracking 
 select NEWID(),t.EvaluatedUserId,t.CategoryID,t.CriteriaId,t.CriteriaEveluationAvg,t.CriteriaSelfEveluationAvg,
 t.CriteriaPerceivedEveluationAvg,t.TemperamentScore,1,CURRENT_TIMESTAMP from VHrSocialQualificationEvaluationAvgTracking t
 where t.EvaluatedUserId=@UserId

 end

  if (@CategoryTagId=11 or @CategoryTagId=10 or @CategoryTagId=9 ) /*Genel Liyakat*/
  begin
	 if exists (select 1 from HrPerfectionDevelopmentTracking t where t.UserId=@UserId)
	 begin
		 if exists (select 1 from HrSocialQualificationDevelopmentTracking t where t.UserId=@UserId)
		 begin
			 if exists (select 1 from HrMeritDevelopmentTracking t where t.UserId=@UserId)
			 begin

			 update HrGeneralMeritDevelopmentTracking  set IsLastEveluation=null where UserId=@UserId

			 insert into HrGeneralMeritDevelopmentTracking 
			 select NEWID(),
			 @UserId,
			 @CategoryId,
			 GeneralMeritScore,
			 SelfMeritScore,
			 PerceivedMeritScore,
			 TemperamentMeritScore,
			 PositionID,
			 PositionLevel,
			 1,
			 CURRENT_TIMESTAMP 
			 from 
				(
				select u.Id as UserID,u.PositionID,po.PositionLevel,
				case when po.PositionLevel=1 then Round(AVG(p.GeneralScore)*0.5+AVG(s.GeneralScore)*0.3+AVG(m.GeneralScore)*0.2,0) 
					 when po.PositionLevel=2 then Round(AVG(p.GeneralScore)*0.4+AVG(s.GeneralScore)*0.3+AVG(m.GeneralScore)*0.3,0)
					 when po.PositionLevel=3 then Round(AVG(p.GeneralScore)*0.4+AVG(s.GeneralScore)*0.35+AVG(m.GeneralScore)*0.25,0)
					 end as GeneralMeritScore,
				case when po.PositionLevel=1 then Round(AVG(p.SelfScore)*0.5+AVG(s.SelfScore)*0.3+AVG(m.SelfScore)*0.2,0) 
					 when po.PositionLevel=2 then Round(AVG(p.SelfScore)*0.4+AVG(s.SelfScore)*0.3+AVG(m.SelfScore)*0.3,0)
					 when po.PositionLevel=3 then Round(AVG(p.SelfScore)*0.4+AVG(s.SelfScore)*0.35+AVG(m.SelfScore)*0.25,0)
					 end as SelfMeritScore,
				case when po.PositionLevel=1 then Round(AVG(p.PerceivedScore)*0.5+AVG(s.PerceivedScore)*0.3+AVG(m.PerceivedScore)*0.2,0) 
					 when po.PositionLevel=2 then Round(AVG(p.PerceivedScore)*0.4+AVG(s.PerceivedScore)*0.3+AVG(m.PerceivedScore)*0.3,0)
					 when po.PositionLevel=3 then Round(AVG(p.PerceivedScore)*0.4+AVG(s.PerceivedScore)*0.35+AVG(m.PerceivedScore)*0.25,0)
					 end as PerceivedMeritScore,
				case when po.PositionLevel=1 then Round(AVG(p.TemperamentScore)*0.5+AVG(s.TemperamentScore)*0.3+AVG(m.TemperamentScore)*0.2,0) 
					 when po.PositionLevel=2 then Round(AVG(p.TemperamentScore)*0.4+AVG(s.TemperamentScore)*0.3+AVG(m.TemperamentScore)*0.3,0)
					 when po.PositionLevel=3 then Round(AVG(p.TemperamentScore)*0.4+AVG(s.TemperamentScore)*0.35+AVG(m.TemperamentScore)*0.25,0)
					 end as TemperamentMeritScore
				from Users u 
				join HrPositions po on u.PositionID=po.Id
				join HrPerfectionDevelopmentTracking p on u.Id=p.UserId
				join HrMeritDevelopmentTracking m on p.UserId=m.UserId
				join HrSocialQualificationDevelopmentTracking s on m.UserId=s.UserId
				where u.Id=@UserId and p.IsLastEveluation=1 and m.IsLastEveluation=1 and s.IsLastEveluation=1
				group by u.Id,u.PositionID,u.PositionID,po.PositionLevel
				) t
			 end
		end
	 end
  end 

 if (@CategoryTagId=6)
 begin

 update HrLeadershipCriteriaDevelopmentTracking set IsLastEveluation=null where UserId=@UserId

 insert into HrLeadershipCriteriaDevelopmentTracking 
 select NEWID(),t.UserId,t.EveluationCategoryId,t.CriteriaId,t.CriteriaEveluationAvg,t.SelfEveluationAvg,
 t.PerceivedEveluationAvg,t.TemperamentScore,1,CURRENT_TIMESTAMP from VLeadershipCriteriaAvgTracking t
 where t.UserId=@UserId

 update HrLeadershipStyleDevelopmentTracking set IsLastEveluation=null where UserId=@UserId

 insert into HrLeadershipStyleDevelopmentTracking 
 select NEWID(),t.UserId,t.LeadershipTypeId,t.LeadershipScore,1,CURRENT_TIMESTAMP from HrLeadershipResults t
 where t.UserId=@UserId

 update HrLeadershipGeneralDevelopmentTracking set IsLastEveluation=null where UserId=@UserId

 insert into HrLeadershipGeneralDevelopmentTracking 
 select NEWID(),t.UserId,@CategoryId,t.LeadershipScoreAvg,t.SelfEveluationScoreAvg,
 t.PerceivedEveluationScoreAvg,t.TemperamentScoreAvg,1,CURRENT_TIMESTAMP from VLeadershipResultAvgTracking t
 where t.UserId=@UserId



 end 

 select 1 as Id;

END
GO
/****** Object:  StoredProcedure [dbo].[SpGetSubDepartments]    Script Date: 14.11.2019 09:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SpGetSubDepartments](@UserId uniqueidentifier)
AS
BEGIN
	SET NOCOUNT ON;

SELECT DISTINCT
                   d.Id
               FROM
                   (SELECT
                       d6.Id AS id5,
                       d5.Id AS id4,
                       d4.Id AS id3,
                       d3.Id AS id2,
                       d2.Id AS id1,
                       d1.Id AS id0
                   FROM
                   HrDepartments AS d1
                   LEFT JOIN HrDepartments AS d2 ON d2.ParentDepartmentId = d1.Id
                   LEFT JOIN HrDepartments AS d3 ON d3.ParentDepartmentId = d2.Id
                   LEFT JOIN HrDepartments AS d4 ON d4.ParentDepartmentId = d3.Id
                   LEFT JOIN HrDepartments AS d5 ON d5.ParentDepartmentId = d4.Id
                   LEFT JOIN HrDepartments AS d6 ON d6.ParentDepartmentId = d5.Id
                   WHERE
                       d1.Id =(select d.Id from Users u 
						join HrPositions p on u.PositionID=p.Id
						join HrDepartments d on p.DepartmentId=d.Id
						where u.Id=@UserId)) AS h
               JOIN
                   HrDepartments AS d ON d.Id IN (id0 , id1, id2, id3, id4, id5)
END
GO
/****** Object:  StoredProcedure [dbo].[SpGetSubOrganisation]    Script Date: 14.11.2019 09:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SpGetSubOrganisation](@OrgId uniqueidentifier )
AS
BEGIN

 CREATE TABLE #subOrgs          
     ( Ids uniqueidentifier) 
	  declare @returnStr varchar(max)
	  declare @parentId varchar(max)
	  declare @OrgTypeId uniqueidentifier 
	  declare @campusId uniqueidentifier  
	  declare @depID uniqueidentifier 
	  declare @classID uniqueidentifier
	  set @returnStr=''''+convert(nvarchar(50), @OrgId)+''','''

	  insert into #subOrgs
	  select @OrgId
	 
	 select @OrgTypeId=o.OrganTypeId from Organizations o 
	   where  o.Id=@OrgId
	 if @OrgTypeId='32222218-716A-47B0-BDDF-6D9AE4837C2E'   /* gelen  organizasyon en üst organizasyon*/
	 begin 
		DECLARE db_CampusCursor CURSOR FOR /* campusleri getir*/
		SELECT o.Id 
		FROM Organizations o
		where  o.ParentId=@OrgId
		
		OPEN db_CampusCursor  
		FETCH NEXT FROM db_CampusCursor INTO @campusId 
		WHILE @@FETCH_STATUS = 0  
				BEGIN  
					 insert into #subOrgs
					 select @campusId

					DECLARE db_DepCursor CURSOR FOR /* campuslere bağlı departmanları getir*/
					SELECT o.Id 
					FROM Organizations o
					where  o.ParentId=@campusId
			
					OPEN db_DepCursor  
					FETCH NEXT FROM db_DepCursor INTO @depId  
					WHILE @@FETCH_STATUS = 0  
						BEGIN  
						 insert into #subOrgs
						 select @depId

							DECLARE db_ClassCursor CURSOR FOR /* departmanlara bağlı sınıfları getir*/
							SELECT o.Id 
							FROM Organizations o
							where  o.ParentId=@depId

							OPEN db_ClassCursor  
							FETCH NEXT FROM db_ClassCursor INTO @classId  
							WHILE @@FETCH_STATUS = 0  
								BEGIN  
								
								 insert into #subOrgs
								 select @classId

								FETCH NEXT FROM db_ClassCursor INTO @classId 
								END 
								CLOSE db_ClassCursor  
								DEALLOCATE db_ClassCursor 

						FETCH NEXT FROM db_DepCursor INTO @depId 
						END 
						CLOSE db_DepCursor  
						DEALLOCATE db_DepCursor 

				FETCH NEXT FROM db_CampusCursor INTO @campusId 
				END 
				CLOSE db_CampusCursor  
				DEALLOCATE db_CampusCursor 

        end
		else if  @OrgTypeId='FAFE25E5-2E61-4502-B076-F04217ACB18B' /*Campus seviyesinde organizasyon..*/
		begin
		
				DECLARE db_DepCursor CURSOR FOR /* campuslere bağlı departmanları getir*/
				SELECT o.Id 
				FROM Organizations o
				where  o.ParentId=@OrgId
		
				OPEN db_DepCursor  
				FETCH NEXT FROM db_DepCursor INTO @depId  
				WHILE @@FETCH_STATUS = 0  
					BEGIN  
						insert into #subOrgs
						select @depId

						DECLARE db_ClassCursor CURSOR FOR /* departmanlara bağlı sınıfları getir*/
						SELECT o.Id 
						FROM Organizations o
						where  o.ParentId=@depId

						OPEN db_ClassCursor  
						FETCH NEXT FROM db_ClassCursor INTO @classId  
						WHILE @@FETCH_STATUS = 0  
							BEGIN  
							
							insert into #subOrgs
							select @classId

							FETCH NEXT FROM db_ClassCursor INTO @classId 
							END 
							CLOSE db_ClassCursor  
							DEALLOCATE db_ClassCursor 

					FETCH NEXT FROM db_DepCursor INTO @depId 
					END 
					CLOSE db_DepCursor  
					DEALLOCATE db_DepCursor 

		end 
		else if @OrgTypeId='242821D5-58AB-47C9-991E-1E96A6FC3074' /*departman seviyesinde organizasyon..*/
		begin


						DECLARE db_ClassCursor CURSOR FOR /* departmanlara bağlı sınıfları getir*/
						SELECT o.Id 
						FROM Organizations o
						where  o.ParentId=@OrgId

						OPEN db_ClassCursor  
						FETCH NEXT FROM db_ClassCursor INTO @classId  
						WHILE @@FETCH_STATUS = 0  
							BEGIN  
							
							insert into #subOrgs
							select @classId

							FETCH NEXT FROM db_ClassCursor INTO @classId 
							END 
						CLOSE db_ClassCursor  
						DEALLOCATE db_ClassCursor 


		end  

	select * from #subOrgs

	drop table #subOrgs
END
GO
/****** Object:  StoredProcedure [dbo].[SpLeadershipScoreUpdate]    Script Date: 14.11.2019 09:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Halil inci>
-- Create date: <Create Date,,>
-- DESC ription:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SpLeadershipScoreUpdate] (@RatedUserId uniqueidentifier, @EveluateUserId uniqueidentifier, @CategoryId INT,@LeadershipType INT)


AS
BEGIN
DECLARE @LowEveluationScore FLOAT=null 
DECLARE @UpEveluationScore FLOAT=null
DECLARE @HorizontalEveluationScore FLOAT=null
DECLARE @SelfEveluationScore FLOAT=null
DECLARE @TemperamentLeadershipScore FLOAT=null
DECLARE @LeadershipAvgPuan FLOAT=null
DECLARE @EveluationAvgScore FLOAT=null
DECLARE @PerceivedLeadershipScore FLOAT=null

DECLARE @EveluationFactor FLOAT=0.5
DECLARE @TemperamentFactor FLOAT= 0.5

DECLARE @NaturalLeadershipId INT=0
DECLARE @SyntheticLeadershipId1 INT=0
DECLARE @SyntheticLeadershipId2 INT=0
DECLARE @RecordCount INT=0
DECLARE @SyntheticLeadershipCount INT=0
DECLARE @LeadershipGeneralScore INT=0


DECLARE @NaturalLeadershipName NVARCHAR(100)
DECLARE @SyntheticLeadershipName1  NVARCHAR(100)
DECLARE @SyntheticLeadershipName2   NVARCHAR(100)

DECLARE @LeadershipEveluation   NVARCHAR(MAX)
DECLARE @TempText NVARCHAR(MAX)
DECLARE @LeadershipLevelText NVARCHAR(MAX)

DECLARE @SyntheticLeadershipDegree1 NVARCHAR(5)
DECLARE @SyntheticLeadershipDegree2 NVARCHAR(5)

DECLARE @LeaderTemperamentType INT =null
DECLARE @IsNaturalLeadership INT =null
DECLARE @IsThereRecord INT=null

/*Get User TemperamentTypeId*/
SELECT @LeaderTemperamentType=u.TemperamentTypeId   
FROM Users u WHERE u.Id=@EveluateUserId

/*Get Temperament-Leadership Score*/
SELECT @TemperamentLeadershipScore=lts.Score , @IsNaturalLeadership=lts.IsNatural               
FROM HrLeadershipTemperamentScores lts
WHERE lts.TemperamentId=@LeaderTemperamentType AND lts.LeadershipTypeId=@LeadershipType
/*
select @LeadershipType
select  @LeaderTemperamentType

select  @IsNaturalLeadership

select @TemperamentLeadershipScore

*/
 IF	(@CategoryId=16) 
 BEGIN

 	SELECT @SelfEveluationScore= CAST(ROUND(SUM(CASE WHEN ycp.Score IS NOT NULL THEN ycp.Score ELSE 0 END)/SUM(CASE WHEN Score IS NOT NULL THEN 1 ELSE 0 END),0) AS INT)  
	FROM HrLeadershipScores ycp
    join HrUserLastSurveyAnswers sc on ycp.RatedUserId=sc.RatedUserId 
	AND ycp.EvaluatedUserId=sc.EveluatedUserID 
	AND ycp.AnswerId=sc.AnswerId
	WHERE ycp.RatedUserId=@RatedUserId
    AND ycp.EveluationCategoryId=@CategoryId
    AND ycp.LeadershipTypeId=@LeadershipType
	AND ycp.EvaluatedUserId=@EveluateUserId

	 IF EXISTS (SELECT * FROM HrLeadershipResults lr WHERE lr.UserId=@EveluateUserId AND lr.LeadershipTypeId=@LeadershipType)
	 BEGIN
		
		 UPDATE HrLeadershipResults 
         SET SelfEveluationScore=@SelfEveluationScore,
         TemperamentScore=@TemperamentLeadershipScore,
         IsNaturalLeadership=@IsNaturalLeadership
         WHERE UserId=@EveluateUserId 
         AND LeadershipTypeId=@LeadershipType
	 END
	 ELSE
	 BEGIN
		INSERT INTO HrLeadershipResults 
		(Id,
		UserId,
        LeadershipTypeId,
        IsNaturalLeadership,
		LowLevelEveluationScore,
		UpLevelEveluationScore,
		HorizontalLevelEveluationScore,
		SelfEveluationScore,
        TemperamentScore,
        EveluationScore,
        LeadershipScore)
		VALUES (
		NEWID(),
		@EveluateUserId,
		@LeadershipType,
        @IsNaturalLeadership,
        null,
		null,
		null,
		@SelfEveluationScore,
        @TemperamentLeadershipScore,
        null,
        null)
	 END
	  

 END
 
 IF	(@CategoryId=17) 
 BEGIN

 	SELECT @LowEveluationScore= CAST(ROUND(SUM(CASE WHEN ycp.Score IS NOT NULL THEN ycp.Score ELSE 0 END)/SUM(CASE WHEN Score IS NOT NULL THEN 1 ELSE 0 END),0) AS INT)  
	FROM HrLeadershipScores ycp
    join HrUserLastSurveyAnswers sc on ycp.RatedUserId=sc.RatedUserId 
	AND ycp.EvaluatedUserId=sc.EveluatedUserID 
	AND ycp.AnswerId=sc.AnswerId
	WHERE ycp.RatedUserId=@RatedUserId
    AND ycp.EveluationCategoryId=@CategoryId
    AND ycp.LeadershipTypeId=@LeadershipType
	AND ycp.EvaluatedUserId=@EveluateUserId

	 IF EXISTS (SELECT * FROM HrLeadershipResults lr WHERE lr.UserId=@EveluateUserId AND lr.LeadershipTypeId=@LeadershipType)
	 BEGIN
		
		 UPDATE HrLeadershipResults 
         SET LowLevelEveluationScore=@LowEveluationScore,
         TemperamentScore=@TemperamentLeadershipScore,
         IsNaturalLeadership=@IsNaturalLeadership
         WHERE UserId=@EveluateUserId 
         AND LeadershipTypeId=@LeadershipType
	 END
	 ELSE
	 BEGIN
		INSERT INTO HrLeadershipResults 
		(Id,
		UserId,
        LeadershipTypeId,
        IsNaturalLeadership,
		LowLevelEveluationScore,
		UpLevelEveluationScore,
		HorizontalLevelEveluationScore,
		SelfEveluationScore,
        TemperamentScore,
        EveluationScore,
        LeadershipScore)
		VALUES (
		NEWID(),
		@EveluateUserId,
		@LeadershipType,
        @IsNaturalLeadership,
        @LowEveluationScore,
		null,
		null,
		null,
        @TemperamentLeadershipScore,
        null,
        null)
	 END
	  

 END

 IF	(@CategoryId=18) 
 BEGIN

 	SELECT @UpEveluationScore= CAST(ROUND(SUM(CASE WHEN ycp.Score IS NOT NULL THEN ycp.Score ELSE 0 END)/SUM(CASE WHEN Score IS NOT NULL THEN 1 ELSE 0 END),0) AS INT)  
	FROM HrLeadershipScores ycp
    join HrUserLastSurveyAnswers sc on ycp.RatedUserId=sc.RatedUserId 
	AND ycp.EvaluatedUserId=sc.EveluatedUserID 
	AND ycp.AnswerId=sc.AnswerId
	WHERE ycp.RatedUserId=@RatedUserId
    AND ycp.EveluationCategoryId=@CategoryId
    AND ycp.LeadershipTypeId=@LeadershipType
	AND ycp.EvaluatedUserId=@EveluateUserId

	 IF EXISTS (SELECT * FROM HrLeadershipResults lr WHERE lr.UserId=@EveluateUserId AND lr.LeadershipTypeId=@LeadershipType)
	 BEGIN
		
		 UPDATE HrLeadershipResults 
         SET UpLevelEveluationScore=@UpEveluationScore,
         TemperamentScore=@TemperamentLeadershipScore,
         IsNaturalLeadership=@IsNaturalLeadership
         WHERE UserId=@EveluateUserId 
         AND LeadershipTypeId=@LeadershipType
	 END
	 ELSE
	 BEGIN
		INSERT INTO HrLeadershipResults 
		(Id,
		UserId,
        LeadershipTypeId,
        IsNaturalLeadership,
		LowLevelEveluationScore,
		UpLevelEveluationScore,
		HorizontalLevelEveluationScore,
		SelfEveluationScore,
        TemperamentScore,
        EveluationScore,
        LeadershipScore)
		VALUES (
		NEWID(),
		@EveluateUserId,
		@LeadershipType,
        @IsNaturalLeadership,
        null,
		@UpEveluationScore,
		null,
		null,
        @TemperamentLeadershipScore,
        null,
        null)
	 END
	  

 END

 IF	(@CategoryId=19) 
 BEGIN

 	SELECT @HorizontalEveluationScore= CAST(ROUND(SUM(CASE WHEN ycp.Score IS NOT NULL THEN ycp.Score ELSE 0 END)/SUM(CASE WHEN Score IS NOT NULL THEN 1 ELSE 0 END),0) AS INT)  
	FROM HrLeadershipScores ycp
    join HrUserLastSurveyAnswers sc on ycp.RatedUserId=sc.RatedUserId 
	AND ycp.EvaluatedUserId=sc.EveluatedUserID 
	AND ycp.AnswerId=sc.AnswerId
	WHERE ycp.RatedUserId=@RatedUserId
    AND ycp.EveluationCategoryId=@CategoryId
    AND ycp.LeadershipTypeId=@LeadershipType
	AND ycp.EvaluatedUserId=@EveluateUserId

	 IF EXISTS (SELECT * FROM HrLeadershipResults lr WHERE lr.UserId=@EveluateUserId AND lr.LeadershipTypeId=@LeadershipType)
	 BEGIN
		
		 UPDATE HrLeadershipResults 
         SET HorizontalLevelEveluationScore=@HorizontalEveluationScore,
         TemperamentScore=@TemperamentLeadershipScore,
         IsNaturalLeadership=@IsNaturalLeadership
         WHERE UserId=@EveluateUserId 
         AND LeadershipTypeId=@LeadershipType
	 END
	 ELSE
	 BEGIN
		INSERT INTO HrLeadershipResults 
		(Id,
		UserId,
        LeadershipTypeId,
        IsNaturalLeadership,
		LowLevelEveluationScore,
		UpLevelEveluationScore,
		HorizontalLevelEveluationScore,
		SelfEveluationScore,
        TemperamentScore,
        EveluationScore,
        LeadershipScore)
		VALUES (
		NEWID(),
		@EveluateUserId,
		@LeadershipType,
        @IsNaturalLeadership,
        null,
		null,
		@HorizontalEveluationScore,
		null,
        @TemperamentLeadershipScore,
        null,
        null)
	 END
	  

 END


SELECT @PerceivedLeadershipScore=CAST(CASE WHEN puanSayisi !=0 THEN ROUND(TOPlamPuan/puanSayisi,0) ELSE null END AS INT) 
FROM (
SELECT 
CASE WHEN ls.LowLevelEveluationScore IS NOT NULL THEN ls.LowLevelEveluationScore ELSE 0 END+
CASE WHEN ls.UpLevelEveluationScore IS NOT NULL THEN ls.UpLevelEveluationScore ELSE 0 END+
CASE WHEN ls.HorizontalLevelEveluationScore IS NOT NULL THEN ls.HorizontalLevelEveluationScore ELSE 0 END AS TOPlamPuan,
CASE WHEN ls.LowLevelEveluationScore IS NOT NULL THEN 1 ELSE 0 END+
CASE WHEN ls.UpLevelEveluationScore IS NOT NULL THEN 1 ELSE 0 END+
CASE WHEN ls.HorizontalLevelEveluationScore IS NOT NULL THEN 1 ELSE 0 END AS puanSayisi
 FROM HrLeadershipResults ls WHERE ls.UserId=@EveluateUserId AND ls.LeadershipTypeId=@LeadershipType
 ) veri
 
UPDATE HrLeadershipResults  SET PerceivedEveluationScore=@PerceivedLeadershipScore
WHERE UserId=@EveluateUserId AND LeadershipTypeId=@LeadershipType

/*select @PerceivedLeadershipScore */


SELECT @EveluationAvgScore=lto.LeadershipEveluationAvg 
FROM VLeadershipStyleScore lto
WHERE lto.UserId=@EveluateUserId AND lto.LeadershipTypeId=@LeadershipType;

/*select @EveluationAvgScore */

UPDATE HrLeadershipResults SET EveluationScore=@EveluationAvgScore
WHERE UserId=@EveluateUserId AND LeadershipTypeId=@LeadershipType;


if @EveluationAvgScore IS NOT NULL AND @TemperamentLeadershipScore IS NOT NULL  
AND @EveluationAvgScore !=0  AND @TemperamentLeadershipScore!=0
	BEGIN
	UPDATE HrLeadershipResults  SET LeadershipScore=CAST(round(@EveluationAvgScore*@EveluationFactor+@TemperamentLeadershipScore*@TemperamentFactor,2) AS INT)
	WHERE UserId=@EveluateUserId AND LeadershipTypeId=@LeadershipType
	END

SELECT @RecordCount=count(ls.Id)
FROM HrLeadershipResults ls
WHERE ls.UserId=@EveluateUserId

/*select @RecordCount */

IF (@RecordCount=7) 
BEGIN

	DELETE FROM HrLeadershipSyntheticTypes  WHERE UserId=@EveluateUserId

	INSERT INTO HrLeadershipSyntheticTypes(Id,UserId,SyntheticTypeId,Score,ScoreLevel)
	SELECT TOP 2
	NEWID(),
	ls.UserId,
	ls.LeadershipTypeId,
	ls.LeadershipScore,
	CASE WHEN ls.LeadershipScore>=85 THEN 'A'
	WHEN ls.LeadershipScore>=70 AND ls.LeadershipScore<85 THEN 'B'
	WHEN ls.LeadershipScore>=55 AND ls.LeadershipScore<70 THEN 'C'
	WHEN ls.LeadershipScore>=40 AND ls.LeadershipScore<55 THEN 'D'
	WHEN ls.LeadershipScore<40 THEN 'E' END AS derece
	FROM HrLeadershipResults ls 
	WHERE ls.UserId=@EveluateUserId AND ls.IsNaturalLeadership=0 AND ls.LeadershipScore>=70
	ORDER BY ls.LeadershipScore 


	DELETE FROM  HrLeadershipPerceptions WHERE UserId=@EveluateUserId

	SELECT @NaturalLeadershipId=ls.LeadershipTypeId 
	FROM HrLeadershipResults ls
	WHERE ls.UserId=@EveluateUserId AND ls.IsNaturalLeadership=1;

	/*select @NaturalLeadershipId*/

	SELECT @NaturalLeadershipName=l.LeadershipName 
	FROM HrLeadershipDescriptions l 
	WHERE l.LeadershipTypeId=@NaturalLeadershipId

	SELECT @SyntheticLeadershipCount=count(ls.SyntheticTypeId)
	FROM HrLeadershipSyntheticTypes ls
	WHERE ls.UserId=@EveluateUserId

	/*select @SyntheticLeadershipCount*/

	if @SyntheticLeadershipCount=0
	BEGIN
	INSERT INTO  HrLeadershipPerceptions (Id,UserId,LeadershipTypeId,IsNaturalLeadership,LeadershipPerception)
	SELECT TOP 5
	NewID(),
	@EveluateUserId,
	@NaturalLeadershipId,
	1,
	ltt.[Text]
	FROM  HrLeadershipStyleReportTexts ltt 
	WHERE ltt.LeadershipTypeId=@NaturalLeadershipId AND ltt.CategoryId=37 AND ltt.ReportType=1 

	END

	if @SyntheticLeadershipCount=1
	BEGIN
	INSERT INTO  HrLeadershipPerceptions (Id,UserId,LeadershipTypeId,IsNaturalLeadership,LeadershipPerception)
	SELECT TOP 3
	NewID(),
	@EveluateUserId,
	@NaturalLeadershipId,
	1,
	ltt.[Text]
	FROM  HrLeadershipStyleReportTexts ltt 
	WHERE ltt.LeadershipTypeId=@NaturalLeadershipId AND ltt.CategoryId=37 AND ltt.ReportType=1 

	SELECT @SyntheticLeadershipId1=ls.SyntheticTypeId ,@SyntheticLeadershipDegree1=ls.ScoreLevel
	FROM HrLeadershipSyntheticTypes ls
	WHERE ls.UserId=@EveluateUserId
	ORDER BY ls.Score DESC 

	SELECT @SyntheticLeadershipName1=l.LeadershipName 
	FROM HrLeadershipDescriptions l 
	WHERE l.LeadershipTypeId=@SyntheticLeadershipId1;

	INSERT INTO  HrLeadershipPerceptions (Id,UserId,LeadershipTypeId,IsNaturalLeadership,LeadershipPerception)
	SELECT TOP 2
	NewID(),
	@EveluateUserId,
	@NaturalLeadershipId,
	0,
	ltt.[Text]
	FROM  HrLeadershipStyleReportTexts ltt 
	WHERE ltt.LeadershipTypeId=@SyntheticLeadershipId1 AND ltt.CategoryId=37 AND ltt.ReportType=1 AND ltt.NaturalType like CONCAT('''%',CONCAT(@NaturalLeadershipId,'%'''))


	END

	if @SyntheticLeadershipCount=2
	BEGIN
	INSERT INTO  HrLeadershipPerceptions (Id,UserId,LeadershipTypeId,IsNaturalLeadership,LeadershipPerception)
	SELECT TOP 3
	NewID(),
	@EveluateUserId,
	@NaturalLeadershipId,
	1,
	ltt.[Text]
	FROM  HrLeadershipStyleReportTexts ltt 
	WHERE ltt.LeadershipTypeId=@NaturalLeadershipId AND ltt.CategoryId=37 AND ltt.ReportType=1 

	SELECT TOP 1 @SyntheticLeadershipId1=ls.SyntheticTypeId ,@SyntheticLeadershipDegree1=ls.ScoreLevel
	FROM HrLeadershipSyntheticTypes ls
	WHERE ls.UserId=@EveluateUserId
	ORDER BY ls.Score DESC

	SELECT @SyntheticLeadershipName1=l.LeadershipName 
	FROM HrLeadershipDescriptions l 
	WHERE l.LeadershipTypeId=@SyntheticLeadershipId1

	SELECT TOP 1 @SyntheticLeadershipId2=ls.SyntheticTypeId ,@SyntheticLeadershipDegree2=ls.ScoreLevel
	FROM HrLeadershipSyntheticTypes ls
	WHERE ls.UserId=@EveluateUserId and ls.SyntheticTypeId<>@SyntheticLeadershipId1
	ORDER BY ls.Score



	SELECT @SyntheticLeadershipName2=l.LeadershipName 
	FROM HrLeadershipDescriptions l 
	WHERE l.LeadershipTypeId=@SyntheticLeadershipId2;



	INSERT INTO  HrLeadershipPerceptions (Id,UserId,LeadershipTypeId,IsNaturalLeadership,LeadershipPerception)
	SELECT TOP 1
	NewID(),
	@EveluateUserId,
	@NaturalLeadershipId,
	0,
	ltt.[Text]
	FROM  HrLeadershipStyleReportTexts ltt 
	WHERE ltt.LeadershipTypeId=@SyntheticLeadershipId1 AND ltt.CategoryId=37 AND ltt.ReportType=1 AND ltt.NaturalType like CONCAT('''%',CONCAT(@NaturalLeadershipId,'%'''))



	INSERT INTO  HrLeadershipPerceptions (Id,UserId,LeadershipTypeId,IsNaturalLeadership,LeadershipPerception)
	SELECT TOP 1
	NewID(),
	@EveluateUserId, 
	@NaturalLeadershipId,
	0,
	ltt.[Text]
	FROM  HrLeadershipStyleReportTexts ltt 
	WHERE ltt.LeadershipTypeId=@SyntheticLeadershipId2 AND ltt.CategoryId=37 AND ltt.ReportType=1 AND ltt.NaturalType like CONCAT('''%',CONCAT(@NaturalLeadershipId,'%'''))

	END
	/*Düşük yetkinlikler bulunuyor(eğitim tespiti için)*/

	DELETE FROM HrLeadershipLowCompetencies WHERE UserId=@EveluateUserId

	INSERT INTO HrLeadershipLowCompetencies(Id,UserId,CriteriaId,Score)
	SELECT TOP 5
	NEWID(),
	  @EveluateUserId,
	  lko.CriteriaId,
	  lko.CriteriaAvg 
	  FROM VLeadershipCriteriaAvg lko
	WHERE lko.UserId= @EveluateUserId  AND lko.CriteriaAvg<70
	ORDER BY lko.CriteriaAvg 

/*Guçlü ve zayıf yönleri tespit ediliyor.*/

DELETE FROM HrLeadershipStrongWeaknesses WHERE UserId=@EveluateUserId


if @SyntheticLeadershipCount=0
BEGIN
	INSERT INTO HrLeadershipStrongWeaknesses(Id,UserId,StrongWeakness,Text)
	SELECT TOP 5
	NEWID(),
	@EveluateUserId,
	1,
	ltt.Text
	FROM HrLeadershipStyleReportTexts ltt 
	WHERE ltt.LeadershipTypeId=@NaturalLeadershipId AND ltt.CategoryId=38 AND ltt.ReportType=1 

	INSERT INTO HrLeadershipStrongWeaknesses(Id,UserId,StrongWeakness,Text)
	SELECT TOP 5
	NEWID(),
	@EveluateUserId,
	0,
	ltt.Text
	FROM HrLeadershipStyleReportTexts ltt 
	WHERE ltt.LeadershipTypeId=@NaturalLeadershipId AND ltt.CategoryId=39 AND ltt.ReportType=1 
END


if @SyntheticLeadershipCount=1
BEGIN
	INSERT INTO HrLeadershipStrongWeaknesses(Id,UserId,StrongWeakness,Text)
	SELECT TOP 3
	NEWID(),
	@EveluateUserId,
	1,
	ltt.Text
	FROM HrLeadershipStyleReportTexts ltt 
	WHERE ltt.LeadershipTypeId=@NaturalLeadershipId AND ltt.CategoryId=38 AND ltt.ReportType=1 

	INSERT INTO HrLeadershipStrongWeaknesses(Id,UserId,StrongWeakness,Text)
	SELECT TOP 3
	NEWID(),
	@EveluateUserId,
	0,
	ltt.Text
	FROM HrLeadershipStyleReportTexts ltt 
	WHERE ltt.LeadershipTypeId=@NaturalLeadershipId AND ltt.CategoryId=39 AND ltt.ReportType=1 

	INSERT INTO HrLeadershipStrongWeaknesses(Id,UserId,StrongWeakness,Text)
	SELECT TOP 2
	NEWID(),
	@EveluateUserId,
	1,
	ltt.Text
	FROM HrLeadershipStyleReportTexts ltt 
	WHERE ltt.LeadershipTypeId=@SyntheticLeadershipId1 AND ltt.CategoryId=38 AND ltt.ReportType=1  AND ltt.NaturalType like CONCAT('''%',CONCAT(@NaturalLeadershipId,'%'''))

	INSERT INTO HrLeadershipStrongWeaknesses(Id,UserId,StrongWeakness,Text)
	SELECT TOP 2
	NEWID(),
	@EveluateUserId,
	0,
	ltt.Text
	FROM HrLeadershipStyleReportTexts ltt 
	WHERE ltt.LeadershipTypeId=@SyntheticLeadershipId1 AND ltt.CategoryId=39 AND ltt.ReportType=1  AND ltt.NaturalType like CONCAT('''%',CONCAT(@NaturalLeadershipId,'%'''))
END

if @SyntheticLeadershipCount=2
BEGIN
	INSERT INTO HrLeadershipStrongWeaknesses(Id,UserId,StrongWeakness,Text)
	SELECT TOP 3
	NEWID(),
	@EveluateUserId,
	1,
	ltt.Text
	FROM HrLeadershipStyleReportTexts ltt 
	WHERE ltt.LeadershipTypeId=@NaturalLeadershipId AND ltt.CategoryId=38 AND ltt.ReportType=1 

	INSERT INTO HrLeadershipStrongWeaknesses(Id,UserId,StrongWeakness,Text)
	SELECT TOP 3
	NEWID(),
	@EveluateUserId,
	0,
	ltt.Text
	FROM HrLeadershipStyleReportTexts ltt 
	WHERE ltt.LeadershipTypeId=@NaturalLeadershipId AND ltt.CategoryId=39 AND ltt.ReportType=1 

	INSERT INTO HrLeadershipStrongWeaknesses(Id,UserId,StrongWeakness,Text)
	SELECT TOP 1
	NEWID(),
	@EveluateUserId,
	1,
	ltt.Text
	FROM HrLeadershipStyleReportTexts ltt 
	WHERE ltt.LeadershipTypeId=@SyntheticLeadershipId1 AND ltt.CategoryId=38 AND ltt.ReportType=1  AND ltt.NaturalType like CONCAT('''%',CONCAT(@NaturalLeadershipId,'%'''))

	INSERT INTO HrLeadershipStrongWeaknesses(Id,UserId,StrongWeakness,Text)
	SELECT TOP 1
	NEWID(),
	@EveluateUserId,
	0,
	ltt.Text
	FROM HrLeadershipStyleReportTexts ltt 
	WHERE ltt.LeadershipTypeId=@SyntheticLeadershipId1 AND ltt.CategoryId=39 AND ltt.ReportType=1  AND ltt.NaturalType like CONCAT('''%',CONCAT(@NaturalLeadershipId,'%'''))

	INSERT INTO HrLeadershipStrongWeaknesses(Id,UserId,StrongWeakness,Text)
	SELECT TOP 1
	NEWID(),
	@EveluateUserId,
	1,
	ltt.Text
	FROM HrLeadershipStyleReportTexts ltt 
	WHERE ltt.LeadershipTypeId=@SyntheticLeadershipId2 AND ltt.CategoryId=38 AND ltt.ReportType=1  AND ltt.NaturalType like CONCAT('''%',CONCAT(@NaturalLeadershipId,'%'''))

	INSERT INTO HrLeadershipStrongWeaknesses(Id,UserId,StrongWeakness,Text)
	SELECT TOP 1
	NEWID(),
	@EveluateUserId,
	0,
	ltt.Text
	FROM HrLeadershipStyleReportTexts ltt 
	WHERE ltt.LeadershipTypeId=@SyntheticLeadershipId2 AND ltt.CategoryId=39 AND ltt.ReportType=1  AND ltt.NaturalType like CONCAT('''%',CONCAT(@NaturalLeadershipId,'%'''))
END


/*Liderlik DeğerlENDirme Metni        DogalLiderlikAdi,SentetikLiderlikAdi1,SentetikLiderlikAdi1*/



SET @LeadershipEveluation=CONCAT('Doğal Liderlik tarzı ',@NaturalLeadershipName,' dir. ')

SELECT @TempText=ltx.Text FROM 
VLeadershipNatural ln
join HrLeadershipReportTexts ltx on ln.LeadershipTypeId=ltx.CategoryId
AND [dbo].[GetScoreDegree](ln.LeadershipScore)=ltx.ScoreLevel
WHERE ln.UserId=@EveluateUserId 

SET @LeadershipEveluation=CONCAT(@LeadershipEveluation,' ',@TempText)

if @SyntheticLeadershipCount=2
BEGIN
SET @LeadershipEveluation=CONCAT(@LeadershipEveluation,' ','Bununla birlikte '
,@SyntheticLeadershipName1,' ve '
,@SyntheticLeadershipName2
,' tarzlarında da sentetik liderlik özellikleri geliştirmiştir.'); 


SELECT @TempText=ltx.Text FROM 
 HrLeadershipReportTexts  ltx
 WHERE ltx.ScoreLevel=@SyntheticLeadershipDegree1 AND ltx.CategoryId=@SyntheticLeadershipId1

SET @LeadershipEveluation=CONCAT(@LeadershipEveluation,' ',@TempText)

SELECT @TempText=ltx.Text FROM 
 HrLeadershipReportTexts  ltx
 WHERE ltx.ScoreLevel=@SyntheticLeadershipDegree2 AND ltx.CategoryId=@SyntheticLeadershipId2

SET @LeadershipEveluation=CONCAT(@LeadershipEveluation,' ',@TempText)

END

if @SyntheticLeadershipCount=1
BEGIN
SET @LeadershipEveluation=CONCAT(@LeadershipEveluation,' ','Bununla birlikte '
,@SyntheticLeadershipName1,
' tarzında sentetik liderlik özellikleri geliştirmiştir'); 


SELECT @TempText=ltx.Text FROM 
 HrLeadershipReportTexts  ltx
 WHERE ltx.ScoreLevel=@SyntheticLeadershipDegree1 AND ltx.CategoryId=@SyntheticLeadershipId1

SET @LeadershipEveluation=CONCAT(@LeadershipEveluation,' ',@TempText)

END

if (@LeadershipEveluation IS NOT NULL)
BEGIN

DELETE FROM HrLeadershipEveluationTexts WHERE UserId=@EveluateUserId;

INSERT INTO HrLeadershipEveluationTexts (Id,UserId,EveluationText)
VALUES(NEWID(),@EveluateUserId,@LeadershipEveluation)

SELECT @LeadershipGeneralScore=so.GeneralLeadershipScoreAvg  FROM VLeadershipResultAvg so WHERE so.UserId=@EveluateUserId;
SET @LeadershipLevelText=(CASE WHEN @LeadershipGeneralScore >=90 THEN
	'Üstün liderlik yetkinliklerine sahiptir. Tüm düzeylerde yöneticilik görevlerini başarı ile üstlenebileceği değerlENDirilmektedir. Bununla birlikte önerilen eğitim ve danışmanlıklar ile bu seviyeyi daha da yukarılara taşıyabilecektir. '
  WHEN @LeadershipGeneralScore >=80 THEN
	'Üst seviye liderlik yetkinliklerine sahiptir. Başlangıç ve orta  düzey yöneticilik görevlerini başarı ile üstlenebileceği, ancak üst düzey yöneticilik için yetkinliklerini geliştirmesi gerektiği değerlENDirilmektedir.' 
   WHEN @LeadershipGeneralScore >=70 THEN
	'Liderlik yetkinlikleri yeterli seviyededir. Başlangıç düzey yöneticilik görevlerini başarı ile üstlenebileceği, bununla birlikte orta ve üst düzey yöneticilik için yetkinliklerini geliştirmesi gerektiği değerlENDirilmektedir.'  
    WHEN @LeadershipGeneralScore <70 THEN
	'Liderlik yetkinliklerinin yeterli seviyede olmadığı, yöneticilik görevi verilecekse düşük olduğu tespit edilen yöneticilik yetkinliklerini geliştirmesi gerektiği değerlENDirilmektedir.'
   ELSE '' END);
   
   UPDATE HrLeadershipEveluationTexts SET LevelText=@LeadershipLevelText WHERE UserId=@EveluateUserId

END

END /*count 7*/


SELECT 1 as Result



END

GO
/****** Object:  StoredProcedure [dbo].[SpSkillScoreUpdate]    Script Date: 14.11.2019 09:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpSkillScoreUpdate] (@UserId uniqueidentifier,@AnswerId int ,@SurveyResultId int)
AS
BEGIN
select 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SpUpdateRelOrganisation]    Script Date: 14.11.2019 09:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[SpUpdateRelOrganisation]
AS
BEGIN
	  delete from RelOrganisations
	  declare @returnStr varchar(max)
	  declare @parentId varchar(max)
	  declare @OrgId uniqueidentifier 
	  declare @campusId uniqueidentifier  
	  declare @depID uniqueidentifier 
	  declare @classID uniqueidentifier
	  declare @OrgTypeId uniqueidentifier 
	  declare @campusTypeId uniqueidentifier  
	  declare @depTypeID uniqueidentifier 
	  declare @classTypeID uniqueidentifier

	 --if @OrgTypeId='32222218-716A-47B0-BDDF-6D9AE4837C2E'   /* gelen  organizasyon en üst organizasyon*/
	 --begin 
	 	DECLARE db_OrganisationCursor CURSOR FOR /*  getir*/
		SELECT o.Id,o.OrganTypeId
		FROM Organizations o
		
		
		OPEN db_OrganisationCursor  
		FETCH NEXT FROM db_OrganisationCursor INTO @OrgId,@OrgTypeId
				WHILE @@FETCH_STATUS = 0  
				BEGIN 

				DECLARE db_CampusCursor CURSOR FOR /* campusleri getir*/
				SELECT o.Id,o.OrganTypeId
				FROM Organizations o
				where  o.ParentId=@OrgId and o.ParentId<>o.Id
		
				OPEN db_CampusCursor  
				FETCH NEXT FROM db_CampusCursor INTO @campusId ,@campusTypeId
				WHILE @@FETCH_STATUS = 0  
						BEGIN  
							--if not exists (select * from RelOrganisations r where r.parentOrganisationID=@OrgId and childOrganisationID=@campusId)
							--begin
							insert into RelOrganisations
							select NEWID(),@OrgId,@campusId,@OrgTypeId,@campusTypeId
							--end

							DECLARE db_DepCursor CURSOR FOR /* campuslere bağlı departmanları getir*/
							SELECT o.Id,o.OrganTypeId
							FROM Organizations o
							where  o.ParentId=@campusId and o.ParentId<>o.Id
			
							OPEN db_DepCursor  
							FETCH NEXT FROM db_DepCursor INTO @depId ,@depTypeID
							WHILE @@FETCH_STATUS = 0  
								BEGIN  
								--if not exists (select * from RelOrganisations r where r.parentOrganisationID=@OrgId and childOrganisationID=@depId)
								--begin
								 insert into RelOrganisations
								 select NEWID(),@OrgId,@depId,@OrgTypeId,@depTypeID
							--	 end
									DECLARE db_ClassCursor CURSOR FOR /* departmanlara bağlı sınıfları getir*/
									SELECT o.Id,o.OrganTypeId
									FROM Organizations o
									where  o.ParentId=@depId and o.ParentId<>o.Id

									OPEN db_ClassCursor  
									FETCH NEXT FROM db_ClassCursor INTO @classId ,@classTypeID
									WHILE @@FETCH_STATUS = 0  
										BEGIN  
										--if not exists (select * from RelOrganisations r where r.parentOrganisationID=@OrgId and childOrganisationID=@classId)
										--begin
										insert into RelOrganisations
									    select NEWID(), @OrgId,@classId,@OrgTypeId,@classTypeID
									--	end
										FETCH NEXT FROM db_ClassCursor INTO @classId ,@classTypeID
										END 
										CLOSE db_ClassCursor  
										DEALLOCATE db_ClassCursor 

								FETCH NEXT FROM db_DepCursor INTO @depId  ,@depTypeID
								END 
								CLOSE db_DepCursor  
								DEALLOCATE db_DepCursor 

						FETCH NEXT FROM db_CampusCursor INTO @campusId ,@campusTypeId
						END 
						CLOSE db_CampusCursor  
						DEALLOCATE db_CampusCursor 
						FETCH NEXT FROM db_OrganisationCursor INTO @OrgId ,@OrgTypeId
						END 
						CLOSE db_OrganisationCursor  
						DEALLOCATE db_OrganisationCursor 

        end
		

GO
/****** Object:  StoredProcedure [dbo].[SpUserConcultancy]    Script Date: 14.11.2019 09:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

 /*
 @CategoryId : 41, olgunluk değer eğitimleri
 @CategoryId : 54, Sosyal değer eğitimleri
 @CategoryId : 80, Yetkinlik eğitimleri
 @CategoryId : 100, Genel Liyakat eğitimleri
 @CategoryId : 103, Uyum ve risk eğitimleri kategorik olarak (yönetici uyumu,kurum uyumu, risk vs.. kategorik olarak döner.),
 @CategoryId : 203, Uyum ve risk eğitimleri rapor için distinct,
 @CategoryId : 104, liderlik eğitimleri,
 @CategoryId : 116, Pozisyona dayalı eğitimler,*/
CREATE PROCEDURE [dbo].[SpUserConcultancy](@UserId uniqueidentifier,@CategoryId int) 

AS
BEGIN
DECLARE @ConsultancyName varchar(200)=''
DECLARE @ConsultancyId int=0
DECLARE @CriteriaName nvarchar(250)

 CREATE TABLE #UserConsultancy        
     (  ConsultancyName nvarchar(250),
		ConsultancyId int,
		CriteriaName  nvarchar(250)
		) 


if (@CategoryId=54  or @CategoryId=100 or  @CategoryId=116)
BEGIN
DEClARE SocialQualificationCursor CURSOR FOR 
select e.ConsultancyName,e.Id,s.CriteriaName
from VHrSocialQualificationEvaluationAvg s
join HrCriteriaConsultancies ke on s.CriteriaId=ke.CriteriaId and ke.CategoryID=54
join HrConsultancies e on ke.ConsultancyId=e.Id
where s.CriteriaScoreAvgLevel<4 and s.UserId=@UserId
order by e.ConsultancyName

OPEN SocialQualificationCursor

FETCH NEXT FROM  SocialQualificationCursor INTO @ConsultancyName,@ConsultancyId,@CriteriaName
WHILE @@FETCH_STATUS = 0  
	BEGIN  
	insert into #UserConsultancy (ConsultancyName,ConsultancyId,CriteriaName) values (@ConsultancyName,@ConsultancyId,@CriteriaName)
	FETCH NEXT FROM  SocialQualificationCursor INTO @ConsultancyName,@ConsultancyId,@CriteriaName
	END
CLOSE SocialQualificationCursor  
DEALLOCATE SocialQualificationCursor 
END

if (@CategoryId=41  or @CategoryId=100 or  @CategoryId=116)
BEGIN
DEClARE SocialQualificationCursor CURSOR FOR 
select e.ConsultancyName,e.Id,s.CriteriaName
from VHrMeritEvaluationAvg s
join HrCriteriaConsultancies ke on s.CriteriaId=ke.CriteriaId and ke.CategoryID=41
join HrConsultancies e on ke.ConsultancyId=e.Id
where s.CriteriaScoreAvgLevel<4 and s.UserId=@UserId
order by e.ConsultancyName

OPEN SocialQualificationCursor

FETCH NEXT FROM  SocialQualificationCursor INTO @ConsultancyName,@ConsultancyId,@CriteriaName
WHILE @@FETCH_STATUS = 0  
	BEGIN  
	insert into #UserConsultancy (ConsultancyName,ConsultancyId,CriteriaName) values (@ConsultancyName,@ConsultancyId,@CriteriaName)
	FETCH NEXT FROM  SocialQualificationCursor INTO @ConsultancyName,@ConsultancyId,@CriteriaName
	END
CLOSE SocialQualificationCursor  
DEALLOCATE SocialQualificationCursor 
END



if (@CategoryId=80  or @CategoryId=100 or  @CategoryId=116)
BEGIN
DEClARE PerfectionCursor CURSOR FOR 
select e.ConsultancyName,e.Id,s.CriteriaName
from VHrPerfectionEvaluationAvg s
join HrCriteriaConsultancies ke on s.CriteriaId=ke.CriteriaId and ke.CategoryID=80
join HrConsultancies e on ke.ConsultancyId=e.Id
where s.CriteriaScoreAvgLevel<4 and s.UserId=@UserId
order by e.ConsultancyName

OPEN PerfectionCursor

FETCH NEXT FROM PerfectionCursor INTO @ConsultancyName,@ConsultancyId,@CriteriaName
WHILE @@FETCH_STATUS = 0  
	BEGIN  
	insert into #UserConsultancy (ConsultancyName,ConsultancyId,CriteriaName) values (@ConsultancyName,@ConsultancyId,@CriteriaName)
	FETCH NEXT FROM PerfectionCursor INTO @ConsultancyName,@ConsultancyId,@CriteriaName
	END
CLOSE PerfectionCursor  
DEALLOCATE PerfectionCursor 
END


 select  e.ConsultancyName,e.ConsultancyId,e.CriteriaName from #UserConsultancy e order by e.ConsultancyName 

 drop table #UserConsultancy;
END
GO
/****** Object:  StoredProcedure [dbo].[SpUserSurveyCompleteProcess]    Script Date: 14.11.2019 09:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SpUserSurveyCompleteProcess]
(@RatedUserId uniqueidentifier,@EvaluatedUserId uniqueidentifier,@SurveyId int, @AnswerId int,@IsHr int)	
AS
BEGIN
declare  @CategoryId  int

if @IsHr=1
begin
SELECT @CategoryId=t.Category  FROM HrSurveys t where t.SurveyId=@SurveyId

if exists(select * from HrUserLastSurveyAnswers kst where kst.RatedUserId=@RatedUserId and kst.SurveyId=@SurveyId and kst.EveluatedUserID=@EvaluatedUserId)
	update HrUserLastSurveyAnswers  set AnswerId=@AnswerId, CreateDate=CURRENT_TIMESTAMP  where RatedUserId=@RatedUserId 
	and SurveyId=@SurveyId 
	and EveluatedUserID=@EvaluatedUserId
else
	insert into HrUserLastSurveyAnswers (RatedUserId,SurveyId,EveluatedUserID,AnswerId,CreateDate) values (@RatedUserId,@SurveyId,@EvaluatedUserId,@AnswerId,CURRENT_TIMESTAMP)

insert into [HrUserSurveyAnswers] (RatedUserId,SurveyId,EveluatedUserID,AnswerId,CreateDate) values (@RatedUserId,@SurveyId,@EvaluatedUserId,@AnswerId,CURRENT_TIMESTAMP)

update HrUserSurveys  set SurveyState = 3,AnswerId=@AnswerId  where RatedUserId=@RatedUserId and EvaluatedUserId=@EvaluatedUserId and SurveyId=@SurveyId and SurveyState in (2)
end
else
begin

if exists(select * from GuidanceUserLastSurveyAnswers kst where kst.RatedUserId=@RatedUserId and kst.SurveyId=@SurveyId and kst.EveluatedUserID=@EvaluatedUserId)
	update GuidanceUserLastSurveyAnswers  set AnswerId=@AnswerId, CreateDate=CURRENT_TIMESTAMP  where RatedUserId=@RatedUserId 
	and SurveyId=@SurveyId 
	and EveluatedUserID=@EvaluatedUserId
else
	insert into GuidanceUserLastSurveyAnswers (RatedUserId,SurveyId,EveluatedUserID,AnswerId,CreateDate) values (@RatedUserId,@SurveyId,@EvaluatedUserId,@AnswerId,CURRENT_TIMESTAMP)

insert into GuidanceUserSurveyAnswers (RatedUserId,SurveyId,EveluatedUserID,AnswerId,CreateDate) values (@RatedUserId,@SurveyId,@EvaluatedUserId,@AnswerId,CURRENT_TIMESTAMP)

update GuidanceUserSurveys  set SurveyState = 3,AnswerId=@AnswerId  where [StudentUserId]=@EvaluatedUserId and EvaluatedUserId=@RatedUserId and [DfnGuidanceSurveyId]=@SurveyId and SurveyState in (2)

INSERT INTO [dbo].[GuidanceSurveyResults]
           ([DateCreated]
           ,[UserCreated]
           ,[DateModified]
           ,[UserModified]
           ,[IsActive]
           ,[IsDeleted]
           ,[SolverUserId]
           ,[SolvedUserId]
           ,[DfnGuidanceSurveyId]
           ,[TermId]
           ,[SchoolLevel]
           ,[SolvedUserTemperamentId]
           ,[State])
     VALUES
           (CURRENT_TIMESTAMP,
           @RatedUserId,
           CURRENT_TIMESTAMP,
            @RatedUserId
           ,1
           ,0
           , @RatedUserId
           , @EvaluatedUserId
           ,@SurveyId
           ,null
           ,(select 
			 case when o.Level <0 then 1 
			 when o.Level between 1 and 4 then 2 
			 when o.Level between 5 and 8 then 3 
			 when o.Level between 1 and 4 then 4 else 0 end
			 from UserOrganizationRoles uor 
				join Organizations o on uor.OrganizationId=o.Id where uor.UserId=@EvaluatedUserId and uor.TermId=(Select Id from Terms where IsActive=1))
           ,(select TemperamentTypeId from Users where Id=@EvaluatedUserId)
           ,3)

end

select 1 as Id;
END



SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[SpUserTraining]    Script Date: 14.11.2019 09:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

 /*
 @CategoryId : 41, olgunluk değer eğitimleri
 @CategoryId : 54, Sosyal değer eğitimleri
 @CategoryId : 80, Yetkinlik eğitimleri
 @CategoryId : 100, Genel Liyakat eğitimleri
 @CategoryId : 103, Uyum ve risk eğitimleri kategorik olarak (yönetici uyumu,kurum uyumu, risk vs.. kategorik olarak döner.),
 @CategoryId : 203, Uyum ve risk eğitimleri rapor için distinct,
 @CategoryId : 104, liderlik eğitimleri,
 @CategoryId : 116, Pozisyona dayalı eğitimler,*/
CREATE PROCEDURE [dbo].[SpUserTraining](@UserId uniqueidentifier,@CategoryId int) 

AS
BEGIN
DECLARE @TrainingName varchar(200)=''
DECLARE @TrainingId int=0
DECLARE @ScoreAvg int=0
DECLARE @CriteriaScore int=0
DECLARE @PositionCriteriaId int=0;

 CREATE TABLE #UserTraining        
     ( TrainingName nvarchar(250),
		TrainingId int,
		ScoreAvg  int,
		PositionCriteriaId int) 


if (@CategoryId=54  or @CategoryId=100 or @CategoryId=116)
BEGIN
DEClARE SocialQualificationCursor CURSOR FOR 
select e.TrainingName,e.Id,s.CriteriaScoreAvg as ScoreAvg,pd.CriteriaId
from VHrSocialQualificationEvaluationAvg s
join HrCriteriaTrainings ke on s.CriteriaId=ke.CriteriaId and ke.CategoryID=54
join HrTrainings e on ke.TrainigId=e.Id
left join HrPositionCriterias pd on s.PositionId=pd.PositionId and pd.CategoryID=54 and s.CriteriaId=pd.CriteriaId
where s.CriteriaScoreAvgLevel<5 and s.UserId=@UserId
order by s.CriteriaScoreAvg,e.TrainingName

OPEN SocialQualificationCursor

FETCH NEXT FROM  SocialQualificationCursor INTO @TrainingName,@TrainingId,@ScoreAvg,@PositionCriteriaId
WHILE @@FETCH_STATUS = 0  
	BEGIN  
		if not exists (select * from #UserTraining e where e.TrainingId=@TrainingId)
			insert into #UserTraining (TrainingName,TrainingId,ScoreAvg,PositionCriteriaId) values (@TrainingName,@TrainingId,@ScoreAvg,@PositionCriteriaId)
		ELSE
			BEGIN 
			select @CriteriaScore= e.ScoreAvg 
					from #UserTraining e where e.TrainingId=@TrainingId
					if (@ScoreAvg<@CriteriaScore)
						update #UserTraining  set ScoreAvg=@ScoreAvg where TrainingId=@TrainingId

			END
	FETCH NEXT FROM  SocialQualificationCursor INTO @TrainingName,@TrainingId,@ScoreAvg,@PositionCriteriaId
	END
CLOSE SocialQualificationCursor  
DEALLOCATE SocialQualificationCursor 
END

if (@CategoryId=41  or @CategoryId=100 or @CategoryId=116)
BEGIN
DEClARE MeritCursor CURSOR FOR 
select e.TrainingName,e.Id,s.CriteriaScoreAvg as ScoreAvg,pd.CriteriaId
from VHrMeritEvaluationAvg s
join HrCriteriaTrainings ke on s.CriteriaId=ke.CriteriaId and ke.CategoryID=41
join HrTrainings e on ke.TrainigId=e.Id
left join HrPositionCriterias pd on s.PositionId=pd.PositionId and pd.CategoryID=41 and s.CriteriaId=pd.CriteriaId
where s.CriteriaScoreAvgLevel<5 and s.UserId=@UserId
order by s.CriteriaScoreAvg,e.TrainingName

OPEN MeritCursor

FETCH NEXT FROM  MeritCursor INTO @TrainingName,@TrainingId,@ScoreAvg,@PositionCriteriaId
WHILE @@FETCH_STATUS = 0  
	BEGIN  
		if not exists (select * from #UserTraining e where e.TrainingId=@TrainingId)
			insert into #UserTraining (TrainingName,TrainingId,ScoreAvg,PositionCriteriaId) values (@TrainingName,@TrainingId,@ScoreAvg,@PositionCriteriaId)
		ELSE
			BEGIN 
			select @CriteriaScore= e.ScoreAvg 
					from #UserTraining e where e.TrainingId=@TrainingId
					if (@ScoreAvg<@CriteriaScore)
						update #UserTraining  set ScoreAvg=@ScoreAvg where TrainingId=@TrainingId

			END
	FETCH NEXT FROM  MeritCursor INTO @TrainingName,@TrainingId,@ScoreAvg,@PositionCriteriaId
	END
CLOSE MeritCursor  
DEALLOCATE MeritCursor 
END

if (@CategoryId=80  or @CategoryId=100 or @CategoryId=116)
BEGIN 

DEClARE SocialQualificationCursor CURSOR FOR 
select e.TrainingName,e.Id,s.CriteriaScoreAvg as ScoreAvg,pd.CriteriaId
from VHrPerfectionEvaluationAvg s
join HrCriteriaTrainings ke on s.CriteriaId=ke.CriteriaId and ke.CategoryID=80
join HrTrainings e on ke.TrainigId=e.Id
left join HrPositionCriterias pd on s.PositionId=pd.PositionId and pd.CategoryID=80 and s.CriteriaId=pd.CriteriaId
where s.CriteriaScoreAvgLevel<5 and s.UserId=@UserId
order by s.CriteriaScoreAvg,e.TrainingName

OPEN PerfectionCursor

FETCH NEXT FROM  PerfectionCursor INTO @TrainingName,@TrainingId,@ScoreAvg,@PositionCriteriaId
WHILE @@FETCH_STATUS = 0  
	BEGIN  
		if not exists (select * from #UserTraining e where e.TrainingId=@TrainingId)
			insert into #UserTraining (TrainingName,TrainingId,ScoreAvg,PositionCriteriaId) values (@TrainingName,@TrainingId,@ScoreAvg,@PositionCriteriaId)
		ELSE
			BEGIN 
			select @CriteriaScore= e.ScoreAvg 
					from #UserTraining e where e.TrainingId=@TrainingId
					if (@ScoreAvg<@CriteriaScore)
						update #UserTraining  set ScoreAvg=@ScoreAvg where TrainingId=@TrainingId

			END
	FETCH NEXT FROM  PerfectionCursor INTO @TrainingName,@TrainingId,@ScoreAvg,@PositionCriteriaId
	END
CLOSE PerfectionCursor  
DEALLOCATE PerfectionCursor 

END


 select top 5 e.TrainingName,e.TrainingId,e.ScoreAvg from #UserTraining e order by e.ScoreAvg 

 drop table #UserTraining

END
GO
USE [master]
GO
ALTER DATABASE [MiteryaScriptTestDb] SET  READ_WRITE 
GO
