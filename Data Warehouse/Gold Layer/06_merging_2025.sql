DELETE FROM Gold.Fact_Survey WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Fact_Survey (SurveyYear, ResponseId, [AIAcc], [AIAgentChallengesNeutral], [AIAgentChallengesSomewhat agree], [AIAgentChallengesSomewhat disagree], [AIAgentChallengesStrongly agree], [AIAgentChallengesStrongly disagree], [AIAgentChange], [AIAgentExtWrite], [AIAgentExternal], [AIAgentImpactNeutral], [AIAgentImpactSomewhat agree], [AIAgentImpactSomewhat disagree], [AIAgentImpactStrongly agree], [AIAgentImpactStrongly disagree], [AIAgentKnowWrite], [AIAgentKnowledge], [AIAgentObsWrite], [AIAgentObserveSecure], [AIAgentOrchWrite], [AIAgentOrchestration], [AIAgent_Uses], [AIAgents], [AIComplex], [AIExplain], [AIFrustration], [AIHuman], [AILearnHow], [AIModelsAdmired], [AIModelsChoice], [AIModelsHaveEntry], [AIModelsWantEntry], [AIOpen], [AISelect], [AISent], [AIThreat], [AIToolCurrently mostly AI], [AIToolCurrently partially AI], [AIToolDon't plan to use AI for this task], [AIToolPlan to mostly use AI], [AIToolPlan to partially use AI], [AgentUsesGeneral], [CommPlatformAdmired], [CommPlatformHaveEntr], [CommPlatformWantEntr], [CompTotal], [ConvertedCompYearly], [Country], [Currency_Code], [Current_Profession], [DatabaseAdmired], [DatabaseChoice], [DatabaseHaveEntry], [DatabaseWantEntry], [DevEnvHaveEntry], [DevEnvWantEntry], [DevEnvsAdmired], [DevEnvsChoice], [Education_Level], [EmploymentAddl], [ICorPM], [Industry], [JobSat], [JobSatPoints_1], [JobSatPoints_10], [JobSatPoints_11], [JobSatPoints_13], [JobSatPoints_14], [JobSatPoints_15], [JobSatPoints_15_TEXT], [JobSatPoints_16], [JobSatPoints_2], [JobSatPoints_3], [JobSatPoints_4], [JobSatPoints_5], [JobSatPoints_6], [JobSatPoints_7], [JobSatPoints_8], [JobSatPoints_9], [LanguageAdmired], [LanguageChoice], [LanguagesHaveEntry], [LanguagesWantEntry], [LearnCodeAI], [LearnCodeChoose], [MainBranch], [NewRole], [OfficeStackAsyncAdmired], [OfficeStackHaveEntry], [OfficeStackWantEntry], [OperatingSystem_Personal], [OperatingSystem_Professional], [Organization_Size], [PlatformAdmired], [PlatformChoice], [PlatformHaveEntry], [PlatformWantEntry], [PurchaseInfluence], [RemoteWork], [SODuration], [SOFriction], [SOTagsAdmired], [SOTagsHaveEntry], [SOTagsWant Entry], [SO_Actions_1], [SO_Actions_10], [SO_Actions_15], [SO_Actions_15_TEXT], [SO_Actions_16], [SO_Actions_3], [SO_Actions_4], [SO_Actions_5], [SO_Actions_6], [SO_Actions_7], [SO_Actions_9], [SO_Dev_Content], [StackOverflow_Account_exists], [StackOverflow_Community_Experience], [StackOverflow_Participation_Frequency], [StackOverflow_Visit_Frequency], [TechEndorseIntro], [TechEndorse_1], [TechEndorse_13], [TechEndorse_13_TEXT], [TechEndorse_2], [TechEndorse_3], [TechEndorse_4], [TechEndorse_5], [TechEndorse_6], [TechEndorse_7], [TechEndorse_8], [TechEndorse_9], [TechOppose_1], [TechOppose_11], [TechOppose_13], [TechOppose_15], [TechOppose_15_TEXT], [TechOppose_16], [TechOppose_2], [TechOppose_3], [TechOppose_5], [TechOppose_7], [TechOppose_9], [ToolCountPersonal], [ToolCountWork], [WebframeAdmired], [WebframeChoice], [WebframeHaveEntry], [WebframeWantEntry], [WorkExp], [YearsCode])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [AIAcc], [AIAgentChallengesNeutral], [AIAgentChallengesSomewhat agree], [AIAgentChallengesSomewhat disagree], [AIAgentChallengesStrongly agree], [AIAgentChallengesStrongly disagree], [AIAgentChange], [AIAgentExtWrite], [AIAgentExternal], [AIAgentImpactNeutral], [AIAgentImpactSomewhat agree], [AIAgentImpactSomewhat disagree], [AIAgentImpactStrongly agree], [AIAgentImpactStrongly disagree], [AIAgentKnowWrite], [AIAgentKnowledge], [AIAgentObsWrite], [AIAgentObserveSecure], [AIAgentOrchWrite], [AIAgentOrchestration], [AIAgent_Uses], [AIAgents], [AIComplex], [AIExplain], [AIFrustration], [AIHuman], [AILearnHow], [AIModelsAdmired], [AIModelsChoice], [AIModelsHaveEntry], [AIModelsWantEntry], [AIOpen], [AISelect], [AISent], [AIThreat], [AIToolCurrently mostly AI], [AIToolCurrently partially AI], [AIToolDon't plan to use AI for this task], [AIToolPlan to mostly use AI], [AIToolPlan to partially use AI], [AgentUsesGeneral], [CommPlatformAdmired], [CommPlatformHaveEntr], [CommPlatformWantEntr], [CompTotal], [ConvertedCompYearly], [Country], [Currency_Code], [Current_Profession], [DatabaseAdmired], [DatabaseChoice], [DatabaseHaveEntry], [DatabaseWantEntry], [DevEnvHaveEntry], [DevEnvWantEntry], [DevEnvsAdmired], [DevEnvsChoice], [Education_Level], [EmploymentAddl], [ICorPM], [Industry], [JobSat], [JobSatPoints_1], [JobSatPoints_10], [JobSatPoints_11], [JobSatPoints_13], [JobSatPoints_14], [JobSatPoints_15], [JobSatPoints_15_TEXT], [JobSatPoints_16], [JobSatPoints_2], [JobSatPoints_3], [JobSatPoints_4], [JobSatPoints_5], [JobSatPoints_6], [JobSatPoints_7], [JobSatPoints_8], [JobSatPoints_9], [LanguageAdmired], [LanguageChoice], [LanguagesHaveEntry], [LanguagesWantEntry], [LearnCodeAI], [LearnCodeChoose], [MainBranch], [NewRole], [OfficeStackAsyncAdmired], [OfficeStackHaveEntry], [OfficeStackWantEntry], [OperatingSystem_Personal], [OperatingSystem_Professional], [Organization_Size], [PlatformAdmired], [PlatformChoice], [PlatformHaveEntry], [PlatformWantEntry], [PurchaseInfluence], [RemoteWork], [SODuration], [SOFriction], [SOTagsAdmired], [SOTagsHaveEntry], [SOTagsWant Entry], [SO_Actions_1], [SO_Actions_10], [SO_Actions_15], [SO_Actions_15_TEXT], [SO_Actions_16], [SO_Actions_3], [SO_Actions_4], [SO_Actions_5], [SO_Actions_6], [SO_Actions_7], [SO_Actions_9], [SO_Dev_Content], [StackOverflow_Account_exists], [StackOverflow_Community_Experience], [StackOverflow_Participation_Frequency], [StackOverflow_Visit_Frequency], [TechEndorseIntro], [TechEndorse_1], [TechEndorse_13], [TechEndorse_13_TEXT], [TechEndorse_2], [TechEndorse_3], [TechEndorse_4], [TechEndorse_5], [TechEndorse_6], [TechEndorse_7], [TechEndorse_8], [TechEndorse_9], [TechOppose_1], [TechOppose_11], [TechOppose_13], [TechOppose_15], [TechOppose_15_TEXT], [TechOppose_16], [TechOppose_2], [TechOppose_3], [TechOppose_5], [TechOppose_7], [TechOppose_9], [ToolCountPersonal], [ToolCountWork], [WebframeAdmired], [WebframeChoice], [WebframeHaveEntry], [WebframeWantEntry], [WorkExp], [YearsCode]
FROM Silver.Survey_2025;
GO

DELETE FROM Gold.Bridge_AIModelsHaveWorkedWith_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_AIModelsHaveWorkedWith_Clean (SurveyYear, ResponseId, [AIModelsHaveWorkedWith_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [AIModelsHaveWorkedWith]
FROM Silver.Bridge_AIModelsHaveWorkedWith_Clean_2025
WHERE [AIModelsHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_AIModelsWantToWorkWith_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_AIModelsWantToWorkWith_Clean (SurveyYear, ResponseId, [AIModelsWantToWorkWith_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [AIModelsWantToWorkWith]
FROM Silver.Bridge_AIModelsWantToWorkWith_Clean_2025
WHERE [AIModelsWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_CommPlatformHaveWorkedWith_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_CommPlatformHaveWorkedWith_Clean (SurveyYear, ResponseId, [CommPlatformHaveWorkedWith_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [CommPlatformHaveWorkedWith]
FROM Silver.Bridge_CommPlatformHaveWorkedWith_Clean_2025
WHERE [CommPlatformHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_CommPlatformWantToWorkWith_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_CommPlatformWantToWorkWith_Clean (SurveyYear, ResponseId, [CommPlatformWantToWorkWith_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [CommPlatformWantToWorkWith]
FROM Silver.Bridge_CommPlatformWantToWorkWith_Clean_2025
WHERE [CommPlatformWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_DatabaseHaveWorkedWith_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_DatabaseHaveWorkedWith_Clean (SurveyYear, ResponseId, [DatabaseHaveWorkedWith_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [DatabaseHaveWorkedWith]
FROM Silver.Bridge_DatabaseHaveWorkedWith_Clean_2025
WHERE [DatabaseHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_DatabaseWantToWorkWith_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_DatabaseWantToWorkWith_Clean (SurveyYear, ResponseId, [DatabaseWantToWorkWith_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [DatabaseWantToWorkWith]
FROM Silver.Bridge_DatabaseWantToWorkWith_Clean_2025
WHERE [DatabaseWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_DevEnvsHaveWorkedWith_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_DevEnvsHaveWorkedWith_Clean (SurveyYear, ResponseId, [DevEnvsHaveWorkedWith_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [DevEnvsHaveWorkedWith]
FROM Silver.Bridge_DevEnvsHaveWorkedWith_Clean_2025
WHERE [DevEnvsHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_DevEnvsWantToWorkWith_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_DevEnvsWantToWorkWith_Clean (SurveyYear, ResponseId, [DevEnvsWantToWorkWith_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [DevEnvsWantToWorkWith]
FROM Silver.Bridge_DevEnvsWantToWorkWith_Clean_2025
WHERE [DevEnvsWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_DevType_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_DevType_Clean (SurveyYear, ResponseId, [DevType_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [DevType]
FROM Silver.Bridge_DevType_Clean_2025
WHERE [DevType] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_LanguageHaveWorkedWith_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_LanguageHaveWorkedWith_Clean (SurveyYear, ResponseId, [LanguageHaveWorkedWith_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [LanguageHaveWorkedWith]
FROM Silver.Bridge_LanguageHaveWorkedWith_Clean_2025
WHERE [LanguageHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_LanguageWantToWorkWith_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_LanguageWantToWorkWith_Clean (SurveyYear, ResponseId, [LanguageWantToWorkWith_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [LanguageWantToWorkWith]
FROM Silver.Bridge_LanguageWantToWorkWith_Clean_2025
WHERE [LanguageWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_LearnCode_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_LearnCode_Clean (SurveyYear, ResponseId, [LearnCode_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [LearnCode]
FROM Silver.Bridge_LearnCode_Clean_2025
WHERE [LearnCode] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_OfficeStackAsyncHaveWorkedWith_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_OfficeStackAsyncHaveWorkedWith_Clean (SurveyYear, ResponseId, [OfficeStackAsyncHaveWorkedWith_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [OfficeStackAsyncHaveWorkedWith]
FROM Silver.Bridge_OfficeStackAsyncHaveWorkedWith_Clean_2025
WHERE [OfficeStackAsyncHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_OfficeStackAsyncWantToWorkWith_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_OfficeStackAsyncWantToWorkWith_Clean (SurveyYear, ResponseId, [OfficeStackAsyncWantToWorkWith_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [OfficeStackAsyncWantToWorkWith]
FROM Silver.Bridge_OfficeStackAsyncWantToWorkWith_Clean_2025
WHERE [OfficeStackAsyncWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_PlatformHaveWorkedWith_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_PlatformHaveWorkedWith_Clean (SurveyYear, ResponseId, [PlatformHaveWorkedWith_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [PlatformHaveWorkedWith]
FROM Silver.Bridge_PlatformHaveWorkedWith_Clean_2025
WHERE [PlatformHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_PlatformWantToWorkWith_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_PlatformWantToWorkWith_Clean (SurveyYear, ResponseId, [PlatformWantToWorkWith_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [PlatformWantToWorkWith]
FROM Silver.Bridge_PlatformWantToWorkWith_Clean_2025
WHERE [PlatformWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_SOTagsHaveWorkedWith_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_SOTagsHaveWorkedWith_Clean (SurveyYear, ResponseId, [SOTagsHaveWorkedWith_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [SOTagsHaveWorkedWith]
FROM Silver.Bridge_SOTagsHaveWorkedWith_Clean_2025
WHERE [SOTagsHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_SOTagsWantToWorkWith_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_SOTagsWantToWorkWith_Clean (SurveyYear, ResponseId, [SOTagsWantToWorkWith_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [SOTagsWantToWorkWith]
FROM Silver.Bridge_SOTagsWantToWorkWith_Clean_2025
WHERE [SOTagsWantToWorkWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_WebframeHaveWorkedWith_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_WebframeHaveWorkedWith_Clean (SurveyYear, ResponseId, [WebframeHaveWorkedWith_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [WebframeHaveWorkedWith]
FROM Silver.Bridge_WebframeHaveWorkedWith_Clean_2025
WHERE [WebframeHaveWorkedWith] IS NOT NULL;
GO

DELETE FROM Gold.Bridge_WebframeWantToWorkWith_Clean WHERE SurveyYear = CAST('2025-01-01' AS DATETIME);
GO

INSERT INTO Gold.Bridge_WebframeWantToWorkWith_Clean (SurveyYear, ResponseId, [WebframeWantToWorkWith_Clean])
SELECT CAST('2025-01-01' AS DATETIME) AS SurveyYear, ResponseId, [WebframeWantToWorkWith]
FROM Silver.Bridge_WebframeWantToWorkWith_Clean_2025
WHERE [WebframeWantToWorkWith] IS NOT NULL;
GO
