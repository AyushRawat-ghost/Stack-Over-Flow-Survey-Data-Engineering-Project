IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Gold') EXEC('CREATE SCHEMA Gold');
GO

IF OBJECT_ID('Gold.Bridge_AIDevHaveWorkedWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_AIDevHaveWorkedWith_Clean;
IF OBJECT_ID('Gold.Bridge_AIDevWantToWorkWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_AIDevWantToWorkWith_Clean;
IF OBJECT_ID('Gold.Bridge_AIModelsHaveWorkedWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_AIModelsHaveWorkedWith_Clean;
IF OBJECT_ID('Gold.Bridge_AIModelsWantToWorkWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_AIModelsWantToWorkWith_Clean;
IF OBJECT_ID('Gold.Bridge_AISearchHaveWorkedWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_AISearchHaveWorkedWith_Clean;
IF OBJECT_ID('Gold.Bridge_AISearchWantToWorkWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_AISearchWantToWorkWith_Clean;
IF OBJECT_ID('Gold.Bridge_CommPlatformHaveWorkedWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_CommPlatformHaveWorkedWith_Clean;
IF OBJECT_ID('Gold.Bridge_CommPlatformWantToWorkWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_CommPlatformWantToWorkWith_Clean;
IF OBJECT_ID('Gold.Bridge_DatabaseHaveWorkedWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_DatabaseHaveWorkedWith_Clean;
IF OBJECT_ID('Gold.Bridge_DatabaseWantToWorkWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_DatabaseWantToWorkWith_Clean;
IF OBJECT_ID('Gold.Bridge_DevEnvsHaveWorkedWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_DevEnvsHaveWorkedWith_Clean;
IF OBJECT_ID('Gold.Bridge_DevEnvsWantToWorkWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_DevEnvsWantToWorkWith_Clean;
IF OBJECT_ID('Gold.Bridge_DevType_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_DevType_Clean;
IF OBJECT_ID('Gold.Bridge_EmbeddedHaveWorkedWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_EmbeddedHaveWorkedWith_Clean;
IF OBJECT_ID('Gold.Bridge_EmbeddedWantToWorkWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_EmbeddedWantToWorkWith_Clean;
IF OBJECT_ID('Gold.Bridge_LanguageHaveWorkedWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_LanguageHaveWorkedWith_Clean;
IF OBJECT_ID('Gold.Bridge_LanguageWantToWorkWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_LanguageWantToWorkWith_Clean;
IF OBJECT_ID('Gold.Bridge_LearnCode_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_LearnCode_Clean;
IF OBJECT_ID('Gold.Bridge_MiscTechHaveWorkedWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_MiscTechHaveWorkedWith_Clean;
IF OBJECT_ID('Gold.Bridge_MiscTechWantToWorkWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_MiscTechWantToWorkWith_Clean;
IF OBJECT_ID('Gold.Bridge_NEWCollabToolsHaveWorkedWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_NEWCollabToolsHaveWorkedWith_Clean;
IF OBJECT_ID('Gold.Bridge_NEWCollabToolsWantToWorkWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_NEWCollabToolsWantToWorkWith_Clean;
IF OBJECT_ID('Gold.Bridge_NEWStuck_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_NEWStuck_Clean;
IF OBJECT_ID('Gold.Bridge_OfficeStackAsyncHaveWorkedWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_OfficeStackAsyncHaveWorkedWith_Clean;
IF OBJECT_ID('Gold.Bridge_OfficeStackAsyncWantToWorkWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_OfficeStackAsyncWantToWorkWith_Clean;
IF OBJECT_ID('Gold.Bridge_OfficeStackSyncHaveWorkedWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_OfficeStackSyncHaveWorkedWith_Clean;
IF OBJECT_ID('Gold.Bridge_OfficeStackSyncWantToWorkWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_OfficeStackSyncWantToWorkWith_Clean;
IF OBJECT_ID('Gold.Bridge_PlatformHaveWorkedWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_PlatformHaveWorkedWith_Clean;
IF OBJECT_ID('Gold.Bridge_PlatformWantToWorkWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_PlatformWantToWorkWith_Clean;
IF OBJECT_ID('Gold.Bridge_SOTagsHaveWorkedWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_SOTagsHaveWorkedWith_Clean;
IF OBJECT_ID('Gold.Bridge_SOTagsWantToWorkWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_SOTagsWantToWorkWith_Clean;
IF OBJECT_ID('Gold.Bridge_ToolsTechHaveWorkedWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_ToolsTechHaveWorkedWith_Clean;
IF OBJECT_ID('Gold.Bridge_ToolsTechWantToWorkWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_ToolsTechWantToWorkWith_Clean;
IF OBJECT_ID('Gold.Bridge_WebframeHaveWorkedWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_WebframeHaveWorkedWith_Clean;
IF OBJECT_ID('Gold.Bridge_WebframeWantToWorkWith_Clean', 'U') IS NOT NULL DROP TABLE Gold.Bridge_WebframeWantToWorkWith_Clean;
GO

IF OBJECT_ID('Gold.Fact_Survey', 'U') IS NOT NULL DROP TABLE Gold.Fact_Survey;
GO

CREATE TABLE Gold.Fact_Survey (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [AIAcc] VARCHAR(MAX) NULL,
    [AIAgentChallengesNeutral] VARCHAR(MAX) NULL,
    [AIAgentChallengesSomewhat agree] VARCHAR(MAX) NULL,
    [AIAgentChallengesSomewhat disagree] VARCHAR(MAX) NULL,
    [AIAgentChallengesStrongly agree] VARCHAR(MAX) NULL,
    [AIAgentChallengesStrongly disagree] VARCHAR(MAX) NULL,
    [AIAgentChange] VARCHAR(MAX) NULL,
    [AIAgentExtWrite] VARCHAR(MAX) NULL,
    [AIAgentExternal] VARCHAR(MAX) NULL,
    [AIAgentImpactNeutral] VARCHAR(MAX) NULL,
    [AIAgentImpactSomewhat agree] VARCHAR(MAX) NULL,
    [AIAgentImpactSomewhat disagree] VARCHAR(MAX) NULL,
    [AIAgentImpactStrongly agree] VARCHAR(MAX) NULL,
    [AIAgentImpactStrongly disagree] VARCHAR(MAX) NULL,
    [AIAgentKnowWrite] VARCHAR(MAX) NULL,
    [AIAgentKnowledge] VARCHAR(MAX) NULL,
    [AIAgentObsWrite] VARCHAR(MAX) NULL,
    [AIAgentObserveSecure] VARCHAR(MAX) NULL,
    [AIAgentOrchWrite] VARCHAR(MAX) NULL,
    [AIAgentOrchestration] VARCHAR(MAX) NULL,
    [AIAgent_Uses] VARCHAR(MAX) NULL,
    [AIAgents] VARCHAR(MAX) NULL,
    [AIBen] VARCHAR(MAX) NULL,
    [AIChallenges] VARCHAR(MAX) NULL,
    [AIComplex] VARCHAR(MAX) NULL,
    [AIEthics] VARCHAR(MAX) NULL,
    [AIExplain] VARCHAR(MAX) NULL,
    [AIFrustration] VARCHAR(MAX) NULL,
    [AIHuman] VARCHAR(MAX) NULL,
    [AILearnHow] VARCHAR(MAX) NULL,
    [AIModelsAdmired] VARCHAR(MAX) NULL,
    [AIModelsChoice] VARCHAR(MAX) NULL,
    [AIModelsHaveEntry] VARCHAR(MAX) NULL,
    [AIModelsWantEntry] VARCHAR(MAX) NULL,
    [AINextLess integrated] VARCHAR(MAX) NULL,
    [AINextMore integrated] VARCHAR(MAX) NULL,
    [AINextMuch less integrated] VARCHAR(MAX) NULL,
    [AINextMuch more integrated] VARCHAR(MAX) NULL,
    [AINextNeither different nor similar] VARCHAR(MAX) NULL,
    [AINextNo change] VARCHAR(MAX) NULL,
    [AINextSomewhat different] VARCHAR(MAX) NULL,
    [AINextSomewhat similar] VARCHAR(MAX) NULL,
    [AINextVery different] VARCHAR(MAX) NULL,
    [AINextVery similar] VARCHAR(MAX) NULL,
    [AIOpen] VARCHAR(MAX) NULL,
    [AISearchDevAdmired] VARCHAR(MAX) NULL,
    [AISearchDevHaveWorkedWith] VARCHAR(MAX) NULL,
    [AISearchDevWantToWorkWith] VARCHAR(MAX) NULL,
    [AISelect] VARCHAR(MAX) NULL,
    [AISent] VARCHAR(MAX) NULL,
    [AIThreat] VARCHAR(MAX) NULL,
    [AIToolCurrently Using] VARCHAR(MAX) NULL,
    [AIToolCurrently mostly AI] VARCHAR(MAX) NULL,
    [AIToolCurrently partially AI] VARCHAR(MAX) NULL,
    [AIToolDon't plan to use AI for this task] VARCHAR(MAX) NULL,
    [AIToolInterested in Using] VARCHAR(MAX) NULL,
    [AIToolNot interested in Using] VARCHAR(MAX) NULL,
    [AIToolPlan to mostly use AI] VARCHAR(MAX) NULL,
    [AIToolPlan to partially use AI] VARCHAR(MAX) NULL,
    [Accessibility_Status] VARCHAR(MAX) NULL,
    [AgeCode] VARCHAR(MAX) NULL,
    [AgentUsesGeneral] VARCHAR(MAX) NULL,
    [Blockchain] VARCHAR(MAX) NULL,
    [BuildvsBuy] VARCHAR(MAX) NULL,
    [BuyNewTool] VARCHAR(MAX) NULL,
    [Check] VARCHAR(MAX) NULL,
    [CodingActivities] VARCHAR(MAX) NULL,
    [CommPlatformAdmired] VARCHAR(MAX) NULL,
    [CommPlatformHaveEntr] VARCHAR(MAX) NULL,
    [CommPlatformWantEntr] VARCHAR(MAX) NULL,
    [CompTotal] FLOAT NULL,
    [Compensation_Frequency] VARCHAR(MAX) NULL,
    [ConvertedCompYearly] FLOAT NULL,
    [Country] VARCHAR(MAX) NULL,
    [Currency_Code] VARCHAR(MAX) NULL,
    [Current_Profession] VARCHAR(MAX) NULL,
    [DatabaseAdmired] VARCHAR(MAX) NULL,
    [DatabaseChoice] VARCHAR(MAX) NULL,
    [DatabaseHaveEntry] VARCHAR(MAX) NULL,
    [DatabaseWantEntry] VARCHAR(MAX) NULL,
    [DevEnvHaveEntry] VARCHAR(MAX) NULL,
    [DevEnvWantEntry] VARCHAR(MAX) NULL,
    [DevEnvsAdmired] VARCHAR(MAX) NULL,
    [DevEnvsChoice] VARCHAR(MAX) NULL,
    [Education_Level] VARCHAR(MAX) NULL,
    [EmbeddedAdmired] VARCHAR(MAX) NULL,
    [EmploymentAddl] VARCHAR(MAX) NULL,
    [Ethnicity_Clean] VARCHAR(MAX) NULL,
    [Frequency_1] VARCHAR(MAX) NULL,
    [Frequency_2] VARCHAR(MAX) NULL,
    [Frequency_3] VARCHAR(MAX) NULL,
    [Frustration] VARCHAR(MAX) NULL,
    [Gender_Clean] VARCHAR(MAX) NULL,
    [ICorPM] VARCHAR(MAX) NULL,
    [Industry] VARCHAR(MAX) NULL,
    [JobSat] VARCHAR(MAX) NULL,
    [JobSatPoints_1] VARCHAR(MAX) NULL,
    [JobSatPoints_10] VARCHAR(MAX) NULL,
    [JobSatPoints_11] VARCHAR(MAX) NULL,
    [JobSatPoints_13] VARCHAR(MAX) NULL,
    [JobSatPoints_14] VARCHAR(MAX) NULL,
    [JobSatPoints_15] VARCHAR(MAX) NULL,
    [JobSatPoints_15_TEXT] VARCHAR(MAX) NULL,
    [JobSatPoints_16] VARCHAR(MAX) NULL,
    [JobSatPoints_2] VARCHAR(MAX) NULL,
    [JobSatPoints_3] VARCHAR(MAX) NULL,
    [JobSatPoints_4] VARCHAR(MAX) NULL,
    [JobSatPoints_5] VARCHAR(MAX) NULL,
    [JobSatPoints_6] VARCHAR(MAX) NULL,
    [JobSatPoints_7] VARCHAR(MAX) NULL,
    [JobSatPoints_8] VARCHAR(MAX) NULL,
    [JobSatPoints_9] VARCHAR(MAX) NULL,
    [Know_Other_Community] VARCHAR(MAX) NULL,
    [Knowledge_1] VARCHAR(MAX) NULL,
    [Knowledge_2] VARCHAR(MAX) NULL,
    [Knowledge_3] VARCHAR(MAX) NULL,
    [Knowledge_4] VARCHAR(MAX) NULL,
    [Knowledge_5] VARCHAR(MAX) NULL,
    [Knowledge_6] VARCHAR(MAX) NULL,
    [Knowledge_7] VARCHAR(MAX) NULL,
    [Knowledge_8] VARCHAR(MAX) NULL,
    [Knowledge_9] VARCHAR(MAX) NULL,
    [LanguageAdmired] VARCHAR(MAX) NULL,
    [LanguageChoice] VARCHAR(MAX) NULL,
    [LanguagesHaveEntry] VARCHAR(MAX) NULL,
    [LanguagesWantEntry] VARCHAR(MAX) NULL,
    [LearnCodeAI] VARCHAR(MAX) NULL,
    [LearnCodeChoose] VARCHAR(MAX) NULL,
    [LearnCodeCoursesCert] VARCHAR(MAX) NULL,
    [LearnCodeOnline] VARCHAR(MAX) NULL,
    [MainBranch] VARCHAR(MAX) NULL,
    [Mental_Health_Status] VARCHAR(MAX) NULL,
    [MiscTechAdmired] VARCHAR(MAX) NULL,
    [NEWCollabToolsAdmired] VARCHAR(MAX) NULL,
    [NewRole] VARCHAR(MAX) NULL,
    [NewStackOverflow_Sites] VARCHAR(MAX) NULL,
    [OfficeStackAsyncAdmired] VARCHAR(MAX) NULL,
    [OfficeStackHaveEntry] VARCHAR(MAX) NULL,
    [OfficeStackSyncAdmired] VARCHAR(MAX) NULL,
    [OfficeStackWantEntry] VARCHAR(MAX) NULL,
    [Onboarding] VARCHAR(MAX) NULL,
    [OperatingSystem] VARCHAR(MAX) NULL,
    [OperatingSystem_Personal] VARCHAR(MAX) NULL,
    [OperatingSystem_Professional] VARCHAR(MAX) NULL,
    [Organization_Size] VARCHAR(MAX) NULL,
    [PlatformAdmired] VARCHAR(MAX) NULL,
    [PlatformChoice] VARCHAR(MAX) NULL,
    [PlatformHaveEntry] VARCHAR(MAX) NULL,
    [PlatformWantEntry] VARCHAR(MAX) NULL,
    [ProfessionalCloud] VARCHAR(MAX) NULL,
    [ProfessionalQuestion] VARCHAR(MAX) NULL,
    [ProfessionalTech] VARCHAR(MAX) NULL,
    [PurchaseInfluence] VARCHAR(MAX) NULL,
    [Q120] VARCHAR(MAX) NULL,
    [RemoteWork] VARCHAR(MAX) NULL,
    [SOAI] VARCHAR(MAX) NULL,
    [SODuration] VARCHAR(MAX) NULL,
    [SOFriction] VARCHAR(MAX) NULL,
    [SOHow] VARCHAR(MAX) NULL,
    [SOTagsAdmired] VARCHAR(MAX) NULL,
    [SOTagsHaveEntry] VARCHAR(MAX) NULL,
    [SOTagsWant Entry] VARCHAR(MAX) NULL,
    [SO_Actions_1] VARCHAR(MAX) NULL,
    [SO_Actions_10] VARCHAR(MAX) NULL,
    [SO_Actions_15] VARCHAR(MAX) NULL,
    [SO_Actions_15_TEXT] VARCHAR(MAX) NULL,
    [SO_Actions_16] VARCHAR(MAX) NULL,
    [SO_Actions_3] VARCHAR(MAX) NULL,
    [SO_Actions_4] VARCHAR(MAX) NULL,
    [SO_Actions_5] VARCHAR(MAX) NULL,
    [SO_Actions_6] VARCHAR(MAX) NULL,
    [SO_Actions_7] VARCHAR(MAX) NULL,
    [SO_Actions_9] VARCHAR(MAX) NULL,
    [SO_Dev_Content] VARCHAR(MAX) NULL,
    [Sexuality_Clean] VARCHAR(MAX) NULL,
    [StackOverflow_Account_exists] VARCHAR(MAX) NULL,
    [StackOverflow_Community_Experience] VARCHAR(MAX) NULL,
    [StackOverflow_Participation_Frequency] VARCHAR(MAX) NULL,
    [StackOverflow_Visit_Frequency] VARCHAR(MAX) NULL,
    [Survey_Ease] VARCHAR(MAX) NULL,
    [Survey_Length] VARCHAR(MAX) NULL,
    [TBranch] VARCHAR(MAX) NULL,
    [TechDoc] VARCHAR(MAX) NULL,
    [TechEndorse] VARCHAR(MAX) NULL,
    [TechEndorseIntro] VARCHAR(MAX) NULL,
    [TechEndorse_1] VARCHAR(MAX) NULL,
    [TechEndorse_13] VARCHAR(MAX) NULL,
    [TechEndorse_13_TEXT] VARCHAR(MAX) NULL,
    [TechEndorse_2] VARCHAR(MAX) NULL,
    [TechEndorse_3] VARCHAR(MAX) NULL,
    [TechEndorse_4] VARCHAR(MAX) NULL,
    [TechEndorse_5] VARCHAR(MAX) NULL,
    [TechEndorse_6] VARCHAR(MAX) NULL,
    [TechEndorse_7] VARCHAR(MAX) NULL,
    [TechEndorse_8] VARCHAR(MAX) NULL,
    [TechEndorse_9] VARCHAR(MAX) NULL,
    [TechList] VARCHAR(MAX) NULL,
    [TechOppose_1] VARCHAR(MAX) NULL,
    [TechOppose_11] VARCHAR(MAX) NULL,
    [TechOppose_13] VARCHAR(MAX) NULL,
    [TechOppose_15] VARCHAR(MAX) NULL,
    [TechOppose_15_TEXT] VARCHAR(MAX) NULL,
    [TechOppose_16] VARCHAR(MAX) NULL,
    [TechOppose_2] VARCHAR(MAX) NULL,
    [TechOppose_3] VARCHAR(MAX) NULL,
    [TechOppose_5] VARCHAR(MAX) NULL,
    [TechOppose_7] VARCHAR(MAX) NULL,
    [TechOppose_9] VARCHAR(MAX) NULL,
    [TimeAnswering] VARCHAR(MAX) NULL,
    [TimeSearching] VARCHAR(MAX) NULL,
    [ToolCountPersonal] VARCHAR(MAX) NULL,
    [ToolCountWork] VARCHAR(MAX) NULL,
    [ToolsTechAdmired] VARCHAR(MAX) NULL,
    [TransGender] VARCHAR(MAX) NULL,
    [TrueFalse_1] VARCHAR(MAX) NULL,
    [TrueFalse_2] VARCHAR(MAX) NULL,
    [TrueFalse_3] VARCHAR(MAX) NULL,
    [USA_State] VARCHAR(MAX) NULL,
    [VCHostingPersonal use] VARCHAR(MAX) NULL,
    [VCHostingProfessional use] VARCHAR(MAX) NULL,
    [VCInteraction] VARCHAR(MAX) NULL,
    [VersionControlSystem] VARCHAR(MAX) NULL,
    [WebframeAdmired] VARCHAR(MAX) NULL,
    [WebframeChoice] VARCHAR(MAX) NULL,
    [WebframeHaveEntry] VARCHAR(MAX) NULL,
    [WebframeWantEntry] VARCHAR(MAX) NULL,
    [WorkExp] VARCHAR(MAX) NULL,
    [YearsCode] BIGINT NULL,
    [YearsCodePro] BIGINT NULL,
    PRIMARY KEY (SurveyYear, ResponseId)
);
GO

CREATE TABLE Gold.Bridge_AIDevHaveWorkedWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [AIDevHaveWorkedWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [AIDevHaveWorkedWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_AIDevWantToWorkWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [AIDevWantToWorkWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [AIDevWantToWorkWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_AIModelsHaveWorkedWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [AIModelsHaveWorkedWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [AIModelsHaveWorkedWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_AIModelsWantToWorkWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [AIModelsWantToWorkWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [AIModelsWantToWorkWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_AISearchHaveWorkedWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [AISearchHaveWorkedWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [AISearchHaveWorkedWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_AISearchWantToWorkWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [AISearchWantToWorkWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [AISearchWantToWorkWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_CommPlatformHaveWorkedWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [CommPlatformHaveWorkedWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [CommPlatformHaveWorkedWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_CommPlatformWantToWorkWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [CommPlatformWantToWorkWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [CommPlatformWantToWorkWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_DatabaseHaveWorkedWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [DatabaseHaveWorkedWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [DatabaseHaveWorkedWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_DatabaseWantToWorkWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [DatabaseWantToWorkWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [DatabaseWantToWorkWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_DevEnvsHaveWorkedWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [DevEnvsHaveWorkedWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [DevEnvsHaveWorkedWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_DevEnvsWantToWorkWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [DevEnvsWantToWorkWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [DevEnvsWantToWorkWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_DevType_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [DevType_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [DevType_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_EmbeddedHaveWorkedWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [EmbeddedHaveWorkedWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [EmbeddedHaveWorkedWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_EmbeddedWantToWorkWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [EmbeddedWantToWorkWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [EmbeddedWantToWorkWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_LanguageHaveWorkedWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [LanguageHaveWorkedWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [LanguageHaveWorkedWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_LanguageWantToWorkWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [LanguageWantToWorkWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [LanguageWantToWorkWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_LearnCode_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [LearnCode_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [LearnCode_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_MiscTechHaveWorkedWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [MiscTechHaveWorkedWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [MiscTechHaveWorkedWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_MiscTechWantToWorkWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [MiscTechWantToWorkWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [MiscTechWantToWorkWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_NEWCollabToolsHaveWorkedWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [NEWCollabToolsHaveWorkedWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [NEWCollabToolsHaveWorkedWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_NEWCollabToolsWantToWorkWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [NEWCollabToolsWantToWorkWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [NEWCollabToolsWantToWorkWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_NEWStuck_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [NEWStuck_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [NEWStuck_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_OfficeStackAsyncHaveWorkedWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [OfficeStackAsyncHaveWorkedWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [OfficeStackAsyncHaveWorkedWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_OfficeStackAsyncWantToWorkWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [OfficeStackAsyncWantToWorkWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [OfficeStackAsyncWantToWorkWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_OfficeStackSyncHaveWorkedWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [OfficeStackSyncHaveWorkedWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [OfficeStackSyncHaveWorkedWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_OfficeStackSyncWantToWorkWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [OfficeStackSyncWantToWorkWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [OfficeStackSyncWantToWorkWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_PlatformHaveWorkedWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [PlatformHaveWorkedWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [PlatformHaveWorkedWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_PlatformWantToWorkWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [PlatformWantToWorkWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [PlatformWantToWorkWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_SOTagsHaveWorkedWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [SOTagsHaveWorkedWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [SOTagsHaveWorkedWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_SOTagsWantToWorkWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [SOTagsWantToWorkWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [SOTagsWantToWorkWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_ToolsTechHaveWorkedWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [ToolsTechHaveWorkedWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [ToolsTechHaveWorkedWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_ToolsTechWantToWorkWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [ToolsTechWantToWorkWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [ToolsTechWantToWorkWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_WebframeHaveWorkedWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [WebframeHaveWorkedWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [WebframeHaveWorkedWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO

CREATE TABLE Gold.Bridge_WebframeWantToWorkWith_Clean (
    SurveyYear DATETIME NOT NULL,
    ResponseId VARCHAR(50) NOT NULL,
    [WebframeWantToWorkWith_Clean] VARCHAR(255) NOT NULL,
    PRIMARY KEY (SurveyYear, ResponseId, [WebframeWantToWorkWith_Clean]),
    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE
);
GO
