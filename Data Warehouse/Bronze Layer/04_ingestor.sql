use Stack_Overflow_Survey;
GO

-- Loading 2021 --
BULK insert Bronze.Survey_2021
from 'c:\Users\Ayush\Git Repo\Stack-Overflow-Survey-Data-Engineering-Project\Stack Overflow survey\survey_results_public_2021.csv'
with (
    format = 'CSV',
    firstrow = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR ='0x0a',
    -- QUOTE='"',
    TABLOCK
);
GO

ALTER TABLE Bronze.Survey_2021 ADD [SurveyYear] INT;
GO
update Bronze.Survey_2021
set [SurveyYear]=2021
where [SurveyYear] is NULL;
GO


-- Loading 2022 --
BULK insert Bronze.Survey_2022
from 'C:\Users\Ayush\Git Repo\Stack-Overflow-Survey-Data-Engineering-Project\Stack Overflow survey\survey_results_public_2022.csv'
with (
    format = 'CSV',
    firstrow = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR ='0x0a',
    -- QUOTE='"',
    TABLOCK
);
GO

ALTER TABLE Bronze.Survey_2022 ADD [SurveyYear] INT;
GO
update Bronze.Survey_2022
set [SurveyYear]=2022
where [SurveyYear] is NULL;
GO


-- Loading 2023 --
BULK insert Bronze.Survey_2023
from 'C:\Users\Ayush\Git Repo\Stack-Overflow-Survey-Data-Engineering-Project\Stack Overflow survey\survey_results_public_2023.csv'
with (
    format = 'CSV',
    firstrow = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR ='0x0a',
    -- QUOTE='"',
    TABLOCK
);
GO

ALTER TABLE Bronze.Survey_2023 ADD [SurveyYear] INT;
GO
update Bronze.Survey_2023
set [SurveyYear]=2023
where [SurveyYear] is NULL;
GO


-- Loading 2024 --
BULK insert Bronze.Survey_2024
from 'C:\Users\Ayush\Git Repo\Stack-Overflow-Survey-Data-Engineering-Project\Stack Overflow survey\survey_results_public_2024.csv'
with (
    format = 'CSV',
    firstrow = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR ='0x0a',
    -- QUOTE='"',
    TABLOCK
);
GO

ALTER TABLE Bronze.Survey_2024 ADD [SurveyYear] INT;
GO
update Bronze.Survey_2024
set [SurveyYear]=2024
where [SurveyYear] is NULL;
GO


-- Loading 2025 --
BULK insert Bronze.Survey_2025
from 'C:\Users\Ayush\Git Repo\Stack-Overflow-Survey-Data-Engineering-Project\Stack Overflow survey\survey_results_public_2025.csv'
with (
    format = 'CSV',
    firstrow = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR ='0x0a',
    QUOTE='"',
    TABLOCK
);
GO

ALTER TABLE Bronze.Survey_2025 ADD [SurveyYear] INT;
GO
update Bronze.Survey_2025
set [SurveyYear]=2025
where [SurveyYear] is NULL;
GO

