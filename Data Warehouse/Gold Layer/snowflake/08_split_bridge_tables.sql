IF NOT EXISTS (
    SELECT *
    FROM sys.schemas
    WHERE name = 'Snowflake'
) EXEC('CREATE SCHEMA Snowflake');
GO -- ==========================================
    -- BRIDGE_AIDEVHAVEWORKEDWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_AIDevHaveWorkedWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_AIDevHaveWorkedWith_Clean;
GO CREATE VIEW Snowflake.Bridge_AIDevHaveWorkedWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [AIDevHaveWorkedWith_Clean]
FROM Gold.Bridge_AIDevHaveWorkedWith_Clean;
GO -- ==========================================
    -- BRIDGE_AIDEVWANTTOWORKWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_AIDevWantToWorkWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_AIDevWantToWorkWith_Clean;
GO CREATE VIEW Snowflake.Bridge_AIDevWantToWorkWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [AIDevWantToWorkWith_Clean]
FROM Gold.Bridge_AIDevWantToWorkWith_Clean;
GO -- ==========================================
    -- BRIDGE_AIMODELSHAVEWORKEDWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_AIModelsHaveWorkedWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_AIModelsHaveWorkedWith_Clean;
GO CREATE VIEW Snowflake.Bridge_AIModelsHaveWorkedWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [AIModelsHaveWorkedWith_Clean]
FROM Gold.Bridge_AIModelsHaveWorkedWith_Clean;
GO -- ==========================================
    -- BRIDGE_AIMODELSWANTTOWORKWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_AIModelsWantToWorkWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_AIModelsWantToWorkWith_Clean;
GO CREATE VIEW Snowflake.Bridge_AIModelsWantToWorkWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [AIModelsWantToWorkWith_Clean]
FROM Gold.Bridge_AIModelsWantToWorkWith_Clean;
GO -- ==========================================
    -- BRIDGE_AISEARCHHAVEWORKEDWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_AISearchHaveWorkedWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_AISearchHaveWorkedWith_Clean;
GO CREATE VIEW Snowflake.Bridge_AISearchHaveWorkedWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [AISearchHaveWorkedWith_Clean]
FROM Gold.Bridge_AISearchHaveWorkedWith_Clean;
GO -- ==========================================
    -- BRIDGE_AISEARCHWANTTOWORKWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_AISearchWantToWorkWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_AISearchWantToWorkWith_Clean;
GO CREATE VIEW Snowflake.Bridge_AISearchWantToWorkWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [AISearchWantToWorkWith_Clean]
FROM Gold.Bridge_AISearchWantToWorkWith_Clean;
GO -- ==========================================
    -- BRIDGE_COMMPLATFORMHAVEWORKEDWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_CommPlatformHaveWorkedWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_CommPlatformHaveWorkedWith_Clean;
GO CREATE VIEW Snowflake.Bridge_CommPlatformHaveWorkedWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [CommPlatformHaveWorkedWith_Clean]
FROM Gold.Bridge_CommPlatformHaveWorkedWith_Clean;
GO -- ==========================================
    -- BRIDGE_COMMPLATFORMWANTTOWORKWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_CommPlatformWantToWorkWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_CommPlatformWantToWorkWith_Clean;
GO CREATE VIEW Snowflake.Bridge_CommPlatformWantToWorkWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [CommPlatformWantToWorkWith_Clean]
FROM Gold.Bridge_CommPlatformWantToWorkWith_Clean;
GO -- ==========================================
    -- BRIDGE_DATABASEHAVEWORKEDWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_DatabaseHaveWorkedWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_DatabaseHaveWorkedWith_Clean;
GO CREATE VIEW Snowflake.Bridge_DatabaseHaveWorkedWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [DatabaseHaveWorkedWith_Clean]
FROM Gold.Bridge_DatabaseHaveWorkedWith_Clean;
GO -- ==========================================
    -- BRIDGE_DATABASEWANTTOWORKWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_DatabaseWantToWorkWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_DatabaseWantToWorkWith_Clean;
GO CREATE VIEW Snowflake.Bridge_DatabaseWantToWorkWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [DatabaseWantToWorkWith_Clean]
FROM Gold.Bridge_DatabaseWantToWorkWith_Clean;
GO -- ==========================================
    -- BRIDGE_DEVENVSHAVEWORKEDWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_DevEnvsHaveWorkedWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_DevEnvsHaveWorkedWith_Clean;
GO CREATE VIEW Snowflake.Bridge_DevEnvsHaveWorkedWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [DevEnvsHaveWorkedWith_Clean]
FROM Gold.Bridge_DevEnvsHaveWorkedWith_Clean;
GO -- ==========================================
    -- BRIDGE_DEVENVSWANTTOWORKWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_DevEnvsWantToWorkWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_DevEnvsWantToWorkWith_Clean;
GO CREATE VIEW Snowflake.Bridge_DevEnvsWantToWorkWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [DevEnvsWantToWorkWith_Clean]
FROM Gold.Bridge_DevEnvsWantToWorkWith_Clean;
GO -- ==========================================
    -- BRIDGE_DEVTYPE_CLEAN
    -- ==========================================
    IF OBJECT_ID('Snowflake.Bridge_DevType_Clean', 'V') IS NOT NULL DROP VIEW Snowflake.Bridge_DevType_Clean;
GO CREATE VIEW Snowflake.Bridge_DevType_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [DevType_Clean]
FROM Gold.Bridge_DevType_Clean;
GO -- ==========================================
    -- BRIDGE_EMBEDDEDHAVEWORKEDWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_EmbeddedHaveWorkedWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_EmbeddedHaveWorkedWith_Clean;
GO CREATE VIEW Snowflake.Bridge_EmbeddedHaveWorkedWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [EmbeddedHaveWorkedWith_Clean]
FROM Gold.Bridge_EmbeddedHaveWorkedWith_Clean;
GO -- ==========================================
    -- BRIDGE_EMBEDDEDWANTTOWORKWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_EmbeddedWantToWorkWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_EmbeddedWantToWorkWith_Clean;
GO CREATE VIEW Snowflake.Bridge_EmbeddedWantToWorkWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [EmbeddedWantToWorkWith_Clean]
FROM Gold.Bridge_EmbeddedWantToWorkWith_Clean;
GO -- ==========================================
    -- BRIDGE_LANGUAGEHAVEWORKEDWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_LanguageHaveWorkedWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_LanguageHaveWorkedWith_Clean;
GO CREATE VIEW Snowflake.Bridge_LanguageHaveWorkedWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [LanguageHaveWorkedWith_Clean]
FROM Gold.Bridge_LanguageHaveWorkedWith_Clean;
GO -- ==========================================
    -- BRIDGE_LANGUAGEWANTTOWORKWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_LanguageWantToWorkWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_LanguageWantToWorkWith_Clean;
GO CREATE VIEW Snowflake.Bridge_LanguageWantToWorkWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [LanguageWantToWorkWith_Clean]
FROM Gold.Bridge_LanguageWantToWorkWith_Clean;
GO -- ==========================================
    -- BRIDGE_LEARNCODE_CLEAN
    -- ==========================================
    IF OBJECT_ID('Snowflake.Bridge_LearnCode_Clean', 'V') IS NOT NULL DROP VIEW Snowflake.Bridge_LearnCode_Clean;
GO CREATE VIEW Snowflake.Bridge_LearnCode_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [LearnCode_Clean]
FROM Gold.Bridge_LearnCode_Clean;
GO -- ==========================================
    -- BRIDGE_MISCTECHHAVEWORKEDWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_MiscTechHaveWorkedWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_MiscTechHaveWorkedWith_Clean;
GO CREATE VIEW Snowflake.Bridge_MiscTechHaveWorkedWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [MiscTechHaveWorkedWith_Clean]
FROM Gold.Bridge_MiscTechHaveWorkedWith_Clean;
GO -- ==========================================
    -- BRIDGE_MISCTECHWANTTOWORKWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_MiscTechWantToWorkWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_MiscTechWantToWorkWith_Clean;
GO CREATE VIEW Snowflake.Bridge_MiscTechWantToWorkWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [MiscTechWantToWorkWith_Clean]
FROM Gold.Bridge_MiscTechWantToWorkWith_Clean;
GO -- ==========================================
    -- BRIDGE_NEWCOLLABTOOLSHAVEWORKEDWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_NEWCollabToolsHaveWorkedWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_NEWCollabToolsHaveWorkedWith_Clean;
GO CREATE VIEW Snowflake.Bridge_NEWCollabToolsHaveWorkedWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [NEWCollabToolsHaveWorkedWith_Clean]
FROM Gold.Bridge_NEWCollabToolsHaveWorkedWith_Clean;
GO -- ==========================================
    -- BRIDGE_NEWCOLLABTOOLSWANTTOWORKWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_NEWCollabToolsWantToWorkWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_NEWCollabToolsWantToWorkWith_Clean;
GO CREATE VIEW Snowflake.Bridge_NEWCollabToolsWantToWorkWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [NEWCollabToolsWantToWorkWith_Clean]
FROM Gold.Bridge_NEWCollabToolsWantToWorkWith_Clean;
GO -- ==========================================
    -- BRIDGE_NEWSTUCK_CLEAN
    -- ==========================================
    IF OBJECT_ID('Snowflake.Bridge_NEWStuck_Clean', 'V') IS NOT NULL DROP VIEW Snowflake.Bridge_NEWStuck_Clean;
GO CREATE VIEW Snowflake.Bridge_NEWStuck_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [NEWStuck_Clean]
FROM Gold.Bridge_NEWStuck_Clean;
GO -- ==========================================
    -- BRIDGE_OFFICESTACKASYNCHAVEWORKEDWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_OfficeStackAsyncHaveWorkedWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_OfficeStackAsyncHaveWorkedWith_Clean;
GO CREATE VIEW Snowflake.Bridge_OfficeStackAsyncHaveWorkedWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [OfficeStackAsyncHaveWorkedWith_Clean]
FROM Gold.Bridge_OfficeStackAsyncHaveWorkedWith_Clean;
GO -- ==========================================
    -- BRIDGE_OFFICESTACKASYNCWANTTOWORKWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_OfficeStackAsyncWantToWorkWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_OfficeStackAsyncWantToWorkWith_Clean;
GO CREATE VIEW Snowflake.Bridge_OfficeStackAsyncWantToWorkWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [OfficeStackAsyncWantToWorkWith_Clean]
FROM Gold.Bridge_OfficeStackAsyncWantToWorkWith_Clean;
GO -- ==========================================
    -- BRIDGE_OFFICESTACKSYNCHAVEWORKEDWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_OfficeStackSyncHaveWorkedWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_OfficeStackSyncHaveWorkedWith_Clean;
GO CREATE VIEW Snowflake.Bridge_OfficeStackSyncHaveWorkedWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [OfficeStackSyncHaveWorkedWith_Clean]
FROM Gold.Bridge_OfficeStackSyncHaveWorkedWith_Clean;
GO -- ==========================================
    -- BRIDGE_OFFICESTACKSYNCWANTTOWORKWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_OfficeStackSyncWantToWorkWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_OfficeStackSyncWantToWorkWith_Clean;
GO CREATE VIEW Snowflake.Bridge_OfficeStackSyncWantToWorkWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [OfficeStackSyncWantToWorkWith_Clean]
FROM Gold.Bridge_OfficeStackSyncWantToWorkWith_Clean;
GO -- ==========================================
    -- BRIDGE_PLATFORMHAVEWORKEDWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_PlatformHaveWorkedWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_PlatformHaveWorkedWith_Clean;
GO CREATE VIEW Snowflake.Bridge_PlatformHaveWorkedWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [PlatformHaveWorkedWith_Clean]
FROM Gold.Bridge_PlatformHaveWorkedWith_Clean;
GO -- ==========================================
    -- BRIDGE_PLATFORMWANTTOWORKWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_PlatformWantToWorkWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_PlatformWantToWorkWith_Clean;
GO CREATE VIEW Snowflake.Bridge_PlatformWantToWorkWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [PlatformWantToWorkWith_Clean]
FROM Gold.Bridge_PlatformWantToWorkWith_Clean;
GO -- ==========================================
    -- BRIDGE_SOTAGSHAVEWORKEDWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_SOTagsHaveWorkedWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_SOTagsHaveWorkedWith_Clean;
GO CREATE VIEW Snowflake.Bridge_SOTagsHaveWorkedWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [SOTagsHaveWorkedWith_Clean]
FROM Gold.Bridge_SOTagsHaveWorkedWith_Clean;
GO -- ==========================================
    -- BRIDGE_SOTAGSWANTTOWORKWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_SOTagsWantToWorkWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_SOTagsWantToWorkWith_Clean;
GO CREATE VIEW Snowflake.Bridge_SOTagsWantToWorkWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [SOTagsWantToWorkWith_Clean]
FROM Gold.Bridge_SOTagsWantToWorkWith_Clean;
GO -- ==========================================
    -- BRIDGE_TOOLSTECHHAVEWORKEDWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_ToolsTechHaveWorkedWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_ToolsTechHaveWorkedWith_Clean;
GO CREATE VIEW Snowflake.Bridge_ToolsTechHaveWorkedWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [ToolsTechHaveWorkedWith_Clean]
FROM Gold.Bridge_ToolsTechHaveWorkedWith_Clean;
GO -- ==========================================
    -- BRIDGE_TOOLSTECHWANTTOWORKWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_ToolsTechWantToWorkWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_ToolsTechWantToWorkWith_Clean;
GO CREATE VIEW Snowflake.Bridge_ToolsTechWantToWorkWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [ToolsTechWantToWorkWith_Clean]
FROM Gold.Bridge_ToolsTechWantToWorkWith_Clean;
GO -- ==========================================
    -- BRIDGE_WEBFRAMEHAVEWORKEDWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_WebframeHaveWorkedWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_WebframeHaveWorkedWith_Clean;
GO CREATE VIEW Snowflake.Bridge_WebframeHaveWorkedWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [WebframeHaveWorkedWith_Clean]
FROM Gold.Bridge_WebframeHaveWorkedWith_Clean;
GO -- ==========================================
    -- BRIDGE_WEBFRAMEWANTTOWORKWITH_CLEAN
    -- ==========================================
    IF OBJECT_ID(
        'Snowflake.Bridge_WebframeWantToWorkWith_Clean',
        'V'
    ) IS NOT NULL DROP VIEW Snowflake.Bridge_WebframeWantToWorkWith_Clean;
GO CREATE VIEW Snowflake.Bridge_WebframeWantToWorkWith_Clean AS
SELECT CONVERT(
        VARCHAR(64),
        HASHBYTES(
            'SHA2_256',
            CONCAT_WS(
                '|',
                ISNULL(CAST([SurveyYear] AS NVARCHAR(MAX)), ''),
                ISNULL(CAST([ResponseId] AS NVARCHAR(MAX)), '')
            )
        ),
        2
    ) AS ResponseKey,
    [WebframeWantToWorkWith_Clean]
FROM Gold.Bridge_WebframeWantToWorkWith_Clean;
GO