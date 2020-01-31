USE MiteryaTestDB
ALTER TABLE SurveyResults
ADD ShowReport BIT NOT NULL
GO
UPDATE SurveyResults
SET ShowReport = '0'
GO