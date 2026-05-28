DELETE FROM Gold.Fact_Survey WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Fact_Survey (SurveyYear, ResponseId, [Accessibility_Status], [Blockchain], [BuyNewTool], [CodingActivities], [CompTotal], [Compensation_Frequency], [ConvertedCompYearly], [Country], [Currency_Code], [Current_Profession], [Education_Level], [Ethnicity_Clean], [Frequency_1], [Frequency_2], [Frequency_3], [Gender_Clean], [ICorPM], [Knowledge_1], [Knowledge_2], [Knowledge_3], [Knowledge_4], [Knowledge_5], [Knowledge_6], [Knowledge_7], [LearnCodeCoursesCert], [LearnCodeOnline], [MainBranch], [Mental_Health_Status], [NewStackOverflow_Sites], [Onboarding], [OperatingSystem_Personal], [OperatingSystem_Professional], [Organization_Size], [ProfessionalTech], [PurchaseInfluence], [RemoteWork], [Sexuality_Clean], [StackOverflow_Account_exists], [StackOverflow_Community_Experience], [StackOverflow_Participation_Frequency], [StackOverflow_Visit_Frequency], [Survey_Ease], [Survey_Length], [TBranch], [TimeAnswering], [TimeSearching], [TransGender], [TrueFalse_1], [TrueFalse_2], [TrueFalse_3], [VCHostingPersonal use], [VCHostingProfessional use], [VCInteraction], [VersionControlSystem], [WorkExp], [YearsCode], [YearsCodePro])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [Accessibility_Status], [Blockchain], [BuyNewTool], [CodingActivities], [CompTotal], [Compensation_Frequency], [ConvertedCompYearly], [Country], [Currency_Code], [Current_Profession], [Education_Level], [Ethnicity_Clean], [Frequency_1], [Frequency_2], [Frequency_3], [Gender_Clean], [ICorPM], [Knowledge_1], [Knowledge_2], [Knowledge_3], [Knowledge_4], [Knowledge_5], [Knowledge_6], [Knowledge_7], [LearnCodeCoursesCert], [LearnCodeOnline], [MainBranch], [Mental_Health_Status], [NewStackOverflow_Sites], [Onboarding], [OperatingSystem_Personal], [OperatingSystem_Professional], [Organization_Size], [ProfessionalTech], [PurchaseInfluence], [RemoteWork], [Sexuality_Clean], [StackOverflow_Account_exists], [StackOverflow_Community_Experience], [StackOverflow_Participation_Frequency], [StackOverflow_Visit_Frequency], [Survey_Ease], [Survey_Length], [TBranch], [TimeAnswering], [TimeSearching], [TransGender], [TrueFalse_1], [TrueFalse_2], [TrueFalse_3], [VCHostingPersonal use], [VCHostingProfessional use], [VCInteraction], [VersionControlSystem], [WorkExp], [YearsCode], [YearsCodePro]
FROM Silver.Survey_2022;
GO

DELETE FROM Gold.Bridge_DatabaseHaveWorkedWith_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_DatabaseHaveWorkedWith_Clean (SurveyYear, ResponseId, [DatabaseHaveWorkedWith_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [DatabaseHaveWorkedWith]
FROM Silver.Bridge_DatabaseHaveWorkedWith_Clean_2022
WHERE [DatabaseHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_DatabaseWantToWorkWith_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_DatabaseWantToWorkWith_Clean (SurveyYear, ResponseId, [DatabaseWantToWorkWith_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [DatabaseWantToWorkWith]
FROM Silver.Bridge_DatabaseWantToWorkWith_Clean_2022
WHERE [DatabaseWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_DevType_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_DevType_Clean (SurveyYear, ResponseId, [DevType_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [DevType]
FROM Silver.Bridge_DevType_Clean_2022
WHERE [DevType] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_LanguageHaveWorkedWith_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_LanguageHaveWorkedWith_Clean (SurveyYear, ResponseId, [LanguageHaveWorkedWith_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [LanguageHaveWorkedWith]
FROM Silver.Bridge_LanguageHaveWorkedWith_Clean_2022
WHERE [LanguageHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_LanguageWantToWorkWith_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_LanguageWantToWorkWith_Clean (SurveyYear, ResponseId, [LanguageWantToWorkWith_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [LanguageWantToWorkWith]
FROM Silver.Bridge_LanguageWantToWorkWith_Clean_2022
WHERE [LanguageWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_LearnCode_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_LearnCode_Clean (SurveyYear, ResponseId, [LearnCode_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [LearnCode]
FROM Silver.Bridge_LearnCode_Clean_2022
WHERE [LearnCode] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_MiscTechHaveWorkedWith_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_MiscTechHaveWorkedWith_Clean (SurveyYear, ResponseId, [MiscTechHaveWorkedWith_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [MiscTechHaveWorkedWith]
FROM Silver.Bridge_MiscTechHaveWorkedWith_Clean_2022
WHERE [MiscTechHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_MiscTechWantToWorkWith_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_MiscTechWantToWorkWith_Clean (SurveyYear, ResponseId, [MiscTechWantToWorkWith_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [MiscTechWantToWorkWith]
FROM Silver.Bridge_MiscTechWantToWorkWith_Clean_2022
WHERE [MiscTechWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_NEWCollabToolsHaveWorkedWith_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_NEWCollabToolsHaveWorkedWith_Clean (SurveyYear, ResponseId, [NEWCollabToolsHaveWorkedWith_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [NEWCollabToolsHaveWorkedWith]
FROM Silver.Bridge_NEWCollabToolsHaveWorkedWith_Clean_2022
WHERE [NEWCollabToolsHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_NEWCollabToolsWantToWorkWith_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_NEWCollabToolsWantToWorkWith_Clean (SurveyYear, ResponseId, [NEWCollabToolsWantToWorkWith_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [NEWCollabToolsWantToWorkWith]
FROM Silver.Bridge_NEWCollabToolsWantToWorkWith_Clean_2022
WHERE [NEWCollabToolsWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_OfficeStackAsyncHaveWorkedWith_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_OfficeStackAsyncHaveWorkedWith_Clean (SurveyYear, ResponseId, [OfficeStackAsyncHaveWorkedWith_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [OfficeStackAsyncHaveWorkedWith]
FROM Silver.Bridge_OfficeStackAsyncHaveWorkedWith_Clean_2022
WHERE [OfficeStackAsyncHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_OfficeStackAsyncWantToWorkWith_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_OfficeStackAsyncWantToWorkWith_Clean (SurveyYear, ResponseId, [OfficeStackAsyncWantToWorkWith_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [OfficeStackAsyncWantToWorkWith]
FROM Silver.Bridge_OfficeStackAsyncWantToWorkWith_Clean_2022
WHERE [OfficeStackAsyncWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_OfficeStackSyncHaveWorkedWith_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_OfficeStackSyncHaveWorkedWith_Clean (SurveyYear, ResponseId, [OfficeStackSyncHaveWorkedWith_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [OfficeStackSyncHaveWorkedWith]
FROM Silver.Bridge_OfficeStackSyncHaveWorkedWith_Clean_2022
WHERE [OfficeStackSyncHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_OfficeStackSyncWantToWorkWith_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_OfficeStackSyncWantToWorkWith_Clean (SurveyYear, ResponseId, [OfficeStackSyncWantToWorkWith_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [OfficeStackSyncWantToWorkWith]
FROM Silver.Bridge_OfficeStackSyncWantToWorkWith_Clean_2022
WHERE [OfficeStackSyncWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_PlatformHaveWorkedWith_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_PlatformHaveWorkedWith_Clean (SurveyYear, ResponseId, [PlatformHaveWorkedWith_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [PlatformHaveWorkedWith]
FROM Silver.Bridge_PlatformHaveWorkedWith_Clean_2022
WHERE [PlatformHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_PlatformWantToWorkWith_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_PlatformWantToWorkWith_Clean (SurveyYear, ResponseId, [PlatformWantToWorkWith_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [PlatformWantToWorkWith]
FROM Silver.Bridge_PlatformWantToWorkWith_Clean_2022
WHERE [PlatformWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_ToolsTechHaveWorkedWith_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_ToolsTechHaveWorkedWith_Clean (SurveyYear, ResponseId, [ToolsTechHaveWorkedWith_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [ToolsTechHaveWorkedWith]
FROM Silver.Bridge_ToolsTechHaveWorkedWith_Clean_2022
WHERE [ToolsTechHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_ToolsTechWantToWorkWith_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_ToolsTechWantToWorkWith_Clean (SurveyYear, ResponseId, [ToolsTechWantToWorkWith_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [ToolsTechWantToWorkWith]
FROM Silver.Bridge_ToolsTechWantToWorkWith_Clean_2022
WHERE [ToolsTechWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_WebframeHaveWorkedWith_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_WebframeHaveWorkedWith_Clean (SurveyYear, ResponseId, [WebframeHaveWorkedWith_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [WebframeHaveWorkedWith]
FROM Silver.Bridge_WebframeHaveWorkedWith_Clean_2022
WHERE [WebframeHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_WebframeWantToWorkWith_Clean WHERE SurveyYear = CAST('2022-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_WebframeWantToWorkWith_Clean (SurveyYear, ResponseId, [WebframeWantToWorkWith_Clean])
SELECT CAST('2022-01-01' AS DATETIME) AS SurveyYear, ResponseId, [WebframeWantToWorkWith]
FROM Silver.Bridge_WebframeWantToWorkWith_Clean_2022
WHERE [WebframeWantToWorkWith] IS NOT NULL;
GO
