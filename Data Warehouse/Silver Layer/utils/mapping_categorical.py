
class MappingCategorical:
    def __init__(self):
        self.all_maps = self._initialize_maps()
    
    def _initialize_maps(self):
        return {
            'employment_map': {
                'Employed full-time': 'Employed',
                'Employed part-time': 'Employed',
                'Employed, full-time': 'Employed',
                'Employed, part-time': 'Employed',
                'Employed': 'Employed',
                'Not employed': 'Unemployed',
                'Student': 'Student',
                'Independent contractor, freelancer, or self-employed': 'Freelance',
                'Student, full-time': 'Student',
                'Student, part-time': 'Student',
                'Not employed, but looking for work': 'Unemployed',
                'Not employed, and not looking for work': 'Unemployed',
                'Retired': 'Retired',
                'I prefer not to say': 'I prefer not to say',
                'Nan' : 'Not Available',
            },
            'ed_level_map': {
                'BachelorΓÇÖs degree (B.A., B.S., B.Eng., etc.)': 'Undergraduate',
                'MasterΓÇÖs degree (M.A., M.S., M.Eng., MBA, etc.)': 'Postgraduate',
                'Some college/university study without earning a degree': 'Undergraduate',
                'Secondary school (e.g. American high school, German Realschule or Gymnasium, etc.)': 'High School',
                'Other doctoral degree (Ph.D., Ed.D., etc.)': 'Doctorate',
                'Primary/elementary school': 'Primary',
                'Associate degree (A.A., A.S., etc.)': 'Undergraduate',
                'Something else': 'Other',
                'Professional degree (JD, MD, etc.)': 'Postgraduate',
                'Professional degree (JD, MD, Ph.D, Ed.D, etc.)': 'Postgraduate',
                'Other (please specify):': 'Other'
            },
            'age_1st_code_map': {
                'Younger than 5 years': '<5',
                '5 - 10 years': '5-10',
            '11 - 17 years': '11-17',
            '18 - 24 years': '18-24',
            '25 - 34 years': '25-34',
            '35 - 44 years': '35-44',
            '45 - 54 years': '45-54',
            '55 - 64 years': '55-64',
            'Older than 64 years': '>64'
        },
        'age_map': {
            'Under 18 years old': 'less than 18',
            '18-24 years old': '18-24',
            '25-34 years old': '25-34',
            '35-44 years old': '35-44',
            '45-54 years old': '45-54',
            '55-64 years old': '55-64',
            '65 years or older': 'greater than65',
            'Prefer not to say': 'Unknown'
        },
        'operating_system_map': {
            'Windows Subsystem for Linux (WSL)': 'WSL',
            'Linux-based': 'Linux',
            'MacOS': 'MacOS',
            'Windows': 'Windows',
            'BSD': 'Unix/BSD',
            'Other (please specify):': 'Other'
        },
        'org_mapping': {
            'Just me - I am a freelancer, sole proprietor, etc.': 'Self-employed',
            '2 to 9 employees': 'Micro (2-9)',
            '10 to 19 employees': 'Small (10-19)',
            '20 to 99 employees': 'Small-Medium (20-99)',
            '100 to 499 employees': 'Medium (100-499)',
            '500 to 999 employees': 'Large (500-999)',
            '1,000 to 4,999 employees': 'Enterprise (1K-4.9K)',
            '5,000 to 9,999 employees': 'Enterprise (5K-9.9K)',
            '10,000 or more employees': 'Enterprise (10K+)'
        },

        'trans_map': {
            'No': 'No',
            'Yes': 'Yes',
            'Prefer not to say': 'Unknown',
            'Or, in your own words:': 'Self-described'
        },
        'visit_freq_map': {
            'Multiple times per day': 'High (Multiple/Day)',
            'Daily or almost daily': 'High (Daily)',
            'A few times per week': 'Medium (Weekly)',
            'A few times per month or weekly': 'Medium (Monthly/Weekly)',
            'Less than once per month or monthly': 'Low (Monthly)',
        },
        'so_account_map': {
            'Yes': 'Yes',
            'No': 'No',
            '''Not sure/can't remember''': 'Uncertain',
        },
        'part_freq_map': {
            'Multiple times per day': 'High (Multiple/Day)',
            'Daily or almost daily': 'High (Daily)',
            'A few times per week': 'Medium (Weekly)',
            'A few times per month or weekly': 'Medium (Monthly/Weekly)',
            'Less than once per month or monthly': 'Low (Monthly)',
            'I have never participated in Q&A on Stack Overflow': 'Never'
        },
        'comm_map': {
            'Yes, definitely': 'Strongly Positive',
            'Yes, somewhat': 'Positive',
            'Neutral': 'Neutral',
            'No, not really': 'Negative',
            'No, not at all': 'Strongly Negative',
            'Not sure': 'Uncertain'
        },
        'new_so_sites_map': {
            'Stack Overflow;Stack Exchange': 'SO & Stack Exchange',
            'Stack Overflow': 'Stack Overflow Only',
            'Stack Overflow;Stack Exchange;Stack Overflow for Teams (private knowledge sharing & collaboration platform for companies)': 'Full Network User',
            'I have never visited Stack Overflow or the Stack Exchange network': 'Never Visited',
            'Stack Overflow;Stack Overflow for Teams (private knowledge sharing & collaboration platform for companies)': 'SO & Teams',
            'Stack Exchange': 'Stack Exchange Only',
            'Stack Overflow for Teams (private knowledge sharing & collaboration platform for companies)': 'Teams Only',
            'Stack Exchange;Stack Overflow for Teams (private knowledge sharing & collaboration platform for companies)': 'SE & Teams'
        },
        'survey_length_map': {
            'Appropriate in length': 'Appropriate',
            'Too long': 'Too Long',
            'Too short': 'Too Short'
        },
        'survey_ease_map': {
            'Easy': 'Easy',
            'Neither easy nor difficult': 'Neutral',
            'Difficult': 'Difficult'
        },

        'main_branch_map': {
            'I am a developer by profession': 'Professional Developer',
            'I am learning to code': 'Student/Learner',
            'I am not primarily a developer, but I write code sometimes as part of my work': 'Coding Professional',
            'I am not primarily a developer, but I write code sometimes as part of my work/studies': 'Coding Professional',
            'I code primarily as a hobby': 'Hobbyist',
            'I used to be a developer by profession, but no longer am': 'Retired/Former Developer',
            'None of these': 'Other'
        },
    


        'gender_map': {
            'Man': 'Man',
            'Woman': 'Woman',
            'Non-binary, genderqueer, or gender non-conforming': 'Non-binary / GNC',
            'Prefer not to say': 'Unknown',
            'Or, in your own words:': 'Non-binary / GNC',
        },
        'ethnicity_map': {
            'White or of European descent': 'White',
            'South Asian': 'South Asian',
            'Middle Eastern': 'Middle Eastern',
            'Southeast Asian': 'Southeast Asian',
            'East Asian': 'East Asian',
            'Hispanic or Latino/a/x': 'Hispanic/Latino',
            'Black or of African descent': 'Black',
            'Indigenous (such as Native American, Pacific Islander, or Indigenous Australian)': 'Indigenous',
            'Multiracial': 'Multiracial/Biracial',
            'Biracial': 'Multiracial/Biracial',
            'Or, in your own words:': 'Self-described',
            'Prefer not to say': 'Unknown',
            "I don't know": 'Unknown'
        },
        'learn_code_map': {
            'School': 'Academic (Degree)',
            'Coding Bootcamp': 'Bootcamp',
            'Online Courses or Certification': 'Online Certifications',
            'Other online resources (ex: videos, blogs, etc)': 'Digital Self-Taught',
            'Books / Physical media': 'Physical Media',
            'Online Forum': 'Community/Forums',
            'Colleague': 'Professional Network',
            'Friend or family member': 'Social/Family',
            'Other (please specify):': 'Other'
        },
        'sexuality_map': {
            'Straight / Heterosexual': 'Straight',
            'Bisexual': 'Bisexual',
            'Gay or Lesbian': 'Gay or Lesbian',
            'Queer': 'Queer',
            'Prefer to self-describe:': 'Self-described',
            'Prefer not to say': 'Unknown'
        },
        'accessibility_map': {
            'None of the above': 'None',
            'I am deaf / hard of hearing': 'Hearing Impairment',
            'I am blind / have difficulty seeing': 'Visual Impairment',
            'I am unable to / find it difficult to type': 'Mobility (Typing)',
            'I am unable to / find it difficult to walk or stand without assistance': 'Mobility (Walking/Standing)',
            'Or, in your own words:': 'Self-described',
            'Prefer not to say': 'Unknown'
        },
        'mental_health_map': {
            'None of the above': 'None',
            'I have a concentration and/or memory disorder (e.g. ADHD)': 'ADHD/Concentration',
            'I have an anxiety disorder': 'Anxiety',
            'I have a mood or emotional disorder (e.g. depression, bipolar disorder)': 'Mood/Emotional',
            "I have autism / an autism spectrum disorder (e.g. Asperger's)": 'Autism Spectrum',
            'Or, in your own words:': 'Self-described',
            'Prefer not to say': 'Unknown'
        },


        'dev_type_map': {
            'Developer, full-stack': 'Full-stack', 'Developer, back-end': 'Back-end',
            'Developer, front-end': 'Front-end', 'Developer, mobile': 'Mobile',
            'Developer, desktop or enterprise applications': 'Desktop/Enterprise',
            'Engineer, data': 'Data Engineer', 'Data scientist or machine learning specialist': 'Data Scientist/ML',
            'Data or business analyst': 'Data/BI Analyst', 'DevOps specialist': 'DevOps',
            'Engineer, site reliability': 'SRE', 'Engineering manager': 'Engineering Manager',
            'Senior Executive (C-Suite, VP, etc.)': 'Executive', 'System administrator': 'SysAdmin',
            'Database administrator': 'DBA', 'Developer, game or graphics': 'Game/Graphics',
            'Developer, embedded applications or devices': 'Embedded/IoT', 'Developer, QA or test': 'QA/Testing',
            'Academic researcher': 'Researcher', 'Scientist': 'Scientist', 'Student': 'Student',
            'Educator': 'Educator', 'Designer': 'Designer', 'Product manager': 'Product Manager',
            'Marketing or sales professional': 'Marketing/Sales', 'Other (please specify):': 'Other',
            'Blockchain': 'Other', 'Cloud infrastructure engineer': 'DevOps', 'Data engineer': 'Data Engineer',
            'Developer Advocate': 'Other', 'Developer Experience': 'DevOps', 'Developer, AI': 'Data Scientist/ML',
            'Hardware Engineer': 'Embedded/IoT', 'Project manager': 'Product Manager', 'Research & Development role': 'Researcher',
            'Security professional': 'SRE'
        },

        'stuck_map' : {
            'Google it': 'Search (Google)', 'Visit Stack Overflow': 'Community (Stack Overflow)',
            'Visit another developer community (please name):': 'Community (Other)',
            'Watch help / tutorial videos': 'Self-Paced Learning', 'Go for a walk or other physical activity': 'Physical Break',
            'Meditate': 'Mental Break', 'Play games': 'Mental Break', 'Do other work and come back later': 'Context Switch',
            'Call a coworker or friend': 'Social Support', 'Panic': 'Emotional Response', 'Other (please specify):': 'Other'
        },
        }
        
    def get_map(self, map_name=None):
        if map_name:
            return self.all_maps.get(map_name, "Map not found")
        return self.all_maps