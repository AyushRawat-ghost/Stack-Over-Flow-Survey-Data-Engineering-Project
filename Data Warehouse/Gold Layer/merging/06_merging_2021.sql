DELETE FROM Gold.Fact_Survey WHERE SurveyYear = CAST('2021-01-01' AS DATETIME);
GO

INSERT INTO Gold.Fact_Survey (SurveyYear, ResponseId, [Accessibility_Status], [AgeCode], [CompTotal], [Compensation_Frequency], [ConvertedCompYearly], [Country], [Currency_Code], [Current_Profession], [Education_Level], [Ethnicity_Clean], [Gender_Clean], [Know_Other_Community], [MainBranch], [Mental_Health_Status], [NewStackOverflow_Sites], [OperatingSystem], [Organization_Size], [Sexuality_Clean], [StackOverflow_Account_exists], [StackOverflow_Community_Experience], [StackOverflow_Participation_Frequency], [StackOverflow_Visit_Frequency], [Survey_Ease], [Survey_Length], [TransGender], [USA_State], [YearsCode], [YearsCodePro])
SELECT CAST('2021-01-01' AS DATETIME) AS SurveyYear, ResponseId, [Accessibility_Status], [AgeCode], [CompTotal], [Compensation_Frequency], [ConvertedCompYearly], [Country], [Currency_Code], [Current_Profession], [Education_Level], [Ethnicity_Clean], [Gender_Clean], [Know_Other_Community], [MainBranch], [Mental_Health_Status], [NewStackOverflow_Sites], [OperatingSystem], [Organization_Size], [Sexuality_Clean], [StackOverflow_Account_exists], [StackOverflow_Community_Experience], [StackOverflow_Participation_Frequency], [StackOverflow_Visit_Frequency], [Survey_Ease], [Survey_Length], [TransGender], [USA_State], [YearsCode], [YearsCodePro]
FROM Silver.Survey_2021;
GO

DELETE FROM Gold.Bridge_DatabaseHaveWorkedWith_Clean WHERE SurveyYear = CAST('2021-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_DatabaseHaveWorkedWith_Clean (SurveyYear, ResponseId, [DatabaseHaveWorkedWith_Clean])
SELECT CAST('2021-01-01' AS DATETIME) AS SurveyYear, ResponseId, [DatabaseHaveWorkedWith]
FROM Silver.Bridge_DatabaseHaveWorkedWith_Clean_2021
WHERE [DatabaseHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_DatabaseWantToWorkWith_Clean WHERE SurveyYear = CAST('2021-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_DatabaseWantToWorkWith_Clean (SurveyYear, ResponseId, [DatabaseWantToWorkWith_Clean])
SELECT CAST('2021-01-01' AS DATETIME) AS SurveyYear, ResponseId, [DatabaseWantToWorkWith]
FROM Silver.Bridge_DatabaseWantToWorkWith_Clean_2021
WHERE [DatabaseWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_DevType_Clean WHERE SurveyYear = CAST('2021-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_DevType_Clean (SurveyYear, ResponseId, [DevType_Clean])
SELECT CAST('2021-01-01' AS DATETIME) AS SurveyYear, ResponseId, [DevType]
FROM Silver.Bridge_DevType_Clean_2021
WHERE [DevType] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_LanguageHaveWorkedWith_Clean WHERE SurveyYear = CAST('2021-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_LanguageHaveWorkedWith_Clean (SurveyYear, ResponseId, [LanguageHaveWorkedWith_Clean])
SELECT CAST('2021-01-01' AS DATETIME) AS SurveyYear, ResponseId, [LanguageHaveWorkedWith]
FROM Silver.Bridge_LanguageHaveWorkedWith_Clean_2021
WHERE [LanguageHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_LanguageWantToWorkWith_Clean WHERE SurveyYear = CAST('2021-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_LanguageWantToWorkWith_Clean (SurveyYear, ResponseId, [LanguageWantToWorkWith_Clean])
SELECT CAST('2021-01-01' AS DATETIME) AS SurveyYear, ResponseId, [LanguageWantToWorkWith]
FROM Silver.Bridge_LanguageWantToWorkWith_Clean_2021
WHERE [LanguageWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_MiscTechHaveWorkedWith_Clean WHERE SurveyYear = CAST('2021-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_MiscTechHaveWorkedWith_Clean (SurveyYear, ResponseId, [MiscTechHaveWorkedWith_Clean])
SELECT CAST('2021-01-01' AS DATETIME) AS SurveyYear, ResponseId, [MiscTechHaveWorkedWith]
FROM Silver.Bridge_MiscTechHaveWorkedWith_Clean_2021
WHERE [MiscTechHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_MiscTechWantToWorkWith_Clean WHERE SurveyYear = CAST('2021-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_MiscTechWantToWorkWith_Clean (SurveyYear, ResponseId, [MiscTechWantToWorkWith_Clean])
SELECT CAST('2021-01-01' AS DATETIME) AS SurveyYear, ResponseId, [MiscTechWantToWorkWith]
FROM Silver.Bridge_MiscTechWantToWorkWith_Clean_2021
WHERE [MiscTechWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_NEWCollabToolsHaveWorkedWith_Clean WHERE SurveyYear = CAST('2021-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_NEWCollabToolsHaveWorkedWith_Clean (SurveyYear, ResponseId, [NEWCollabToolsHaveWorkedWith_Clean])
SELECT CAST('2021-01-01' AS DATETIME) AS SurveyYear, ResponseId, [NEWCollabToolsHaveWorkedWith]
FROM Silver.Bridge_NEWCollabToolsHaveWorkedWith_Clean_2021
WHERE [NEWCollabToolsHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_NEWCollabToolsWantToWorkWith_Clean WHERE SurveyYear = CAST('2021-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_NEWCollabToolsWantToWorkWith_Clean (SurveyYear, ResponseId, [NEWCollabToolsWantToWorkWith_Clean])
SELECT CAST('2021-01-01' AS DATETIME) AS SurveyYear, ResponseId, [NEWCollabToolsWantToWorkWith]
FROM Silver.Bridge_NEWCollabToolsWantToWorkWith_Clean_2021
WHERE [NEWCollabToolsWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_NEWStuck_Clean WHERE SurveyYear = CAST('2021-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_NEWStuck_Clean (SurveyYear, ResponseId, [NEWStuck_Clean])
SELECT CAST('2021-01-01' AS DATETIME) AS SurveyYear, ResponseId, [NEWStuck]
FROM Silver.Bridge_NEWStuck_Clean_2021
WHERE [NEWStuck] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_PlatformHaveWorkedWith_Clean WHERE SurveyYear = CAST('2021-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_PlatformHaveWorkedWith_Clean (SurveyYear, ResponseId, [PlatformHaveWorkedWith_Clean])
SELECT CAST('2021-01-01' AS DATETIME) AS SurveyYear, ResponseId, [PlatformHaveWorkedWith]
FROM Silver.Bridge_PlatformHaveWorkedWith_Clean_2021
WHERE [PlatformHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_PlatformWantToWorkWith_Clean WHERE SurveyYear = CAST('2021-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_PlatformWantToWorkWith_Clean (SurveyYear, ResponseId, [PlatformWantToWorkWith_Clean])
SELECT CAST('2021-01-01' AS DATETIME) AS SurveyYear, ResponseId, [PlatformWantToWorkWith]
FROM Silver.Bridge_PlatformWantToWorkWith_Clean_2021
WHERE [PlatformWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_ToolsTechHaveWorkedWith_Clean WHERE SurveyYear = CAST('2021-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_ToolsTechHaveWorkedWith_Clean (SurveyYear, ResponseId, [ToolsTechHaveWorkedWith_Clean])
SELECT CAST('2021-01-01' AS DATETIME) AS SurveyYear, ResponseId, [ToolsTechHaveWorkedWith]
FROM Silver.Bridge_ToolsTechHaveWorkedWith_Clean_2021
WHERE [ToolsTechHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_ToolsTechWantToWorkWith_Clean WHERE SurveyYear = CAST('2021-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_ToolsTechWantToWorkWith_Clean (SurveyYear, ResponseId, [ToolsTechWantToWorkWith_Clean])
SELECT CAST('2021-01-01' AS DATETIME) AS SurveyYear, ResponseId, [ToolsTechWantToWorkWith]
FROM Silver.Bridge_ToolsTechWantToWorkWith_Clean_2021
WHERE [ToolsTechWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_WebframeHaveWorkedWith_Clean WHERE SurveyYear = CAST('2021-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_WebframeHaveWorkedWith_Clean (SurveyYear, ResponseId, [WebframeHaveWorkedWith_Clean])
SELECT CAST('2021-01-01' AS DATETIME) AS SurveyYear, ResponseId, [WebframeHaveWorkedWith]
FROM Silver.Bridge_WebframeHaveWorkedWith_Clean_2021
WHERE [WebframeHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_WebframeWantToWorkWith_Clean WHERE SurveyYear = CAST('2021-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_WebframeWantToWorkWith_Clean (SurveyYear, ResponseId, [WebframeWantToWorkWith_Clean])
SELECT CAST('2021-01-01' AS DATETIME) AS SurveyYear, ResponseId, [WebframeWantToWorkWith]
FROM Silver.Bridge_WebframeWantToWorkWith_Clean_2021
WHERE [WebframeWantToWorkWith] IS NOT NULL;
GO
