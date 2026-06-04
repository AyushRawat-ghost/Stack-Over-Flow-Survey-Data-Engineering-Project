# Gold Layer ER Schema Diagram

Here is the Entity Relationship (ER) diagram for reference:

![Gold Layer ER Diagram](Er%20Diagram.png)

flowchart TD
%% Styling Definitions
classDef factLayer fill:#ffccd5,stroke:#ff4d6d,stroke-width:2px,color:#1c1c1c,font-weight:bold;
classDef primaryDim fill:#dbeafe,stroke:#2563eb,stroke-width:1px,color:#1c1c1c;
classDef hubDim fill:#f3e8ff,stroke:#7c3aed,stroke-width:2px,color:#1c1c1c,font-weight:bold;
classDef subDim fill:#dcfce7,stroke:#16a34a,stroke-width:1px,color:#1c1c1c;
classDef bridgeLayer fill:#fef08a,stroke:#eab308,stroke-width:1px,color:#1c1c1c;

    %% Central Fact Table
    Fact_Survey_Core["Fact_Survey_Core (Fact Layer)
    ---
    varchar ResponseKey PK
    bigint SurveyYear
    bigint ResponseId
    varchar Dim_DemographicsID FK
    varchar Dim_EmploymentID FK
    varchar Dim_CompensationID FK
    varchar Dim_EducationID FK
    varchar Dim_SatisfactionID FK
    varchar Dim_KnowledgeID FK
    varchar Dim_StackOverflowID FK
    varchar Dim_SOActionsID FK
    varchar Dim_MiscCategoricalID FK
    varchar Dim_AICentralID FK
    varchar Dim_TechCentralID FK
    bigint YearsCode
    bigint YearsCodePro"]:::factLayer

    %% Primary Dimensions Block
    subgraph Primary_Dims ["Primary Dimensions Layer"]
        Dim_Demographics["Dim_Demographics\n---\nDim_DemographicsID PK\nAgeCode\nGender_Clean\nEthnicity_Clean\nSexuality_Clean\nTransGender\nAccessibility_Status\nMental_Health_Status\nCountry\nUSA_State"]:::primaryDim
        Dim_Employment["Dim_Employment\n---\nDim_EmploymentID PK\nCurrent_Profession\nEmploymentAddl\nIndustry\nOrganization_Size\nICorPM\nWorkExp\nRemoteWork"]:::primaryDim
        Dim_Compensation["Dim_Compensation\n---\nDim_CompensationID PK\nCompTotal\nCompensation_Frequency\nConvertedCompYearly\nCurrency_Code"]:::primaryDim
        Dim_Education["Dim_Education\n---\nDim_EducationID PK\nEducation_Level\nLearnCodeOnline\nLearnCodeChoose\nLearnCodeCoursesCert\nLearnCodeAI"]:::primaryDim
        Dim_Satisfaction["Dim_Satisfaction\n---\nDim_SatisfactionID PK\nJobSat\nJobSatPoints_1\nJobSatPoints_2..16\nJobSatPoints_15_TEXT"]:::primaryDim
        Dim_Knowledge["Dim_Knowledge\n---\nDim_KnowledgeID PK\nKnowledge_1...9"]:::primaryDim
        Dim_StackOverflow["Dim_StackOverflow\n---\nDim_StackOverflowID PK\nNewStackOverflow_Sites\nSOAI\nSODuration\nSOFriction\nSOHow\nSOTagsAdmired\nSOTagsHaveEntry\nSOTagsWant Entry\nSO_Dev_Content\nStackOverflow_Account_exists\nStackOverflow_Community_Experience\nStackOverflow_Participation_Frequency\nStackOverflow_Visit_Frequency"]:::primaryDim
        Dim_SOActions["Dim_SOActions\n---\nDim_SOActionsID PK\nSO_Actions_1...16\nSO_Actions_15_TEXT"]:::primaryDim
        Dim_MiscCategorical["Dim_MiscCategorical\n---\nDim_MiscCategoricalID PK\nAgentUsesGeneral\nBuildvsBuy\nCheck\nCodingActivities\nFrequency_1..3\nFrustration\nKnow_Other_Community\nMainBranch\nNewRole\nOnboarding\nProfessionalCloud\nProfessionalQuestion\nPurchaseInfluence\nQ120\nSurvey_Ease\nSurvey_Length\nTBranch\nTimeAnswering\nTimeSearching\nTrueFalse_1..3\nVCHostingPersonal use\nVCHostingProfessional use\nVCInteraction"]:::primaryDim
    end

    %% Snowflake Central Hubs Block
    subgraph Central_Hubs ["Snowflake Hierarchy Hubs"]
        Dim_AICentral["Dim_AICentral (AI Hub)\n---\nDim_AICentralID PK\nDim_AIAgentsID FK\nDim_AINextID FK\nDim_AIModelsID FK\nDim_AIToolsID FK\nDim_AIOpinionsID FK"]:::hubDim
        Dim_TechCentral["Dim_TechCentral (Tech Hub)\n---\nDim_TechCentralID PK\nDim_TechDatabasesID FK\nDim_TechPlatformsID FK\nDim_TechLanguagesWebID FK\nDim_TechMiscToolsID FK\nDim_TechEndorseID FK\nDim_TechOpposeID FK"]:::hubDim
    end

    %% Nested AI Sub-Dimensions
    subgraph AI_Sub_Dims ["AI Granular Sub-Dimensions"]
        Dim_AIAgents["Dim_AIAgents\n---\nDim_AIAgentsID PK\nAIAgentChallengesNeutral\nAIAgentChallengesSomewhat agree/disagree\nAIAgentChallengesStrongly agree/disagree\nAIAgentChange\nAIAgentExtWrite\nAIAgentExternal\nAIAgentImpactNeutral\nAIAgentImpactSomewhat agree/disagree\nAIAgentImpactStrongly agree/disagree\nAIAgentKnowWrite\nAIAgentKnowledge\nAIAgentObsWrite\nAIAgentObserveSecure\nAIAgentOrchWrite\nAIAgentOrchestration\nAIAgent_Uses\nAIAgents"]:::subDim
        Dim_AINext["Dim_AINext\n---\nDim_AINextID PK\nAINextLess/More integrated\nAINextMuch less/more integrated\nAINextNeither different nor similar\nAINextNo change\nAINextSomewhat different/similar\nAINextVery different/similar"]:::subDim
        Dim_AIModels["Dim_AIModels\n---\nDim_AIModelsID PK\nAIModelsAdmired\nAIModelsChoice\nAIModelsHaveEntry\nAIModelsWantEntry"]:::subDim
        Dim_AITools["Dim_AITools\n---\nDim_AIToolsID PK\nAIToolCurrently Using\nAIToolCurrently mostly/partially AI\nAIToolDon't plan to use AI for this task\nAIToolInterested in Using\nAIToolNot interested in Using\nAIToolPlan to mostly/partially use AI"]:::subDim
        Dim_AIOpinions["Dim_AIOpinions\n---\nDim_AIOpinionsID PK\nAIAcc\nAIBen\nAIChallenges\nAIComplex\nAIEthics\nAIExplain\nAIFrustration\nAIHuman\nAILearnHow\nAIOpen\nAISearchDevAdmired\nAISearchDevHaveWorkedWith\nAISearchDevWantToWorkWith\nAISelect\nAISent\nAIThreat"]:::subDim
    end

    %% Nested Tech Sub-Dimensions
    subgraph Tech_Sub_Dims ["Tech Granular Sub-Dimensions"]
        Dim_TechDatabases["Dim_TechDatabases\n---\nDim_TechDatabasesID PK\nDatabaseAdmired\nDatabaseChoice\nDatabaseHaveEntry\nDatabaseWantEntry"]:::subDim
        Dim_TechPlatforms["Dim_TechPlatforms\n---\nDim_TechPlatformsID PK\nOperatingSystem\nOperatingSystem_Personal\nOperatingSystem_Professional\nPlatformAdmired\nPlatformChoice\nPlatformHaveEntry\nPlatformWantEntry"]:::subDim
        Dim_TechLanguagesWeb["Dim_TechLanguagesWeb\n---\nDim_TechLanguagesWebID PK\nLanguageAdmired\nLanguageChoice\nLanguagesHaveEntry\nLanguagesWantEntry\nWebframeAdmired\nWebframeChoice\nWebframeHaveEntry\nWebframeWantEntry"]:::subDim
        Dim_TechMiscTools["Dim_TechMiscTools\n---\nDim_TechMiscToolsID PK\nBlockchain\nBuyNewTool\nCommPlatformAdmired\nCommPlatformHaveEntr\nCommPlatformWantEntr\nDevEnvHaveEntry/WantEntry\nDevEnvsAdmired/Choice\nEmbeddedAdmired\nMiscTechAdmired\nNEWCollabToolsAdmired\nOfficeStackAsyncAdmired\nOfficeStackHaveEntry\nOfficeStackSyncAdmired/WantEntry\nProfessionalTech\nTechDoc\nTechList\nToolCountPersonal/Work\nToolsTechAdmired\nVersionControlSystem"]:::subDim
        Dim_TechEndorse["Dim_TechEndorse\n---\nDim_TechEndorseID PK\nTechEndorse\nTechEndorseIntro\nTechEndorse_1...9\nTechEndorse_13_TEXT"]:::subDim
        Dim_TechOppose["Dim_TechOppose\n---\nDim_TechOpposeID PK\nTechOppose_1...16\nTechOppose_15_TEXT"]:::subDim
    end

    %% Bridge Tables Block (Many-To-Many Mappings)
    subgraph AI_Bridges ["AI Multivalued Mappings (Many-to-Many)"]
        B_AIDevHW["Bridge_AIDevHaveWorkedWith_Clean\n---\nResponseKey FK\nAIDevHaveWorkedWith_Clean"]:::bridgeLayer
        B_AIDevWW["Bridge_AIDevWantToWorkWith_Clean\n---\nResponseKey FK\nAIDevWantToWorkWith_Clean"]:::bridgeLayer
        B_AIModHW["Bridge_AIModelsHaveWorkedWith_Clean\n---\nResponseKey FK\nAIModelsHaveWorkedWith_Clean"]:::bridgeLayer
        B_AIModWW["Bridge_AIModelsWantToWorkWith_Clean\n---\nResponseKey FK\nAIModelsWantToWorkWith_Clean"]:::bridgeLayer
        B_AISrcHW["Bridge_AISearchHaveWorkedWith_Clean\n---\nResponseKey FK\nAISearchHaveWorkedWith_Clean"]:::bridgeLayer
        B_AISrcWW["Bridge_AISearchWantToWorkWith_Clean\n---\nResponseKey FK\nAISearchWantToWorkWith_Clean"]:::bridgeLayer
    end

    subgraph Tech_Stack_Bridges ["Core Tech Array Mappings (Many-to-Many)"]
        B_DbHW["Bridge_DatabaseHaveWorkedWith_Clean\n---\nResponseKey FK\nDatabaseHaveWorkedWith_Clean"]:::bridgeLayer
        B_DbWW["Bridge_DatabaseWantToWorkWith_Clean\n---\nResponseKey FK\nDatabaseWantToWorkWith_Clean"]:::bridgeLayer
        B_LangHW["Bridge_LanguageHaveWorkedWith_Clean\n---\nResponseKey FK\nLanguageHaveWorkedWith_Clean"]:::bridgeLayer
        B_LangWW["Bridge_LanguageWantToWorkWith_Clean\n---\nResponseKey FK\nLanguageWantToWorkWith_Clean"]:::bridgeLayer
        B_PlatHW["Bridge_PlatformHaveWorkedWith_Clean\n---\nResponseKey FK\nPlatformHaveWorkedWith_Clean"]:::bridgeLayer
        B_PlatWW["Bridge_PlatformWantToWorkWith_Clean\n---\nResponseKey FK\nPlatformWantToWorkWith_Clean"]:::bridgeLayer
        B_WebHW["Bridge_WebframeHaveWorkedWith_Clean\n---\nResponseKey FK\nWebframeHaveWorkedWith_Clean"]:::bridgeLayer
        B_WebWW["Bridge_WebframeWantToWorkWith_Clean\n---\nResponseKey FK\nWebframeWantToWorkWith_Clean"]:::bridgeLayer
        B_TlHw["Bridge_ToolsTechHaveWorkedWith_Clean\n---\nResponseKey FK\nToolsTechHaveWorkedWith_Clean"]:::bridgeLayer
        B_TlWw["Bridge_ToolsTechWantToWorkWith_Clean\n---\nResponseKey FK\nToolsTechWantToWorkWith_Clean"]:::bridgeLayer
        B_MscHW["Bridge_MiscTechHaveWorkedWith_Clean\n---\nResponseKey FK\nMiscTechHaveWorkedWith_Clean"]:::bridgeLayer
        B_MscWW["Bridge_MiscTechWantToWorkWith_Clean\n---\nResponseKey FK\nMiscTechWantToWorkWith_Clean"]:::bridgeLayer
        B_EmbHW["Bridge_EmbeddedHaveWorkedWith_Clean\n---\nResponseKey FK\nEmbeddedHaveWorkedWith_Clean"]:::bridgeLayer
        B_EmbWW["Bridge_EmbeddedWantToWorkWith_Clean\n---\nResponseKey FK\nEmbeddedWantToWorkWith_Clean"]:::bridgeLayer
    end

    subgraph Collab_Bridges ["Environment & Collaborative Mappings (Many-to-Many)"]
        B_CommHW["Bridge_CommPlatformHaveWorkedWith_Clean\n---\nResponseKey FK\nCommPlatformHaveWorkedWith_Clean"]:::bridgeLayer
        B_CommWW["Bridge_CommPlatformWantToWorkWith_Clean\n---\nResponseKey FK\nCommPlatformWantToWorkWith_Clean"]:::bridgeLayer
        B_NewColHW["Bridge_NEWCollabToolsHaveWorkedWith_Clean\n---\nResponseKey FK\nNEWCollabToolsHaveWorkedWith_Clean"]:::bridgeLayer
        B_NewColWW["Bridge_NEWCollabToolsWantToWorkWith_Clean\n---\nResponseKey FK\nNEWCollabToolsWantToWorkWith_Clean"]:::bridgeLayer
        B_OfAsHW["Bridge_OfficeStackAsyncHaveWorkedWith_Clean\n---\nResponseKey FK\nOfficeStackAsyncHaveWorkedWith_Clean"]:::bridgeLayer
        B_OfAsWW["Bridge_OfficeStackAsyncWantToWorkWith_Clean\n---\nResponseKey FK\nOfficeStackAsyncWantToWorkWith_Clean"]:::bridgeLayer
        B_OfSyHW["Bridge_OfficeStackSyncHaveWorkedWith_Clean\n---\nResponseKey FK\nOfficeStackSyncHaveWorkedWith_Clean"]:::bridgeLayer
        B_OfSyWW["Bridge_OfficeStackSyncWantToWorkWith_Clean\n---\nResponseKey FK\nOfficeStackSyncWantToWorkWith_Clean"]:::bridgeLayer
        B_EnvHW["Bridge_DevEnvsHaveWorkedWith_Clean\n---\nResponseKey FK\nDevEnvsHaveWorkedWith_Clean"]:::bridgeLayer
        B_EnvWW["Bridge_DevEnvsWantToWorkWith_Clean\n---\nResponseKey FK\nDevEnvsWantToWorkWith_Clean"]:::bridgeLayer
        B_SOTgHW["Bridge_SOTagsHaveWorkedWith_Clean\n---\nResponseKey FK\nSOTagsHaveWorkedWith_Clean"]:::bridgeLayer
        B_SOTgWW["Bridge_SOTagsWantToWorkWith_Clean\n---\nResponseKey FK\nSOTagsWantToWorkWith_Clean"]:::bridgeLayer
        B_DevTyp["Bridge_DevType_Clean\n---\nResponseKey FK\nDevType_Clean"]:::bridgeLayer
        B_LrnCd["Bridge_LearnCode_Clean\n---\nResponseKey FK\nLearnCode_Clean"]:::bridgeLayer
        B_Stk["Bridge_NEWStuck_Clean\n---\nResponseKey FK\nNEWStuck_Clean"]:::bridgeLayer
    end

    %% Relationships (Fact to Standard Star Dimensions)
    Fact_Survey_Core --> Dim_Demographics
    Fact_Survey_Core --> Dim_Employment
    Fact_Survey_Core --> Dim_Compensation
    Fact_Survey_Core --> Dim_Education
    Fact_Survey_Core --> Dim_Satisfaction
    Fact_Survey_Core --> Dim_Knowledge
    Fact_Survey_Core --> Dim_StackOverflow
    Fact_Survey_Core --> Dim_SOActions
    Fact_Survey_Core --> Dim_MiscCategorical

    %% Relationships (Fact to Snowflake Central Hubs)
    Fact_Survey_Core --> Dim_AICentral
    Fact_Survey_Core --> Dim_TechCentral

    %% Relationships (Snowflake Central Hubs to Nested Sub-Dimensions)
    Dim_AICentral --> Dim_AIAgents
    Dim_AICentral --> Dim_AINext
    Dim_AICentral --> Dim_AIModels
    Dim_AICentral --> Dim_AITools
    Dim_AICentral --> Dim_AIOpinions

    Dim_TechCentral --> Dim_TechDatabases
    Dim_TechCentral --> Dim_TechPlatforms
    Dim_TechCentral --> Dim_TechLanguagesWeb
    Dim_TechCentral --> Dim_TechMiscTools
    Dim_TechCentral --> Dim_TechEndorse
    Dim_TechCentral --> Dim_TechOppose

    %% Many-To-Many Bridge Links via ResponseKey
    Fact_Survey_Core ====|Join via ResponseKey| AI_Bridges
    Fact_Survey_Core ====|Join via ResponseKey| Tech_Stack_Bridges
    Fact_Survey_Core ====|Join via ResponseKey| Collab_Bridges
