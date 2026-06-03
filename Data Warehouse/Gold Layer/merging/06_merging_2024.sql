DELETE FROM Gold.Fact_Survey WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Fact_Survey (SurveyYear, ResponseId, [AIAcc], [AIBen], [AIChallenges], [AIComplex], [AIEthics], [AINextLess integrated], [AINextMore integrated], [AINextMuch less integrated], [AINextMuch more integrated], [AINextNo change], [AISearchDevAdmired], [AISearchDevHaveWorkedWith], [AISearchDevWantToWorkWith], [AISelect], [AISent], [AIThreat], [AIToolCurrently Using], [AIToolInterested in Using], [AIToolNot interested in Using], [BuildvsBuy], [BuyNewTool], [Check], [CodingActivities], [CompTotal], [ConvertedCompYearly], [Country], [Currency_Code], [Current_Profession], [DatabaseAdmired], [Education_Level], [EmbeddedAdmired], [Frequency_1], [Frequency_2], [Frequency_3], [Frustration], [ICorPM], [Industry], [JobSat], [JobSatPoints_1], [JobSatPoints_10], [JobSatPoints_11], [JobSatPoints_4], [JobSatPoints_5], [JobSatPoints_6], [JobSatPoints_7], [JobSatPoints_8], [JobSatPoints_9], [Knowledge_1], [Knowledge_2], [Knowledge_3], [Knowledge_4], [Knowledge_5], [Knowledge_6], [Knowledge_7], [Knowledge_8], [Knowledge_9], [LanguageAdmired], [LearnCodeOnline], [MainBranch], [MiscTechAdmired], [NEWCollabToolsAdmired], [NewStackOverflow_Sites], [OfficeStackAsyncAdmired], [OfficeStackSyncAdmired], [OperatingSystem_Personal], [OperatingSystem_Professional], [Organization_Size], [PlatformAdmired], [ProfessionalCloud], [ProfessionalQuestion], [ProfessionalTech], [PurchaseInfluence], [RemoteWork], [SOHow], [StackOverflow_Account_exists], [StackOverflow_Community_Experience], [StackOverflow_Participation_Frequency], [StackOverflow_Visit_Frequency], [Survey_Ease], [Survey_Length], [TBranch], [TechDoc], [TechEndorse], [TimeAnswering], [TimeSearching], [ToolsTechAdmired], [WebframeAdmired], [WorkExp], [YearsCode], [YearsCodePro])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [AIAcc], [AIBen], [AIChallenges], [AIComplex], [AIEthics], [AINextLess integrated], [AINextMore integrated], [AINextMuch less integrated], [AINextMuch more integrated], [AINextNo change], [AISearchDevAdmired], [AISearchDevHaveWorkedWith], [AISearchDevWantToWorkWith], [AISelect], [AISent], [AIThreat], [AIToolCurrently Using], [AIToolInterested in Using], [AIToolNot interested in Using], [BuildvsBuy], [BuyNewTool], [Check], [CodingActivities], [CompTotal], [ConvertedCompYearly], [Country], [Currency_Code], [Current_Profession], [DatabaseAdmired], [Education_Level], [EmbeddedAdmired], [Frequency_1], [Frequency_2], [Frequency_3], [Frustration], [ICorPM], [Industry], [JobSat], [JobSatPoints_1], [JobSatPoints_10], [JobSatPoints_11], [JobSatPoints_4], [JobSatPoints_5], [JobSatPoints_6], [JobSatPoints_7], [JobSatPoints_8], [JobSatPoints_9], [Knowledge_1], [Knowledge_2], [Knowledge_3], [Knowledge_4], [Knowledge_5], [Knowledge_6], [Knowledge_7], [Knowledge_8], [Knowledge_9], [LanguageAdmired], [LearnCodeOnline], [MainBranch], [MiscTechAdmired], [NEWCollabToolsAdmired], [NewStackOverflow_Sites], [OfficeStackAsyncAdmired], [OfficeStackSyncAdmired], [OperatingSystem_Personal], [OperatingSystem_Professional], [Organization_Size], [PlatformAdmired], [ProfessionalCloud], [ProfessionalQuestion], [ProfessionalTech], [PurchaseInfluence], [RemoteWork], [SOHow], [StackOverflow_Account_exists], [StackOverflow_Community_Experience], [StackOverflow_Participation_Frequency], [StackOverflow_Visit_Frequency], [Survey_Ease], [Survey_Length], [TBranch], [TechDoc], [TechEndorse], [TimeAnswering], [TimeSearching], [ToolsTechAdmired], [WebframeAdmired], [WorkExp], [YearsCode], [YearsCodePro]
FROM Silver.Survey_2024;
GO

DELETE FROM Gold.Bridge_DatabaseHaveWorkedWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_DatabaseHaveWorkedWith_Clean (SurveyYear, ResponseId, [DatabaseHaveWorkedWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [DatabaseHaveWorkedWith]
FROM Silver.Bridge_DatabaseHaveWorkedWith_Clean_2024
WHERE [DatabaseHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_DatabaseWantToWorkWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_DatabaseWantToWorkWith_Clean (SurveyYear, ResponseId, [DatabaseWantToWorkWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [DatabaseWantToWorkWith]
FROM Silver.Bridge_DatabaseWantToWorkWith_Clean_2024
WHERE [DatabaseWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_DevType_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_DevType_Clean (SurveyYear, ResponseId, [DevType_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [DevType]
FROM Silver.Bridge_DevType_Clean_2024
WHERE [DevType] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_EmbeddedHaveWorkedWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_EmbeddedHaveWorkedWith_Clean (SurveyYear, ResponseId, [EmbeddedHaveWorkedWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [EmbeddedHaveWorkedWith]
FROM Silver.Bridge_EmbeddedHaveWorkedWith_Clean_2024
WHERE [EmbeddedHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_EmbeddedWantToWorkWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_EmbeddedWantToWorkWith_Clean (SurveyYear, ResponseId, [EmbeddedWantToWorkWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [EmbeddedWantToWorkWith]
FROM Silver.Bridge_EmbeddedWantToWorkWith_Clean_2024
WHERE [EmbeddedWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_LanguageHaveWorkedWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_LanguageHaveWorkedWith_Clean (SurveyYear, ResponseId, [LanguageHaveWorkedWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [LanguageHaveWorkedWith]
FROM Silver.Bridge_LanguageHaveWorkedWith_Clean_2024
WHERE [LanguageHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_LanguageWantToWorkWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_LanguageWantToWorkWith_Clean (SurveyYear, ResponseId, [LanguageWantToWorkWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [LanguageWantToWorkWith]
FROM Silver.Bridge_LanguageWantToWorkWith_Clean_2024
WHERE [LanguageWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_LearnCode_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_LearnCode_Clean (SurveyYear, ResponseId, [LearnCode_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [LearnCode]
FROM Silver.Bridge_LearnCode_Clean_2024
WHERE [LearnCode] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_MiscTechHaveWorkedWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_MiscTechHaveWorkedWith_Clean (SurveyYear, ResponseId, [MiscTechHaveWorkedWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [MiscTechHaveWorkedWith]
FROM Silver.Bridge_MiscTechHaveWorkedWith_Clean_2024
WHERE [MiscTechHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_MiscTechWantToWorkWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_MiscTechWantToWorkWith_Clean (SurveyYear, ResponseId, [MiscTechWantToWorkWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [MiscTechWantToWorkWith]
FROM Silver.Bridge_MiscTechWantToWorkWith_Clean_2024
WHERE [MiscTechWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_NEWCollabToolsHaveWorkedWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_NEWCollabToolsHaveWorkedWith_Clean (SurveyYear, ResponseId, [NEWCollabToolsHaveWorkedWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [NEWCollabToolsHaveWorkedWith]
FROM Silver.Bridge_NEWCollabToolsHaveWorkedWith_Clean_2024
WHERE [NEWCollabToolsHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_NEWCollabToolsWantToWorkWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_NEWCollabToolsWantToWorkWith_Clean (SurveyYear, ResponseId, [NEWCollabToolsWantToWorkWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [NEWCollabToolsWantToWorkWith]
FROM Silver.Bridge_NEWCollabToolsWantToWorkWith_Clean_2024
WHERE [NEWCollabToolsWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_OfficeStackAsyncHaveWorkedWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_OfficeStackAsyncHaveWorkedWith_Clean (SurveyYear, ResponseId, [OfficeStackAsyncHaveWorkedWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [OfficeStackAsyncHaveWorkedWith]
FROM Silver.Bridge_OfficeStackAsyncHaveWorkedWith_Clean_2024
WHERE [OfficeStackAsyncHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_OfficeStackAsyncWantToWorkWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_OfficeStackAsyncWantToWorkWith_Clean (SurveyYear, ResponseId, [OfficeStackAsyncWantToWorkWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [OfficeStackAsyncWantToWorkWith]
FROM Silver.Bridge_OfficeStackAsyncWantToWorkWith_Clean_2024
WHERE [OfficeStackAsyncWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_OfficeStackSyncHaveWorkedWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_OfficeStackSyncHaveWorkedWith_Clean (SurveyYear, ResponseId, [OfficeStackSyncHaveWorkedWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [OfficeStackSyncHaveWorkedWith]
FROM Silver.Bridge_OfficeStackSyncHaveWorkedWith_Clean_2024
WHERE [OfficeStackSyncHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_OfficeStackSyncWantToWorkWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_OfficeStackSyncWantToWorkWith_Clean (SurveyYear, ResponseId, [OfficeStackSyncWantToWorkWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [OfficeStackSyncWantToWorkWith]
FROM Silver.Bridge_OfficeStackSyncWantToWorkWith_Clean_2024
WHERE [OfficeStackSyncWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_PlatformHaveWorkedWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_PlatformHaveWorkedWith_Clean (SurveyYear, ResponseId, [PlatformHaveWorkedWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [PlatformHaveWorkedWith]
FROM Silver.Bridge_PlatformHaveWorkedWith_Clean_2024
WHERE [PlatformHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_PlatformWantToWorkWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_PlatformWantToWorkWith_Clean (SurveyYear, ResponseId, [PlatformWantToWorkWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [PlatformWantToWorkWith]
FROM Silver.Bridge_PlatformWantToWorkWith_Clean_2024
WHERE [PlatformWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_ToolsTechHaveWorkedWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_ToolsTechHaveWorkedWith_Clean (SurveyYear, ResponseId, [ToolsTechHaveWorkedWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [ToolsTechHaveWorkedWith]
FROM Silver.Bridge_ToolsTechHaveWorkedWith_Clean_2024
WHERE [ToolsTechHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_ToolsTechWantToWorkWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_ToolsTechWantToWorkWith_Clean (SurveyYear, ResponseId, [ToolsTechWantToWorkWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [ToolsTechWantToWorkWith]
FROM Silver.Bridge_ToolsTechWantToWorkWith_Clean_2024
WHERE [ToolsTechWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_WebframeHaveWorkedWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_WebframeHaveWorkedWith_Clean (SurveyYear, ResponseId, [WebframeHaveWorkedWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [WebframeHaveWorkedWith]
FROM Silver.Bridge_WebframeHaveWorkedWith_Clean_2024
WHERE [WebframeHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_WebframeWantToWorkWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_WebframeWantToWorkWith_Clean (SurveyYear, ResponseId, [WebframeWantToWorkWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [WebframeWantToWorkWith]
FROM Silver.Bridge_WebframeWantToWorkWith_Clean_2024
WHERE [WebframeWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_AISearchHaveWorkedWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_AISearchHaveWorkedWith_Clean (SurveyYear, ResponseId, [AISearchHaveWorkedWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [AISearchHaveWorkedWith_Clean]
FROM Silver.Bridge_AISearchHaveWorkedWith_Clean_2024
WHERE [AISearchHaveWorkedWith_Clean] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_AISearchWantToWorkWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_AISearchWantToWorkWith_Clean (SurveyYear, ResponseId, [AISearchWantToWorkWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [AISearchWantToWorkWith_Clean]
FROM Silver.Bridge_AISearchWantToWorkWith_Clean_2024
WHERE [AISearchWantToWorkWith_Clean] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_AIDevHaveWorkedWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_AIDevHaveWorkedWith_Clean (SurveyYear, ResponseId, [AIDevHaveWorkedWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [AIDevHaveWorkedWith_Clean]
FROM Silver.Bridge_AIDevHaveWorkedWith_Clean_2024
WHERE [AIDevHaveWorkedWith_Clean] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_AIDevWantToWorkWith_Clean WHERE SurveyYear = CAST('2024-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_AIDevWantToWorkWith_Clean (SurveyYear, ResponseId, [AIDevWantToWorkWith_Clean])
SELECT CAST('2024-01-01' AS DATETIME) AS SurveyYear, ResponseId, [AIDevWantToWorkWith_Clean]
FROM Silver.Bridge_AIDevWantToWorkWith_Clean_2024
WHERE [AIDevWantToWorkWith_Clean] IS NOT NULL;
GO