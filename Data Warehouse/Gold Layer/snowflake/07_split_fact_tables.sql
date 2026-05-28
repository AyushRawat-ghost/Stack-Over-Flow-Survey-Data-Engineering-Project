IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Snowflake') EXEC('CREATE SCHEMA Snowflake');
GO

-- ==========================================
-- DIM_DEMOGRAPHICS
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_Demographics', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_Demographics;
GO
CREATE VIEW Snowflake.Dim_Demographics AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AgeCode] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Gender_Clean] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Ethnicity_Clean] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Sexuality_Clean] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TransGender] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Accessibility_Status] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Mental_Health_Status] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Country] AS NVARCHAR(MAX)), ''), ISNULL(CAST([USA_State] AS NVARCHAR(MAX)), ''))), 2) AS Dim_DemographicsID,
    CAST([AgeCode] AS VARCHAR(255)) AS [AgeCode],
    CAST([Gender_Clean] AS VARCHAR(255)) AS [Gender_Clean],
    CAST([Ethnicity_Clean] AS VARCHAR(255)) AS [Ethnicity_Clean],
    CAST([Sexuality_Clean] AS VARCHAR(255)) AS [Sexuality_Clean],
    CAST([TransGender] AS VARCHAR(255)) AS [TransGender],
    CAST([Accessibility_Status] AS VARCHAR(255)) AS [Accessibility_Status],
    CAST([Mental_Health_Status] AS VARCHAR(255)) AS [Mental_Health_Status],
    CAST([Country] AS VARCHAR(255)) AS [Country],
    CAST([USA_State] AS VARCHAR(255)) AS [USA_State]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_EMPLOYMENT
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_Employment', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_Employment;
GO
CREATE VIEW Snowflake.Dim_Employment AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([Current_Profession] AS NVARCHAR(MAX)), ''), ISNULL(CAST([EmploymentAddl] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Industry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Organization_Size] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ICorPM] AS NVARCHAR(MAX)), ''), ISNULL(CAST([WorkExp] AS NVARCHAR(MAX)), ''), ISNULL(CAST([RemoteWork] AS NVARCHAR(MAX)), ''))), 2) AS Dim_EmploymentID,
    CAST([Current_Profession] AS VARCHAR(255)) AS [Current_Profession],
    CAST([EmploymentAddl] AS VARCHAR(255)) AS [EmploymentAddl],
    CAST([Industry] AS VARCHAR(255)) AS [Industry],
    CAST([Organization_Size] AS VARCHAR(255)) AS [Organization_Size],
    CAST([ICorPM] AS VARCHAR(255)) AS [ICorPM],
    CAST([WorkExp] AS VARCHAR(255)) AS [WorkExp],
    CAST([RemoteWork] AS VARCHAR(255)) AS [RemoteWork]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_COMPENSATION
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_Compensation', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_Compensation;
GO
CREATE VIEW Snowflake.Dim_Compensation AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([CompTotal] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Compensation_Frequency] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ConvertedCompYearly] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Currency_Code] AS NVARCHAR(MAX)), ''))), 2) AS Dim_CompensationID,
    CAST([CompTotal] AS FLOAT) AS [CompTotal],
    CAST([Compensation_Frequency] AS VARCHAR(255)) AS [Compensation_Frequency],
    CAST([ConvertedCompYearly] AS FLOAT) AS [ConvertedCompYearly],
    CAST([Currency_Code] AS VARCHAR(255)) AS [Currency_Code]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_EDUCATION
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_Education', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_Education;
GO
CREATE VIEW Snowflake.Dim_Education AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([Education_Level] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LearnCodeOnline] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LearnCodeChoose] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LearnCodeCoursesCert] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LearnCodeAI] AS NVARCHAR(MAX)), ''))), 2) AS Dim_EducationID,
    CAST([Education_Level] AS VARCHAR(255)) AS [Education_Level],
    CAST([LearnCodeOnline] AS VARCHAR(255)) AS [LearnCodeOnline],
    CAST([LearnCodeChoose] AS VARCHAR(255)) AS [LearnCodeChoose],
    CAST([LearnCodeCoursesCert] AS VARCHAR(255)) AS [LearnCodeCoursesCert],
    CAST([LearnCodeAI] AS VARCHAR(255)) AS [LearnCodeAI]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_SATISFACTION
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_Satisfaction', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_Satisfaction;
GO
CREATE VIEW Snowflake.Dim_Satisfaction AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([JobSat] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_1] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_10] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_11] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_13] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_14] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_15] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_15_TEXT] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_16] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_2] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_3] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_4] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_5] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_6] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_7] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_8] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_9] AS NVARCHAR(MAX)), ''))), 2) AS Dim_SatisfactionID,
    CAST([JobSat] AS VARCHAR(255)) AS [JobSat],
    CAST([JobSatPoints_1] AS VARCHAR(255)) AS [JobSatPoints_1],
    CAST([JobSatPoints_10] AS VARCHAR(255)) AS [JobSatPoints_10],
    CAST([JobSatPoints_11] AS VARCHAR(255)) AS [JobSatPoints_11],
    CAST([JobSatPoints_13] AS VARCHAR(255)) AS [JobSatPoints_13],
    CAST([JobSatPoints_14] AS VARCHAR(255)) AS [JobSatPoints_14],
    CAST([JobSatPoints_15] AS VARCHAR(255)) AS [JobSatPoints_15],
    CAST([JobSatPoints_15_TEXT] AS VARCHAR(255)) AS [JobSatPoints_15_TEXT],
    CAST([JobSatPoints_16] AS VARCHAR(255)) AS [JobSatPoints_16],
    CAST([JobSatPoints_2] AS VARCHAR(255)) AS [JobSatPoints_2],
    CAST([JobSatPoints_3] AS VARCHAR(255)) AS [JobSatPoints_3],
    CAST([JobSatPoints_4] AS VARCHAR(255)) AS [JobSatPoints_4],
    CAST([JobSatPoints_5] AS VARCHAR(255)) AS [JobSatPoints_5],
    CAST([JobSatPoints_6] AS VARCHAR(255)) AS [JobSatPoints_6],
    CAST([JobSatPoints_7] AS VARCHAR(255)) AS [JobSatPoints_7],
    CAST([JobSatPoints_8] AS VARCHAR(255)) AS [JobSatPoints_8],
    CAST([JobSatPoints_9] AS VARCHAR(255)) AS [JobSatPoints_9]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_KNOWLEDGE
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_Knowledge', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_Knowledge;
GO
CREATE VIEW Snowflake.Dim_Knowledge AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([Knowledge_1] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Knowledge_2] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Knowledge_3] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Knowledge_4] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Knowledge_5] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Knowledge_6] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Knowledge_7] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Knowledge_8] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Knowledge_9] AS NVARCHAR(MAX)), ''))), 2) AS Dim_KnowledgeID,
    CAST([Knowledge_1] AS VARCHAR(255)) AS [Knowledge_1],
    CAST([Knowledge_2] AS VARCHAR(255)) AS [Knowledge_2],
    CAST([Knowledge_3] AS VARCHAR(255)) AS [Knowledge_3],
    CAST([Knowledge_4] AS VARCHAR(255)) AS [Knowledge_4],
    CAST([Knowledge_5] AS VARCHAR(255)) AS [Knowledge_5],
    CAST([Knowledge_6] AS VARCHAR(255)) AS [Knowledge_6],
    CAST([Knowledge_7] AS VARCHAR(255)) AS [Knowledge_7],
    CAST([Knowledge_8] AS VARCHAR(255)) AS [Knowledge_8],
    CAST([Knowledge_9] AS VARCHAR(255)) AS [Knowledge_9]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_STACKOVERFLOW
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_StackOverflow', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_StackOverflow;
GO
CREATE VIEW Snowflake.Dim_StackOverflow AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([NewStackOverflow_Sites] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SOAI] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SODuration] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SOFriction] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SOHow] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SOTagsAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SOTagsHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SOTagsWant Entry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Dev_Content] AS NVARCHAR(MAX)), ''), ISNULL(CAST([StackOverflow_Account_exists] AS NVARCHAR(MAX)), ''), ISNULL(CAST([StackOverflow_Community_Experience] AS NVARCHAR(MAX)), ''), ISNULL(CAST([StackOverflow_Participation_Frequency] AS NVARCHAR(MAX)), ''), ISNULL(CAST([StackOverflow_Visit_Frequency] AS NVARCHAR(MAX)), ''))), 2) AS Dim_StackOverflowID,
    CAST([NewStackOverflow_Sites] AS VARCHAR(255)) AS [NewStackOverflow_Sites],
    CAST([SOAI] AS VARCHAR(255)) AS [SOAI],
    CAST([SODuration] AS VARCHAR(255)) AS [SODuration],
    CAST([SOFriction] AS VARCHAR(255)) AS [SOFriction],
    CAST([SOHow] AS VARCHAR(255)) AS [SOHow],
    CAST([SOTagsAdmired] AS VARCHAR(255)) AS [SOTagsAdmired],
    CAST([SOTagsHaveEntry] AS VARCHAR(255)) AS [SOTagsHaveEntry],
    CAST([SOTagsWant Entry] AS VARCHAR(255)) AS [SOTagsWant Entry],
    CAST([SO_Dev_Content] AS VARCHAR(255)) AS [SO_Dev_Content],
    CAST([StackOverflow_Account_exists] AS VARCHAR(255)) AS [StackOverflow_Account_exists],
    CAST([StackOverflow_Community_Experience] AS VARCHAR(255)) AS [StackOverflow_Community_Experience],
    CAST([StackOverflow_Participation_Frequency] AS VARCHAR(255)) AS [StackOverflow_Participation_Frequency],
    CAST([StackOverflow_Visit_Frequency] AS VARCHAR(255)) AS [StackOverflow_Visit_Frequency]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_SOACTIONS
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_SOActions', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_SOActions;
GO
CREATE VIEW Snowflake.Dim_SOActions AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([SO_Actions_1] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_10] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_15] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_15_TEXT] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_16] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_3] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_4] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_5] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_6] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_7] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_9] AS NVARCHAR(MAX)), ''))), 2) AS Dim_SOActionsID,
    CAST([SO_Actions_1] AS VARCHAR(255)) AS [SO_Actions_1],
    CAST([SO_Actions_10] AS VARCHAR(255)) AS [SO_Actions_10],
    CAST([SO_Actions_15] AS VARCHAR(255)) AS [SO_Actions_15],
    CAST([SO_Actions_15_TEXT] AS VARCHAR(255)) AS [SO_Actions_15_TEXT],
    CAST([SO_Actions_16] AS VARCHAR(255)) AS [SO_Actions_16],
    CAST([SO_Actions_3] AS VARCHAR(255)) AS [SO_Actions_3],
    CAST([SO_Actions_4] AS VARCHAR(255)) AS [SO_Actions_4],
    CAST([SO_Actions_5] AS VARCHAR(255)) AS [SO_Actions_5],
    CAST([SO_Actions_6] AS VARCHAR(255)) AS [SO_Actions_6],
    CAST([SO_Actions_7] AS VARCHAR(255)) AS [SO_Actions_7],
    CAST([SO_Actions_9] AS VARCHAR(255)) AS [SO_Actions_9]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_MISCCATEGORICAL
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_MiscCategorical', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_MiscCategorical;
GO
CREATE VIEW Snowflake.Dim_MiscCategorical AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AgentUsesGeneral] AS NVARCHAR(MAX)), ''), ISNULL(CAST([BuildvsBuy] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Check] AS NVARCHAR(MAX)), ''), ISNULL(CAST([CodingActivities] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Frequency_1] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Frequency_2] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Frequency_3] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Frustration] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Know_Other_Community] AS NVARCHAR(MAX)), ''), ISNULL(CAST([MainBranch] AS NVARCHAR(MAX)), ''), ISNULL(CAST([NewRole] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Onboarding] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ProfessionalCloud] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ProfessionalQuestion] AS NVARCHAR(MAX)), ''), ISNULL(CAST([PurchaseInfluence] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Q120] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Survey_Ease] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Survey_Length] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TBranch] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TimeAnswering] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TimeSearching] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TrueFalse_1] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TrueFalse_2] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TrueFalse_3] AS NVARCHAR(MAX)), ''), ISNULL(CAST([VCHostingPersonal use] AS NVARCHAR(MAX)), ''), ISNULL(CAST([VCHostingProfessional use] AS NVARCHAR(MAX)), ''), ISNULL(CAST([VCInteraction] AS NVARCHAR(MAX)), ''))), 2) AS Dim_MiscCategoricalID,
    CAST([AgentUsesGeneral] AS VARCHAR(255)) AS [AgentUsesGeneral],
    CAST([BuildvsBuy] AS VARCHAR(255)) AS [BuildvsBuy],
    CAST([Check] AS VARCHAR(255)) AS [Check],
    CAST([CodingActivities] AS VARCHAR(255)) AS [CodingActivities],
    CAST([Frequency_1] AS VARCHAR(255)) AS [Frequency_1],
    CAST([Frequency_2] AS VARCHAR(255)) AS [Frequency_2],
    CAST([Frequency_3] AS VARCHAR(255)) AS [Frequency_3],
    CAST([Frustration] AS VARCHAR(255)) AS [Frustration],
    CAST([Know_Other_Community] AS VARCHAR(255)) AS [Know_Other_Community],
    CAST([MainBranch] AS VARCHAR(255)) AS [MainBranch],
    CAST([NewRole] AS VARCHAR(255)) AS [NewRole],
    CAST([Onboarding] AS VARCHAR(255)) AS [Onboarding],
    CAST([ProfessionalCloud] AS VARCHAR(255)) AS [ProfessionalCloud],
    CAST([ProfessionalQuestion] AS VARCHAR(255)) AS [ProfessionalQuestion],
    CAST([PurchaseInfluence] AS VARCHAR(255)) AS [PurchaseInfluence],
    CAST([Q120] AS VARCHAR(255)) AS [Q120],
    CAST([Survey_Ease] AS VARCHAR(255)) AS [Survey_Ease],
    CAST([Survey_Length] AS VARCHAR(255)) AS [Survey_Length],
    CAST([TBranch] AS VARCHAR(255)) AS [TBranch],
    CAST([TimeAnswering] AS VARCHAR(255)) AS [TimeAnswering],
    CAST([TimeSearching] AS VARCHAR(255)) AS [TimeSearching],
    CAST([TrueFalse_1] AS VARCHAR(255)) AS [TrueFalse_1],
    CAST([TrueFalse_2] AS VARCHAR(255)) AS [TrueFalse_2],
    CAST([TrueFalse_3] AS VARCHAR(255)) AS [TrueFalse_3],
    CAST([VCHostingPersonal use] AS VARCHAR(255)) AS [VCHostingPersonal use],
    CAST([VCHostingProfessional use] AS VARCHAR(255)) AS [VCHostingProfessional use],
    CAST([VCInteraction] AS VARCHAR(255)) AS [VCInteraction]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_AIAGENTS
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_AIAgents', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_AIAgents;
GO
CREATE VIEW Snowflake.Dim_AIAgents AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AIAgentChallengesNeutral] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChallengesSomewhat agree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChallengesSomewhat disagree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChallengesStrongly agree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChallengesStrongly disagree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChange] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentExtWrite] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentExternal] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactNeutral] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactSomewhat agree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactSomewhat disagree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactStrongly agree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactStrongly disagree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentKnowWrite] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentKnowledge] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentObsWrite] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentObserveSecure] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentOrchWrite] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentOrchestration] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgent_Uses] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgents] AS NVARCHAR(MAX)), ''))), 2) AS Dim_AIAgentsID,
    CAST([AIAgentChallengesNeutral] AS VARCHAR(255)) AS [AIAgentChallengesNeutral],
    CAST([AIAgentChallengesSomewhat agree] AS VARCHAR(255)) AS [AIAgentChallengesSomewhat agree],
    CAST([AIAgentChallengesSomewhat disagree] AS VARCHAR(255)) AS [AIAgentChallengesSomewhat disagree],
    CAST([AIAgentChallengesStrongly agree] AS VARCHAR(255)) AS [AIAgentChallengesStrongly agree],
    CAST([AIAgentChallengesStrongly disagree] AS VARCHAR(255)) AS [AIAgentChallengesStrongly disagree],
    CAST([AIAgentChange] AS VARCHAR(255)) AS [AIAgentChange],
    CAST([AIAgentExtWrite] AS VARCHAR(255)) AS [AIAgentExtWrite],
    CAST([AIAgentExternal] AS VARCHAR(255)) AS [AIAgentExternal],
    CAST([AIAgentImpactNeutral] AS VARCHAR(255)) AS [AIAgentImpactNeutral],
    CAST([AIAgentImpactSomewhat agree] AS VARCHAR(255)) AS [AIAgentImpactSomewhat agree],
    CAST([AIAgentImpactSomewhat disagree] AS VARCHAR(255)) AS [AIAgentImpactSomewhat disagree],
    CAST([AIAgentImpactStrongly agree] AS VARCHAR(255)) AS [AIAgentImpactStrongly agree],
    CAST([AIAgentImpactStrongly disagree] AS VARCHAR(255)) AS [AIAgentImpactStrongly disagree],
    CAST([AIAgentKnowWrite] AS VARCHAR(255)) AS [AIAgentKnowWrite],
    CAST([AIAgentKnowledge] AS VARCHAR(255)) AS [AIAgentKnowledge],
    CAST([AIAgentObsWrite] AS VARCHAR(255)) AS [AIAgentObsWrite],
    CAST([AIAgentObserveSecure] AS VARCHAR(255)) AS [AIAgentObserveSecure],
    CAST([AIAgentOrchWrite] AS VARCHAR(255)) AS [AIAgentOrchWrite],
    CAST([AIAgentOrchestration] AS VARCHAR(255)) AS [AIAgentOrchestration],
    CAST([AIAgent_Uses] AS VARCHAR(255)) AS [AIAgent_Uses],
    CAST([AIAgents] AS VARCHAR(255)) AS [AIAgents]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_AINEXT
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_AINext', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_AINext;
GO
CREATE VIEW Snowflake.Dim_AINext AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AINextLess integrated] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextMore integrated] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextMuch less integrated] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextMuch more integrated] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextNeither different nor similar] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextNo change] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextSomewhat different] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextSomewhat similar] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextVery different] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextVery similar] AS NVARCHAR(MAX)), ''))), 2) AS Dim_AINextID,
    CAST([AINextLess integrated] AS VARCHAR(255)) AS [AINextLess integrated],
    CAST([AINextMore integrated] AS VARCHAR(255)) AS [AINextMore integrated],
    CAST([AINextMuch less integrated] AS VARCHAR(255)) AS [AINextMuch less integrated],
    CAST([AINextMuch more integrated] AS VARCHAR(255)) AS [AINextMuch more integrated],
    CAST([AINextNeither different nor similar] AS VARCHAR(255)) AS [AINextNeither different nor similar],
    CAST([AINextNo change] AS VARCHAR(255)) AS [AINextNo change],
    CAST([AINextSomewhat different] AS VARCHAR(255)) AS [AINextSomewhat different],
    CAST([AINextSomewhat similar] AS VARCHAR(255)) AS [AINextSomewhat similar],
    CAST([AINextVery different] AS VARCHAR(255)) AS [AINextVery different],
    CAST([AINextVery similar] AS VARCHAR(255)) AS [AINextVery similar]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_AIMODELS
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_AIModels', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_AIModels;
GO
CREATE VIEW Snowflake.Dim_AIModels AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AIModelsAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIModelsChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIModelsHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIModelsWantEntry] AS NVARCHAR(MAX)), ''))), 2) AS Dim_AIModelsID,
    CAST([AIModelsAdmired] AS VARCHAR(255)) AS [AIModelsAdmired],
    CAST([AIModelsChoice] AS VARCHAR(255)) AS [AIModelsChoice],
    CAST([AIModelsHaveEntry] AS VARCHAR(255)) AS [AIModelsHaveEntry],
    CAST([AIModelsWantEntry] AS VARCHAR(255)) AS [AIModelsWantEntry]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_AITOOLS
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_AITools', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_AITools;
GO
CREATE VIEW Snowflake.Dim_AITools AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AIToolCurrently Using] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolCurrently mostly AI] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolCurrently partially AI] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolDon't plan to use AI for this task] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolInterested in Using] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolNot interested in Using] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolPlan to mostly use AI] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolPlan to partially use AI] AS NVARCHAR(MAX)), ''))), 2) AS Dim_AIToolsID,
    CAST([AIToolCurrently Using] AS VARCHAR(255)) AS [AIToolCurrently Using],
    CAST([AIToolCurrently mostly AI] AS VARCHAR(255)) AS [AIToolCurrently mostly AI],
    CAST([AIToolCurrently partially AI] AS VARCHAR(255)) AS [AIToolCurrently partially AI],
    CAST([AIToolDon't plan to use AI for this task] AS VARCHAR(255)) AS [AIToolDon't plan to use AI for this task],
    CAST([AIToolInterested in Using] AS VARCHAR(255)) AS [AIToolInterested in Using],
    CAST([AIToolNot interested in Using] AS VARCHAR(255)) AS [AIToolNot interested in Using],
    CAST([AIToolPlan to mostly use AI] AS VARCHAR(255)) AS [AIToolPlan to mostly use AI],
    CAST([AIToolPlan to partially use AI] AS VARCHAR(255)) AS [AIToolPlan to partially use AI]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_AIOPINIONS
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_AIOpinions', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_AIOpinions;
GO
CREATE VIEW Snowflake.Dim_AIOpinions AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AIAcc] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIBen] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIChallenges] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIComplex] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIEthics] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIExplain] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIFrustration] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIHuman] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AILearnHow] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIOpen] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISearchDevAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISearchDevHaveWorkedWith] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISearchDevWantToWorkWith] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISelect] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISent] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIThreat] AS NVARCHAR(MAX)), ''))), 2) AS Dim_AIOpinionsID,
    CAST([AIAcc] AS VARCHAR(255)) AS [AIAcc],
    CAST([AIBen] AS VARCHAR(255)) AS [AIBen],
    CAST([AIChallenges] AS VARCHAR(255)) AS [AIChallenges],
    CAST([AIComplex] AS VARCHAR(255)) AS [AIComplex],
    CAST([AIEthics] AS VARCHAR(255)) AS [AIEthics],
    CAST([AIExplain] AS VARCHAR(255)) AS [AIExplain],
    CAST([AIFrustration] AS VARCHAR(255)) AS [AIFrustration],
    CAST([AIHuman] AS VARCHAR(255)) AS [AIHuman],
    CAST([AILearnHow] AS VARCHAR(255)) AS [AILearnHow],
    CAST([AIOpen] AS VARCHAR(255)) AS [AIOpen],
    CAST([AISearchDevAdmired] AS VARCHAR(255)) AS [AISearchDevAdmired],
    CAST([AISearchDevHaveWorkedWith] AS VARCHAR(255)) AS [AISearchDevHaveWorkedWith],
    CAST([AISearchDevWantToWorkWith] AS VARCHAR(255)) AS [AISearchDevWantToWorkWith],
    CAST([AISelect] AS VARCHAR(255)) AS [AISelect],
    CAST([AISent] AS VARCHAR(255)) AS [AISent],
    CAST([AIThreat] AS VARCHAR(255)) AS [AIThreat]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_TECHDATABASES
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_TechDatabases', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_TechDatabases;
GO
CREATE VIEW Snowflake.Dim_TechDatabases AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([DatabaseAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DatabaseChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DatabaseHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DatabaseWantEntry] AS NVARCHAR(MAX)), ''))), 2) AS Dim_TechDatabasesID,
    CAST([DatabaseAdmired] AS VARCHAR(255)) AS [DatabaseAdmired],
    CAST([DatabaseChoice] AS VARCHAR(255)) AS [DatabaseChoice],
    CAST([DatabaseHaveEntry] AS VARCHAR(255)) AS [DatabaseHaveEntry],
    CAST([DatabaseWantEntry] AS VARCHAR(255)) AS [DatabaseWantEntry]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_TECHPLATFORMS
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_TechPlatforms', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_TechPlatforms;
GO
CREATE VIEW Snowflake.Dim_TechPlatforms AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([OperatingSystem] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OperatingSystem_Personal] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OperatingSystem_Professional] AS NVARCHAR(MAX)), ''), ISNULL(CAST([PlatformAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([PlatformChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([PlatformHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([PlatformWantEntry] AS NVARCHAR(MAX)), ''))), 2) AS Dim_TechPlatformsID,
    CAST([OperatingSystem] AS VARCHAR(255)) AS [OperatingSystem],
    CAST([OperatingSystem_Personal] AS VARCHAR(255)) AS [OperatingSystem_Personal],
    CAST([OperatingSystem_Professional] AS VARCHAR(255)) AS [OperatingSystem_Professional],
    CAST([PlatformAdmired] AS VARCHAR(255)) AS [PlatformAdmired],
    CAST([PlatformChoice] AS VARCHAR(255)) AS [PlatformChoice],
    CAST([PlatformHaveEntry] AS VARCHAR(255)) AS [PlatformHaveEntry],
    CAST([PlatformWantEntry] AS VARCHAR(255)) AS [PlatformWantEntry]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_TECHLANGUAGESWEB
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_TechLanguagesWeb', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_TechLanguagesWeb;
GO
CREATE VIEW Snowflake.Dim_TechLanguagesWeb AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([LanguageAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LanguageChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LanguagesHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LanguagesWantEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([WebframeAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([WebframeChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([WebframeHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([WebframeWantEntry] AS NVARCHAR(MAX)), ''))), 2) AS Dim_TechLanguagesWebID,
    CAST([LanguageAdmired] AS VARCHAR(255)) AS [LanguageAdmired],
    CAST([LanguageChoice] AS VARCHAR(255)) AS [LanguageChoice],
    CAST([LanguagesHaveEntry] AS VARCHAR(255)) AS [LanguagesHaveEntry],
    CAST([LanguagesWantEntry] AS VARCHAR(255)) AS [LanguagesWantEntry],
    CAST([WebframeAdmired] AS VARCHAR(255)) AS [WebframeAdmired],
    CAST([WebframeChoice] AS VARCHAR(255)) AS [WebframeChoice],
    CAST([WebframeHaveEntry] AS VARCHAR(255)) AS [WebframeHaveEntry],
    CAST([WebframeWantEntry] AS VARCHAR(255)) AS [WebframeWantEntry]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_TECHMISCTOOLS
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_TechMiscTools', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_TechMiscTools;
GO
CREATE VIEW Snowflake.Dim_TechMiscTools AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([Blockchain] AS NVARCHAR(MAX)), ''), ISNULL(CAST([BuyNewTool] AS NVARCHAR(MAX)), ''), ISNULL(CAST([CommPlatformAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([CommPlatformHaveEntr] AS NVARCHAR(MAX)), ''), ISNULL(CAST([CommPlatformWantEntr] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DevEnvHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DevEnvWantEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DevEnvsAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DevEnvsChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([EmbeddedAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([MiscTechAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([NEWCollabToolsAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OfficeStackAsyncAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OfficeStackHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OfficeStackSyncAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OfficeStackWantEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ProfessionalTech] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechDoc] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechList] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ToolCountPersonal] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ToolCountWork] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ToolsTechAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([VersionControlSystem] AS NVARCHAR(MAX)), ''))), 2) AS Dim_TechMiscToolsID,
    CAST([Blockchain] AS VARCHAR(255)) AS [Blockchain],
    CAST([BuyNewTool] AS VARCHAR(255)) AS [BuyNewTool],
    CAST([CommPlatformAdmired] AS VARCHAR(255)) AS [CommPlatformAdmired],
    CAST([CommPlatformHaveEntr] AS VARCHAR(255)) AS [CommPlatformHaveEntr],
    CAST([CommPlatformWantEntr] AS VARCHAR(255)) AS [CommPlatformWantEntr],
    CAST([DevEnvHaveEntry] AS VARCHAR(255)) AS [DevEnvHaveEntry],
    CAST([DevEnvWantEntry] AS VARCHAR(255)) AS [DevEnvWantEntry],
    CAST([DevEnvsAdmired] AS VARCHAR(255)) AS [DevEnvsAdmired],
    CAST([DevEnvsChoice] AS VARCHAR(255)) AS [DevEnvsChoice],
    CAST([EmbeddedAdmired] AS VARCHAR(255)) AS [EmbeddedAdmired],
    CAST([MiscTechAdmired] AS VARCHAR(255)) AS [MiscTechAdmired],
    CAST([NEWCollabToolsAdmired] AS VARCHAR(255)) AS [NEWCollabToolsAdmired],
    CAST([OfficeStackAsyncAdmired] AS VARCHAR(255)) AS [OfficeStackAsyncAdmired],
    CAST([OfficeStackHaveEntry] AS VARCHAR(255)) AS [OfficeStackHaveEntry],
    CAST([OfficeStackSyncAdmired] AS VARCHAR(255)) AS [OfficeStackSyncAdmired],
    CAST([OfficeStackWantEntry] AS VARCHAR(255)) AS [OfficeStackWantEntry],
    CAST([ProfessionalTech] AS VARCHAR(255)) AS [ProfessionalTech],
    CAST([TechDoc] AS VARCHAR(255)) AS [TechDoc],
    CAST([TechList] AS VARCHAR(255)) AS [TechList],
    CAST([ToolCountPersonal] AS VARCHAR(255)) AS [ToolCountPersonal],
    CAST([ToolCountWork] AS VARCHAR(255)) AS [ToolCountWork],
    CAST([ToolsTechAdmired] AS VARCHAR(255)) AS [ToolsTechAdmired],
    CAST([VersionControlSystem] AS VARCHAR(255)) AS [VersionControlSystem]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_TECHENDORSE
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_TechEndorse', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_TechEndorse;
GO
CREATE VIEW Snowflake.Dim_TechEndorse AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([TechEndorse] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorseIntro] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_1] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_13] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_13_TEXT] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_2] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_3] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_4] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_5] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_6] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_7] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_8] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_9] AS NVARCHAR(MAX)), ''))), 2) AS Dim_TechEndorseID,
    CAST([TechEndorse] AS VARCHAR(255)) AS [TechEndorse],
    CAST([TechEndorseIntro] AS VARCHAR(255)) AS [TechEndorseIntro],
    CAST([TechEndorse_1] AS VARCHAR(255)) AS [TechEndorse_1],
    CAST([TechEndorse_13] AS VARCHAR(255)) AS [TechEndorse_13],
    CAST([TechEndorse_13_TEXT] AS VARCHAR(255)) AS [TechEndorse_13_TEXT],
    CAST([TechEndorse_2] AS VARCHAR(255)) AS [TechEndorse_2],
    CAST([TechEndorse_3] AS VARCHAR(255)) AS [TechEndorse_3],
    CAST([TechEndorse_4] AS VARCHAR(255)) AS [TechEndorse_4],
    CAST([TechEndorse_5] AS VARCHAR(255)) AS [TechEndorse_5],
    CAST([TechEndorse_6] AS VARCHAR(255)) AS [TechEndorse_6],
    CAST([TechEndorse_7] AS VARCHAR(255)) AS [TechEndorse_7],
    CAST([TechEndorse_8] AS VARCHAR(255)) AS [TechEndorse_8],
    CAST([TechEndorse_9] AS VARCHAR(255)) AS [TechEndorse_9]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_TECHOPPOSE
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_TechOppose', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_TechOppose;
GO
CREATE VIEW Snowflake.Dim_TechOppose AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([TechOppose_1] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_11] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_13] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_15] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_15_TEXT] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_16] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_2] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_3] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_5] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_7] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_9] AS NVARCHAR(MAX)), ''))), 2) AS Dim_TechOpposeID,
    CAST([TechOppose_1] AS VARCHAR(255)) AS [TechOppose_1],
    CAST([TechOppose_11] AS VARCHAR(255)) AS [TechOppose_11],
    CAST([TechOppose_13] AS VARCHAR(255)) AS [TechOppose_13],
    CAST([TechOppose_15] AS VARCHAR(255)) AS [TechOppose_15],
    CAST([TechOppose_15_TEXT] AS VARCHAR(255)) AS [TechOppose_15_TEXT],
    CAST([TechOppose_16] AS VARCHAR(255)) AS [TechOppose_16],
    CAST([TechOppose_2] AS VARCHAR(255)) AS [TechOppose_2],
    CAST([TechOppose_3] AS VARCHAR(255)) AS [TechOppose_3],
    CAST([TechOppose_5] AS VARCHAR(255)) AS [TechOppose_5],
    CAST([TechOppose_7] AS VARCHAR(255)) AS [TechOppose_7],
    CAST([TechOppose_9] AS VARCHAR(255)) AS [TechOppose_9]
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_AICENTRAL (CENTRAL SNOWFLAKE DIMENSION)
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_AICentral', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_AICentral;
GO
CREATE VIEW Snowflake.Dim_AICentral AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AIAgentChallengesNeutral] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChallengesSomewhat agree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChallengesSomewhat disagree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChallengesStrongly agree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChallengesStrongly disagree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChange] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentExtWrite] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentExternal] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactNeutral] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactSomewhat agree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactSomewhat disagree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactStrongly agree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactStrongly disagree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentKnowWrite] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentKnowledge] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentObsWrite] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentObserveSecure] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentOrchWrite] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentOrchestration] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgent_Uses] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgents] AS NVARCHAR(MAX)), ''))), 2), CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AINextLess integrated] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextMore integrated] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextMuch less integrated] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextMuch more integrated] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextNeither different nor similar] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextNo change] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextSomewhat different] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextSomewhat similar] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextVery different] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextVery similar] AS NVARCHAR(MAX)), ''))), 2), CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AIModelsAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIModelsChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIModelsHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIModelsWantEntry] AS NVARCHAR(MAX)), ''))), 2), CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AIToolCurrently Using] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolCurrently mostly AI] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolCurrently partially AI] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolDon't plan to use AI for this task] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolInterested in Using] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolNot interested in Using] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolPlan to mostly use AI] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolPlan to partially use AI] AS NVARCHAR(MAX)), ''))), 2), CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AIAcc] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIBen] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIChallenges] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIComplex] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIEthics] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIExplain] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIFrustration] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIHuman] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AILearnHow] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIOpen] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISearchDevAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISearchDevHaveWorkedWith] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISearchDevWantToWorkWith] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISelect] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISent] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIThreat] AS NVARCHAR(MAX)), ''))), 2))), 2) AS Dim_AICentralID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AIAgentChallengesNeutral] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChallengesSomewhat agree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChallengesSomewhat disagree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChallengesStrongly agree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChallengesStrongly disagree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChange] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentExtWrite] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentExternal] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactNeutral] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactSomewhat agree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactSomewhat disagree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactStrongly agree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactStrongly disagree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentKnowWrite] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentKnowledge] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentObsWrite] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentObserveSecure] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentOrchWrite] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentOrchestration] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgent_Uses] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgents] AS NVARCHAR(MAX)), ''))), 2) AS Dim_AIAgentsID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AINextLess integrated] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextMore integrated] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextMuch less integrated] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextMuch more integrated] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextNeither different nor similar] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextNo change] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextSomewhat different] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextSomewhat similar] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextVery different] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextVery similar] AS NVARCHAR(MAX)), ''))), 2) AS Dim_AINextID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AIModelsAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIModelsChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIModelsHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIModelsWantEntry] AS NVARCHAR(MAX)), ''))), 2) AS Dim_AIModelsID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AIToolCurrently Using] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolCurrently mostly AI] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolCurrently partially AI] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolDon't plan to use AI for this task] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolInterested in Using] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolNot interested in Using] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolPlan to mostly use AI] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolPlan to partially use AI] AS NVARCHAR(MAX)), ''))), 2) AS Dim_AIToolsID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AIAcc] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIBen] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIChallenges] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIComplex] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIEthics] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIExplain] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIFrustration] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIHuman] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AILearnHow] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIOpen] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISearchDevAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISearchDevHaveWorkedWith] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISearchDevWantToWorkWith] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISelect] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISent] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIThreat] AS NVARCHAR(MAX)), ''))), 2) AS Dim_AIOpinionsID
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- DIM_TECHCENTRAL (CENTRAL SNOWFLAKE DIMENSION)
-- ==========================================
IF OBJECT_ID('Snowflake.Dim_TechCentral', 'V') IS NOT NULL DROP VIEW Snowflake.Dim_TechCentral;
GO
CREATE VIEW Snowflake.Dim_TechCentral AS
SELECT DISTINCT
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([DatabaseAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DatabaseChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DatabaseHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DatabaseWantEntry] AS NVARCHAR(MAX)), ''))), 2), CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([OperatingSystem] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OperatingSystem_Personal] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OperatingSystem_Professional] AS NVARCHAR(MAX)), ''), ISNULL(CAST([PlatformAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([PlatformChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([PlatformHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([PlatformWantEntry] AS NVARCHAR(MAX)), ''))), 2), CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([LanguageAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LanguageChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LanguagesHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LanguagesWantEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([WebframeAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([WebframeChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([WebframeHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([WebframeWantEntry] AS NVARCHAR(MAX)), ''))), 2), CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([Blockchain] AS NVARCHAR(MAX)), ''), ISNULL(CAST([BuyNewTool] AS NVARCHAR(MAX)), ''), ISNULL(CAST([CommPlatformAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([CommPlatformHaveEntr] AS NVARCHAR(MAX)), ''), ISNULL(CAST([CommPlatformWantEntr] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DevEnvHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DevEnvWantEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DevEnvsAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DevEnvsChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([EmbeddedAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([MiscTechAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([NEWCollabToolsAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OfficeStackAsyncAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OfficeStackHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OfficeStackSyncAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OfficeStackWantEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ProfessionalTech] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechDoc] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechList] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ToolCountPersonal] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ToolCountWork] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ToolsTechAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([VersionControlSystem] AS NVARCHAR(MAX)), ''))), 2), CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([TechEndorse] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorseIntro] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_1] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_13] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_13_TEXT] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_2] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_3] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_4] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_5] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_6] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_7] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_8] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_9] AS NVARCHAR(MAX)), ''))), 2), CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([TechOppose_1] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_11] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_13] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_15] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_15_TEXT] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_16] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_2] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_3] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_5] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_7] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_9] AS NVARCHAR(MAX)), ''))), 2))), 2) AS Dim_TechCentralID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([DatabaseAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DatabaseChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DatabaseHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DatabaseWantEntry] AS NVARCHAR(MAX)), ''))), 2) AS Dim_TechDatabasesID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([OperatingSystem] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OperatingSystem_Personal] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OperatingSystem_Professional] AS NVARCHAR(MAX)), ''), ISNULL(CAST([PlatformAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([PlatformChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([PlatformHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([PlatformWantEntry] AS NVARCHAR(MAX)), ''))), 2) AS Dim_TechPlatformsID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([LanguageAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LanguageChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LanguagesHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LanguagesWantEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([WebframeAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([WebframeChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([WebframeHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([WebframeWantEntry] AS NVARCHAR(MAX)), ''))), 2) AS Dim_TechLanguagesWebID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([Blockchain] AS NVARCHAR(MAX)), ''), ISNULL(CAST([BuyNewTool] AS NVARCHAR(MAX)), ''), ISNULL(CAST([CommPlatformAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([CommPlatformHaveEntr] AS NVARCHAR(MAX)), ''), ISNULL(CAST([CommPlatformWantEntr] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DevEnvHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DevEnvWantEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DevEnvsAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DevEnvsChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([EmbeddedAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([MiscTechAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([NEWCollabToolsAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OfficeStackAsyncAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OfficeStackHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OfficeStackSyncAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OfficeStackWantEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ProfessionalTech] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechDoc] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechList] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ToolCountPersonal] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ToolCountWork] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ToolsTechAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([VersionControlSystem] AS NVARCHAR(MAX)), ''))), 2) AS Dim_TechMiscToolsID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([TechEndorse] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorseIntro] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_1] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_13] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_13_TEXT] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_2] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_3] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_4] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_5] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_6] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_7] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_8] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_9] AS NVARCHAR(MAX)), ''))), 2) AS Dim_TechEndorseID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([TechOppose_1] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_11] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_13] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_15] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_15_TEXT] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_16] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_2] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_3] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_5] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_7] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_9] AS NVARCHAR(MAX)), ''))), 2) AS Dim_TechOpposeID
FROM Gold.Fact_Survey;
GO

-- ==========================================
-- CORE FACT TABLE (SNOWFLAKE VIEW)
-- ==========================================
IF OBJECT_ID('Snowflake.Fact_Survey_Core', 'V') IS NOT NULL DROP VIEW Snowflake.Fact_Survey_Core;
GO
CREATE VIEW Snowflake.Fact_Survey_Core AS
SELECT 
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), ''))), 2) AS ResponseKey,
    SurveyYear,
    ResponseId,

    -- Foreign Keys to Core Dimensions
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AgeCode] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Gender_Clean] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Ethnicity_Clean] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Sexuality_Clean] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TransGender] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Accessibility_Status] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Mental_Health_Status] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Country] AS NVARCHAR(MAX)), ''), ISNULL(CAST([USA_State] AS NVARCHAR(MAX)), ''))), 2) AS Dim_DemographicsID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([Current_Profession] AS NVARCHAR(MAX)), ''), ISNULL(CAST([EmploymentAddl] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Industry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Organization_Size] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ICorPM] AS NVARCHAR(MAX)), ''), ISNULL(CAST([WorkExp] AS NVARCHAR(MAX)), ''), ISNULL(CAST([RemoteWork] AS NVARCHAR(MAX)), ''))), 2) AS Dim_EmploymentID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([CompTotal] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Compensation_Frequency] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ConvertedCompYearly] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Currency_Code] AS NVARCHAR(MAX)), ''))), 2) AS Dim_CompensationID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([Education_Level] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LearnCodeOnline] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LearnCodeChoose] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LearnCodeCoursesCert] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LearnCodeAI] AS NVARCHAR(MAX)), ''))), 2) AS Dim_EducationID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([JobSat] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_1] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_10] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_11] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_13] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_14] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_15] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_15_TEXT] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_16] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_2] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_3] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_4] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_5] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_6] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_7] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_8] AS NVARCHAR(MAX)), ''), ISNULL(CAST([JobSatPoints_9] AS NVARCHAR(MAX)), ''))), 2) AS Dim_SatisfactionID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([Knowledge_1] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Knowledge_2] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Knowledge_3] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Knowledge_4] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Knowledge_5] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Knowledge_6] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Knowledge_7] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Knowledge_8] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Knowledge_9] AS NVARCHAR(MAX)), ''))), 2) AS Dim_KnowledgeID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([NewStackOverflow_Sites] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SOAI] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SODuration] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SOFriction] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SOHow] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SOTagsAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SOTagsHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SOTagsWant Entry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Dev_Content] AS NVARCHAR(MAX)), ''), ISNULL(CAST([StackOverflow_Account_exists] AS NVARCHAR(MAX)), ''), ISNULL(CAST([StackOverflow_Community_Experience] AS NVARCHAR(MAX)), ''), ISNULL(CAST([StackOverflow_Participation_Frequency] AS NVARCHAR(MAX)), ''), ISNULL(CAST([StackOverflow_Visit_Frequency] AS NVARCHAR(MAX)), ''))), 2) AS Dim_StackOverflowID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([SO_Actions_1] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_10] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_15] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_15_TEXT] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_16] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_3] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_4] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_5] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_6] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_7] AS NVARCHAR(MAX)), ''), ISNULL(CAST([SO_Actions_9] AS NVARCHAR(MAX)), ''))), 2) AS Dim_SOActionsID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AgentUsesGeneral] AS NVARCHAR(MAX)), ''), ISNULL(CAST([BuildvsBuy] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Check] AS NVARCHAR(MAX)), ''), ISNULL(CAST([CodingActivities] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Frequency_1] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Frequency_2] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Frequency_3] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Frustration] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Know_Other_Community] AS NVARCHAR(MAX)), ''), ISNULL(CAST([MainBranch] AS NVARCHAR(MAX)), ''), ISNULL(CAST([NewRole] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Onboarding] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ProfessionalCloud] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ProfessionalQuestion] AS NVARCHAR(MAX)), ''), ISNULL(CAST([PurchaseInfluence] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Q120] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Survey_Ease] AS NVARCHAR(MAX)), ''), ISNULL(CAST([Survey_Length] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TBranch] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TimeAnswering] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TimeSearching] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TrueFalse_1] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TrueFalse_2] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TrueFalse_3] AS NVARCHAR(MAX)), ''), ISNULL(CAST([VCHostingPersonal use] AS NVARCHAR(MAX)), ''), ISNULL(CAST([VCHostingProfessional use] AS NVARCHAR(MAX)), ''), ISNULL(CAST([VCInteraction] AS NVARCHAR(MAX)), ''))), 2) AS Dim_MiscCategoricalID,

    -- Foreign Keys to Central Snowflake Dimensions
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AIAgentChallengesNeutral] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChallengesSomewhat agree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChallengesSomewhat disagree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChallengesStrongly agree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChallengesStrongly disagree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentChange] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentExtWrite] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentExternal] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactNeutral] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactSomewhat agree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactSomewhat disagree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactStrongly agree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentImpactStrongly disagree] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentKnowWrite] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentKnowledge] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentObsWrite] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentObserveSecure] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentOrchWrite] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgentOrchestration] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgent_Uses] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIAgents] AS NVARCHAR(MAX)), ''))), 2), CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AINextLess integrated] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextMore integrated] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextMuch less integrated] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextMuch more integrated] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextNeither different nor similar] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextNo change] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextSomewhat different] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextSomewhat similar] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextVery different] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AINextVery similar] AS NVARCHAR(MAX)), ''))), 2), CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AIModelsAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIModelsChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIModelsHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIModelsWantEntry] AS NVARCHAR(MAX)), ''))), 2), CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AIToolCurrently Using] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolCurrently mostly AI] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolCurrently partially AI] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolDon't plan to use AI for this task] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolInterested in Using] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolNot interested in Using] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolPlan to mostly use AI] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIToolPlan to partially use AI] AS NVARCHAR(MAX)), ''))), 2), CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([AIAcc] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIBen] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIChallenges] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIComplex] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIEthics] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIExplain] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIFrustration] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIHuman] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AILearnHow] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIOpen] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISearchDevAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISearchDevHaveWorkedWith] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISearchDevWantToWorkWith] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISelect] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AISent] AS NVARCHAR(MAX)), ''), ISNULL(CAST([AIThreat] AS NVARCHAR(MAX)), ''))), 2))), 2) AS Dim_AICentralID,
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([DatabaseAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DatabaseChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DatabaseHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DatabaseWantEntry] AS NVARCHAR(MAX)), ''))), 2), CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([OperatingSystem] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OperatingSystem_Personal] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OperatingSystem_Professional] AS NVARCHAR(MAX)), ''), ISNULL(CAST([PlatformAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([PlatformChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([PlatformHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([PlatformWantEntry] AS NVARCHAR(MAX)), ''))), 2), CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([LanguageAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LanguageChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LanguagesHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([LanguagesWantEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([WebframeAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([WebframeChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([WebframeHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([WebframeWantEntry] AS NVARCHAR(MAX)), ''))), 2), CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([Blockchain] AS NVARCHAR(MAX)), ''), ISNULL(CAST([BuyNewTool] AS NVARCHAR(MAX)), ''), ISNULL(CAST([CommPlatformAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([CommPlatformHaveEntr] AS NVARCHAR(MAX)), ''), ISNULL(CAST([CommPlatformWantEntr] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DevEnvHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DevEnvWantEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DevEnvsAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([DevEnvsChoice] AS NVARCHAR(MAX)), ''), ISNULL(CAST([EmbeddedAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([MiscTechAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([NEWCollabToolsAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OfficeStackAsyncAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OfficeStackHaveEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OfficeStackSyncAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([OfficeStackWantEntry] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ProfessionalTech] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechDoc] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechList] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ToolCountPersonal] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ToolCountWork] AS NVARCHAR(MAX)), ''), ISNULL(CAST([ToolsTechAdmired] AS NVARCHAR(MAX)), ''), ISNULL(CAST([VersionControlSystem] AS NVARCHAR(MAX)), ''))), 2), CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([TechEndorse] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorseIntro] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_1] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_13] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_13_TEXT] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_2] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_3] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_4] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_5] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_6] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_7] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_8] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechEndorse_9] AS NVARCHAR(MAX)), ''))), 2), CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT_WS('|', ISNULL(CAST([TechOppose_1] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_11] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_13] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_15] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_15_TEXT] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_16] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_2] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_3] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_5] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_7] AS NVARCHAR(MAX)), ''), ISNULL(CAST([TechOppose_9] AS NVARCHAR(MAX)), ''))), 2))), 2) AS Dim_TechCentralID,

    -- Remaining Numeric Fields (Fact Measures)
    CAST([YearsCode] AS BIGINT) AS [YearsCode],
    CAST([YearsCodePro] AS BIGINT) AS [YearsCodePro]
FROM Gold.Fact_Survey;
GO

