import React, { useState, useEffect, useRef } from 'react';
import { 
  MessageSquare, 
  Database, 
  BarChart3, 
  History, 
  Send, 
  Download, 
  ChevronRight, 
  Terminal, 
  RefreshCw,
  Sparkles, 
  HelpCircle,
  ToggleLeft,
  ToggleRight,
  TrendingUp,
  Coins,
  BrainCircuit,
  MapPin,
  Lock,
  Grid,
  Eye,
  BookOpen,
  ArrowRight,
  GitBranch,
  Layers,
  ChevronDown,
  Cpu,
  Layers3,
  Flame,
  CheckCircle2,
  Menu,
  X
} from 'lucide-react';
import { 
  BarChart, Bar, LineChart, Line, AreaChart, Area, 
  XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer 
} from 'recharts';

// Schema Metadata Directory
const MOCK_SCHEMAS = {
  views: [
    { name: "Snowflake.Fact_Survey_Core", description: "Central core fact views linked to all core dimension keys and survey measurements." },
    { name: "Dim_Demographics", description: "Standard dimension containing age, gender, ethnicity, accessibility, and geographics." },
    { name: "Dim_Employment", description: "Standard dimension listing developer type, remote status, industry, and workspace size." },
    { name: "Dim_Compensation", description: "Standard dimension containing annual converted salaries and currency mappings." },
    { name: "Dim_AICentral", description: "Hub linking core survey responses directly to complex AI granular sub-dimensions." },
    { name: "Dim_TechCentral", description: "Hub branching core fact responses to database, platform, language, and web frameworks." },
    { name: "Bridge_LanguageHaveWorkedWith_Clean", description: "Many-to-many bridge resolving developer programing languages worked with." },
    { name: "Bridge_AIModelsHaveWorkedWith_Clean", description: "Many-to-many bridge resolving AI models utilized by developers." }
  ]
};

const MOCK_PROMPTS = [
  "Show average yearly compensation by developer type.",
  "How has developer sentiment on AI threat evolved from 2023 to 2025?",
  "List top 5 databases developers want to work with in 2025.",
  "Compare remote vs in-person average salary by country."
];

const MOCK_RESPONSES = {
  "Show average yearly compensation by developer type.": {
    sql: "SELECT \n  d.Current_Profession AS DevType,\n  ROUND(AVG(c.ConvertedCompYearly), 2) AS AverageSalary\nFROM Snowflake.Fact_Survey_Core f\nJOIN Dim_Employment d ON f.Dim_EmploymentID = d.Dim_EmploymentID\nJOIN Dim_Compensation c ON f.Dim_CompensationID = c.Dim_CompensationID\nWHERE c.ConvertedCompYearly IS NOT NULL\n  AND c.ConvertedCompYearly NOT IN (56211.0, 67845.0, 74963.0, 65000.0, 75320.0)\nGROUP BY d.Current_Profession\nORDER BY AverageSalary DESC;",
    insight: "Our analysis shows Engineering Managers lead compensation profiles (avg $145,000), followed by Data Engineers ($122,000) and Data Scientist/ML engineers ($118,000). Students represent the lower boundary averaging $22,000. All calculations successfully exclude standard imputed placeholders to guarantee statistical reliability.",
    columns: ["DevType", "AverageSalary"],
    rows: [
      { DevType: "Engineering Manager", AverageSalary: 145000 },
      { DevType: "Data Engineer", AverageSalary: 122000 },
      { DevType: "Data Scientist/ML", AverageSalary: 118000 },
      { DevType: "Full-stack", AverageSalary: 105000 },
      { DevType: "Back-end", AverageSalary: 102000 },
      { DevType: "DevOps", AverageSalary: 99000 },
      { DevType: "Front-end", AverageSalary: 88000 },
      { DevType: "Student", AverageSalary: 22000 }
    ],
    chartType: "bar",
    xAxis: "DevType",
    yAxis: "AverageSalary"
  },
  "How has developer sentiment on AI threat evolved from 2023 to 2025?": {
    sql: "SELECT \n  f.SurveyYear,\n  a.AIThreat AS ThreatLevel,\n  COUNT(*) AS TotalResponses\nFROM Snowflake.Fact_Survey_Core f\nJOIN Dim_AICentral ac ON f.Dim_AICentralID = ac.Dim_AICentralID\nJOIN Dim_AIOpinions a ON ac.Dim_AIOpinionsID = a.Dim_AIOpinionsID\nWHERE a.AIThreat IS NOT NULL AND a.AIThreat <> 'Unknown'\nGROUP BY f.SurveyYear, a.AIThreat\nORDER BY f.SurveyYear, TotalResponses DESC;",
    insight: "Data reveals growing concern regarding AI's impact on job security. Respondents listing AI as a 'Serious threat' grew from 1,100 in 2023 to 2,500 in 2025. 'Mild concern' counts rose concurrently, showing a clear shift in how developers view AI integration.",
    columns: ["SurveyYear", "ThreatLevel", "TotalResponses"],
    rows: [
      { SurveyYear: "2023", ThreatLevel: "I'm not worried", TotalResponses: 4500 },
      { SurveyYear: "2023", ThreatLevel: "Mild concern", TotalResponses: 3200 },
      { SurveyYear: "2023", ThreatLevel: "Serious threat", TotalResponses: 1100 },
      { SurveyYear: "2024", ThreatLevel: "I'm not worried", TotalResponses: 3800 },
      { SurveyYear: "2024", ThreatLevel: "Mild concern", TotalResponses: 4100 },
      { SurveyYear: "2024", ThreatLevel: "Serious threat", TotalResponses: 1800 },
      { SurveyYear: "2025", ThreatLevel: "Mild concern", TotalResponses: 4500 },
      { SurveyYear: "2025", ThreatLevel: "I'm not worried", TotalResponses: 3100 },
      { SurveyYear: "2025", ThreatLevel: "Serious threat", TotalResponses: 2500 }
    ],
    chartType: "line",
    xAxis: "SurveyYear",
    yAxis: "TotalResponses"
  },
  "List top 5 databases developers want to work with in 2025.": {
    sql: "SELECT TOP 5 \n  b.DatabaseWantToWorkWith_Clean AS DatabaseName,\n  COUNT(*) AS VoteCount\nFROM Snowflake.Fact_Survey_Core f\nJOIN Bridge_DatabaseWantToWorkWith_Clean b ON f.ResponseKey = b.ResponseKey\nWHERE f.SurveyYear = 2025\nGROUP BY b.DatabaseWantToWorkWith_Clean\nORDER BY VoteCount DESC;",
    insight: "PostgreSQL holds the first place with 28,400 votes for 2025. Redis (19,100) and MongoDB (17,500) rank second and third, while Microsoft SQL Server remains popular, rounding out the top five with 12,900 votes.",
    columns: ["DatabaseName", "VoteCount"],
    rows: [
      { DatabaseName: "PostgreSQL", VoteCount: 28400 },
      { DatabaseName: "Redis", VoteCount: 19100 },
      { DatabaseName: "MongoDB", VoteCount: 17500 },
      { DatabaseName: "SQLite", VoteCount: 14200 },
      { DatabaseName: "Microsoft SQL Server", VoteCount: 12900 }
    ],
    chartType: "bar",
    xAxis: "DatabaseName",
    yAxis: "VoteCount"
  },
  "Compare remote vs in-person average salary by country.": {
    sql: "SELECT \n  d.Country,\n  d.RemoteWork AS WorkType,\n  ROUND(AVG(c.ConvertedCompYearly), 2) AS AverageSalary\nFROM Snowflake.Fact_Survey_Core f\nJOIN Dim_Demographics d ON f.Dim_DemographicsID = d.Dim_DemographicsID\nJOIN Dim_Employment e ON f.Dim_EmploymentID = e.Dim_EmploymentID\nJOIN Dim_Compensation c ON f.Dim_CompensationID = c.Dim_CompensationID\nWHERE d.Country IN ('United States', 'Germany', 'United Kingdom', 'India')\n  AND d.RemoteWork IS NOT NULL \n  AND c.ConvertedCompYearly IS NOT NULL\n  AND c.ConvertedCompYearly NOT IN (56211.0, 67845.0, 74963.0, 65000.0, 75320.0)\nGROUP BY d.Country, d.RemoteWork\nORDER BY d.Country, AverageSalary DESC;",
    insight: "A consistent premium for remote work is observed globally. In the United States, remote developers earn an average of $165,000 vs $148,000 in-person. The premium holds across Germany ($92k vs $84k), the UK ($98k vs $89k), and India ($38k vs $32k).",
    columns: ["Country", "WorkType", "AverageSalary"],
    rows: [
      { Country: "United States", WorkType: "Remote", AverageSalary: 165000 },
      { Country: "United States", WorkType: "In-Person", AverageSalary: 148000 },
      { Country: "Germany", WorkType: "Remote", AverageSalary: 92000 },
      { Country: "Germany", WorkType: "In-Person", AverageSalary: 84000 },
      { Country: "United Kingdom", WorkType: "Remote", AverageSalary: 98000 },
      { Country: "United Kingdom", WorkType: "In-Person", AverageSalary: 89000 },
      { Country: "India", WorkType: "Remote", AverageSalary: 38000 },
      { Country: "India", WorkType: "In-Person", AverageSalary: 32000 }
    ],
    chartType: "bar",
    xAxis: "Country",
    yAxis: "AverageSalary"
  }
};

// 37 Pre-analyzed Jupyter notebook output charts catalog
const PRE_ANALYSED_CATEGORIES = [
  {
    id: "demographics",
    name: "Demographics & Roles",
    charts: [
      { id: "age_dist", title: "Age Distribution (Cleaned)", path: "/images/01_age_distribution_clean.png", desc: "Cleaned visualization of survey developer age groups." },
      { id: "exp_dist", title: "Experience Distribution (Cleaned)", path: "/images/01_experience_distribution_clean.png", desc: "Developer experience profiles, filtered for outliers." },
      { id: "gender_dist", title: "Gender Distribution", path: "/images/01_gender_distribution.png", desc: "Breakdown of developer gender identity demographics." },
      { id: "gender_trends", title: "Gender Demographics YoY", path: "/images/01_gender_trends.png", desc: "Year-over-year gender representation trends." },
      { id: "dev_roles_2025", title: "Developer Roles (2025)", path: "/images/01_dev_roles_2025.png", desc: "Most popular developer professions and job types." },
      { id: "dev_roles_trends", title: "Developer Role Popularity YoY", path: "/images/01_dev_roles_trends.png", desc: "Evolution of engineering and analyst roles." },
      { id: "countries", title: "Top Respondent Countries", path: "/images/01_top_countries.png", desc: "Respondent volume mapped by country." }
    ]
  },
  {
    id: "compensation",
    name: "Compensation & Industry",
    charts: [
      { id: "emp_status", title: "Employment Status Breakdown", path: "/images/02_employment_status.png", desc: "Full-time, part-time, self-employed and student distribution." },
      { id: "reg_salary", title: "Regional Salary Trends", path: "/images/02_regional_salary_trends_clean.png", desc: "Comparison of average developer salaries by geographic region." },
      { id: "sal_edu", title: "Salary by Education Level", path: "/images/02_salary_by_education.png", desc: "Core correlation between highest education degree and compensation." },
      { id: "sal_exp", title: "Salary by Experience", path: "/images/02_salary_by_experience.png", desc: "Year-over-year compensation curve relative to coding experience." },
      { id: "sal_exp_reg", title: "Regional Salary Curve", path: "/images/02_salary_by_experience_regional.png", desc: "Years of experience vs compensation separated by global regions." },
      { id: "sal_org", title: "Salary by Organization Size", path: "/images/02_salary_by_org_size_clean.png", desc: "Compensation rates correlated with corporate organization sizes." },
      { id: "sal_trends", title: "Salary Growth YoY", path: "/images/02_salary_trends.png", desc: "Year-over-year developer salary growth (2021-2025)." }
    ]
  },
  {
    id: "satisfaction",
    name: "Workplace & Satisfaction",
    charts: [
      { id: "job_sat", title: "Overall Job Satisfaction", path: "/images/03_job_satisfaction.png", desc: "Proportion of satisfied vs dissatisfied developers." },
      { id: "job_sat_grp", title: "Satisfaction by Role Group", path: "/images/03_job_satisfaction_grouped.png", desc: "Satisfaction comparison grouped by developer roles." },
      { id: "job_sat_yoy", title: "Satisfaction Rate YoY", path: "/images/03_job_satisfaction_yoy.png", desc: "Year-over-year tracking of developer happiness." },
      { id: "remote_org", title: "Remote Status by Org Size", path: "/images/03_remote_by_org_size.png", desc: "Corporate sizing vs remote/hybrid work policies." },
      { id: "remote_trends", title: "Remote Work Adoption YoY", path: "/images/03_remote_work_trends.png", desc: "Post-pandemic shift in remote work percentages." },
      { id: "sat_bar", title: "Satisfaction Distribution", path: "/images/03_satisfaction_year_bar.png", desc: "Detailed satisfaction scores by year." },
      { id: "sat_trend", title: "Satisfaction Trend Curves", path: "/images/03_satisfaction_year_trend.png", desc: "Granular satisfaction shifts over the years." }
    ]
  },
  {
    id: "tech_trends",
    name: "Technology Popularity",
    charts: [
      { id: "db_trends", title: "Database Engine Trends", path: "/images/04_database_trends.png", desc: "PostgreSQL, MySQL, and SQL Server popularity curves." },
      { id: "lang_desire", title: "Language Desirability", path: "/images/04_language_desirability.png", desc: "Worked-with vs wanted-to-work-with languages." },
      { id: "lang_trends", title: "Programming Languages YoY", path: "/images/04_language_trends.png", desc: "Shift in language popularity over 5 years." },
      { id: "web_trends", title: "Web Framework Trends", path: "/images/04_webframe_trends.png", desc: "Adoption trends for React, Angular, NextJS, and Vue." }
    ]
  },
  {
    id: "ai",
    name: "AI Adoption & Sentiments",
    charts: [
      { id: "ai_used", title: "AI Models Currently Used", path: "/images/05_ai__models_used.png", desc: "OpenAI, Anthropic, Gemini, and open weights model usage." },
      { id: "ai_wanted", title: "AI Models Desired", path: "/images/05_ai__models_wanted.png", desc: "Which LLM models developers want to work with in the future." },
      { id: "ai_role", title: "AI Tool Adoption by Dev Role", path: "/images/05_ai_adoption_by_role.png", desc: "Who uses AI tools the most (e.g. front-end vs data engineers)." },
      { id: "ai_trust", title: "Trust in AI Tool Code Output", path: "/images/05_ai_trust.png", desc: "Level of trust in generated coding outputs." },
      { id: "ai_sent", title: "AI Sentiment on Job Security", path: "/images/05_developer_ai_sentiment.png", desc: "Developer perspectives on AI as a benefit vs threat." }
    ]
  },
  {
    id: "education",
    name: "Learning & Education",
    charts: [
      { id: "ai_edu", title: "AI Tools in Technical Learning", path: "/images/06_ai_in_education.png", desc: "How students vs pros utilize AI tools for studying." },
      { id: "edu_prof", title: "Education Profiles", path: "/images/06_education_profile.png", desc: "Degree levels held by surveyed developers." },
      { id: "learn_methods", title: "Learning Methods (2021-2025)", path: "/images/06_learning_methods.png", desc: "Transition from academic degrees to online resources." }
    ]
  }
];

export default function App() {
  const [messages, setMessages] = useState(() => {
    const saved = localStorage.getItem('stac_chat_messages');
    if (saved) {
      try {
        return JSON.parse(saved);
      } catch (e) {
        console.error("Error parsing saved messages:", e);
      }
    }
    return [
      {
        sender: 'system',
        text: 'Welcome to the Stack Overflow Warehouse AI Data Analyst. Ask me any analytical question using natural language (e.g., salaries, technology popularity, AI sentiments).',
        timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
      }
    ];
  });
  const [input, setInput] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [queryHistory, setQueryHistory] = useState(() => {
    const saved = localStorage.getItem('stac_query_history');
    if (saved) {
      try {
        return JSON.parse(saved);
      } catch (e) {
        console.error("Error parsing saved query history:", e);
      }
    }
    return [];
  });
  const [activeTab, setActiveTab] = useState('chat'); // chat, data, chart, pre_analysed, docs
  
  const [cachedResults, setCachedResults] = useState(() => {
    const saved = localStorage.getItem('stac_cached_results');
    if (saved) {
      try {
        return JSON.parse(saved);
      } catch (e) {
        console.error("Error parsing saved cached results:", e);
      }
    }
    return {};
  });

  const [selectedResult, setSelectedResult] = useState(() => {
    const saved = localStorage.getItem('stac_selected_result');
    if (saved) {
      try {
        return JSON.parse(saved);
      } catch (e) {
        console.error("Error parsing saved selected result:", e);
      }
    }
    return null;
  });

  const [mockMode, setMockMode] = useState(true);
  const [expandedSql, setExpandedSql] = useState({});
  const [isSidebarOpen, setIsSidebarOpen] = useState(false);

  // Sync to localStorage
  useEffect(() => {
    localStorage.setItem('stac_chat_messages', JSON.stringify(messages));
  }, [messages]);

  useEffect(() => {
    localStorage.setItem('stac_query_history', JSON.stringify(queryHistory));
  }, [queryHistory]);

  useEffect(() => {
    localStorage.setItem('stac_cached_results', JSON.stringify(cachedResults));
  }, [cachedResults]);

  useEffect(() => {
    if (selectedResult) {
      localStorage.setItem('stac_selected_result', JSON.stringify(selectedResult));
    } else {
      localStorage.removeItem('stac_selected_result');
    }
  }, [selectedResult]);

  
  // Pre-analyzed dashboard states
  const [activeCategory, setActiveCategory] = useState('demographics');
  const [selectedImageModal, setSelectedImageModal] = useState(null);

  // Documentation sections state
  const [activeDocSection, setActiveDocSection] = useState('architecture');
  const [expandedSchemaTable, setExpandedSchemaTable] = useState(null);

  const chatContainerRef = useRef(null);

  useEffect(() => {
    if (chatContainerRef.current) {
      chatContainerRef.current.scrollTo({
        top: chatContainerRef.current.scrollHeight,
        behavior: 'smooth'
      });
    }
  }, [messages]);

  const triggerSearch = async (queryText) => {
    if (!queryText.trim()) return;
    
    // Check local cache
    if (cachedResults[queryText]) {
      const cachedRes = cachedResults[queryText];
      const userMsg = {
        sender: 'user',
        text: queryText,
        timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
      };
      setMessages(prev => [...prev, userMsg, {
        sender: 'ai',
        text: cachedRes.insight || cachedRes.summary || "Loaded query from cache.",
        sql: cachedRes.sql,
        timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
      }]);
      setSelectedResult(cachedRes);
      setInput('');
      return;
    }

    const userMsg = {
      sender: 'user',
      text: queryText,
      timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
    };
    
    setMessages(prev => [...prev, userMsg]);
    setIsLoading(true);
    setInput('');

    await new Promise(resolve => setTimeout(resolve, 1500));

    if (mockMode) {
      const mockResponse = MOCK_RESPONSES[queryText];
      if (mockResponse) {
        const resultWithQuery = { ...mockResponse, query: queryText };
        setSelectedResult(resultWithQuery);
        setCachedResults(prev => ({ ...prev, [queryText]: resultWithQuery }));
        setQueryHistory(prev => {
          if (!prev.includes(queryText)) return [queryText, ...prev];
          return prev;
        });

        setMessages(prev => [...prev, {
          sender: 'ai',
          text: mockResponse.insight || "I processed your query. You can see the resulting data and charts in the respective tabs.",
          sql: mockResponse.sql,
          timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
        }]);
      } else {
        setMessages(prev => [...prev, {
          sender: 'ai',
          text: `I couldn't find a matching offline response for that query. Try clicking one of the quick suggestions or toggle to the real API!`,
          timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
        }]);
      }
      setIsLoading(false);
    } else {
      try {
        const response = await fetch('http://localhost:8000/api/chat', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ query: queryText })
        });
        const data = await response.json();
        
        if (response.ok) {
          const resultWithQuery = { ...data, query: queryText };
          setSelectedResult(resultWithQuery);
          setCachedResults(prev => ({ ...prev, [queryText]: resultWithQuery }));
          setQueryHistory(prev => {
            if (!prev.includes(queryText)) return [queryText, ...prev];
            return prev;
          });
          setMessages(prev => [...prev, {
            sender: 'ai',
            text: data.summary || `Query executed successfully on local SQL Server.`,
            sql: data.sql,
            timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
          }]);
        } else {
          setMessages(prev => [...prev, {
            sender: 'ai',
            text: `Error executing query: ${data.detail || 'Internal server error'}`,
            timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
          }]);
        }
      } catch (err) {
        setMessages(prev => [...prev, {
          sender: 'ai',
          text: `Failed to connect to backend server. Make sure FastAPI server is running on localhost:8000!`,
          timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
        }]);
      } finally {
        setIsLoading(false);
      }
    }
  };

  const toggleSqlExpand = (index) => {
    setExpandedSql(prev => ({ ...prev, [index]: !prev[index] }));
  };

  const downloadCSV = () => {
    if (!selectedResult || !selectedResult.rows.length) return;
    
    const headers = selectedResult.columns.join(',');
    const rows = selectedResult.rows.map(row => 
      selectedResult.columns.map(col => `"${row[col]}"`).join(',')
    );
    const csvContent = "data:text/csv;charset=utf-8," + [headers, ...rows].join("\n");
    const encodedUri = encodeURI(csvContent);
    const link = document.createElement("a");
    link.setAttribute("href", encodedUri);
    link.setAttribute("download", "so_survey_query_results.csv");
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  const downloadChartImage = () => {
    const chartEl = document.querySelector('.recharts-responsive-container svg');
    if (!chartEl) return;
    
    try {
      const serializer = new XMLSerializer();
      const svgString = serializer.serializeToString(chartEl);
      const svgBlob = new Blob([svgString], { type: 'image/svg+xml;charset=utf-8' });
      const URL = window.URL || window.webkitURL || window;
      const blobURL = URL.createObjectURL(svgBlob);
      
      const image = new Image();
      image.onload = () => {
        const canvas = document.createElement('canvas');
        const bbox = chartEl.getBoundingClientRect();
        canvas.width = bbox.width * 2;
        canvas.height = bbox.height * 2;
        
        const context = canvas.getContext('2d');
        context.fillStyle = '#12131a';
        context.fillRect(0, 0, canvas.width, canvas.height);
        
        context.scale(2, 2);
        context.drawImage(image, 0, 0);
        
        const pngURL = canvas.toDataURL('image/png');
        const downloadLink = document.createElement('a');
        downloadLink.href = pngURL;
        downloadLink.download = 'query_insights_chart.png';
        document.body.appendChild(downloadLink);
        downloadLink.click();
        document.body.removeChild(downloadLink);
        URL.revokeObjectURL(blobURL);
      };
      image.src = blobURL;
    } catch (err) {
      console.error("Error downloading chart image:", err);
    }
  };

  const currentCategoryObj = PRE_ANALYSED_CATEGORIES.find(cat => cat.id === activeCategory);

  return (
    <div className="flex h-screen bg-[#0a0b10] text-gray-200 overflow-hidden font-sans relative cyber-grid cyber-scanner">
      
      {/* Background Animated Glows for high-end AI feel */}
      <div className="absolute top-[-10%] left-[-10%] w-[50%] h-[50%] bg-blue-500/8 rounded-full blur-[120px] pointer-events-none animate-pulse duration-[8000ms] floating-particle" />
      <div className="absolute bottom-[-10%] right-[-10%] w-[50%] h-[50%] bg-purple-500/8 rounded-full blur-[120px] pointer-events-none animate-pulse duration-[10000ms] floating-particle" style={{ animationDelay: '2s' }} />
      <div className="absolute top-[30%] right-[20%] w-[35%] h-[35%] bg-teal-500/4 rounded-full blur-[100px] pointer-events-none animate-pulse duration-[12000ms] floating-particle" style={{ animationDelay: '4s' }} />

      {/* Mobile Sidebar Backdrop Overlay */}
      {isSidebarOpen && (
        <div 
          className="fixed inset-0 bg-black/60 backdrop-blur-sm z-30 lg:hidden" 
          onClick={() => setIsSidebarOpen(false)} 
        />
      )}

      {/* Left Panel: Sidebar Directory & History */}
      <aside className={`w-80 bg-[#12131a]/95 lg:bg-[#12131a]/85 backdrop-blur-md border-r border-[#1e2030] flex flex-col z-40 shrink-0 fixed lg:relative inset-y-0 left-0 transform transition-transform duration-300 overflow-hidden ${
        isSidebarOpen ? 'translate-x-0' : '-translate-x-full lg:translate-x-0'
      }`}>
        <div className="absolute inset-0 cyber-scanner pointer-events-none opacity-20" />
        <div className="p-5 border-b border-[#1e2030] flex items-center justify-between relative z-10 group">
          <div className="flex items-center space-x-3">
            <div className="w-10 h-10 rounded-xl bg-gradient-to-tr from-blue-500 to-purple-600 flex items-center justify-center shadow-lg shadow-blue-500/20 animate-pulse group-hover:scale-105 transition-transform duration-300">
              <BrainCircuit className="w-6 h-6 text-white" />
            </div>
            <div>
              <h1 className="text-md font-extrabold text-white tracking-wider text-glow-blue flex items-center gap-1 cyber-glitch" data-text="AI Data Analyst">
                AI Data Analyst
              </h1>
              <p className="text-[10px] text-gray-400 flex items-center font-mono">
                <span className="relative flex h-1.5 w-1.5 mr-2">
                  <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-green-400 opacity-75"></span>
                  <span className="relative inline-flex rounded-full h-1.5 w-1.5 bg-green-500"></span>
                </span>
                <span>STAC-SYSTEM ONLINE</span>
              </p>
            </div>
          </div>
          <button 
            onClick={() => setIsSidebarOpen(false)}
            className="lg:hidden p-1.5 text-gray-400 hover:text-white bg-white/5 border border-white/5 rounded-lg"
          >
            <X className="w-4 h-4" />
          </button>
        </div>

        {/* Directory & Schema Inspector */}
        <div className="flex-1 overflow-y-auto px-4 py-4 space-y-6 scrollbar-thin">
          
          {/* Connection Settings */}
          <div className="transition-all duration-300">
            <span className="text-xs font-semibold text-gray-400 uppercase tracking-wider block mb-3">API Server Integration</span>
            <div className="p-3 bg-[#171923] hover:bg-white/5 rounded-xl border border-white/5 flex items-center justify-between transition-colors">
              <span className="text-xs text-gray-300">Offline Mock Mode</span>
              <button 
                onClick={() => setMockMode(!mockMode)}
                className="focus:outline-none transition-colors"
              >
                {mockMode ? (
                  <ToggleRight className="w-10 h-6 text-blue-500 hover:scale-105 transition-transform" />
                ) : (
                  <ToggleLeft className="w-10 h-6 text-gray-500 hover:scale-105 transition-transform" />
                )}
              </button>
            </div>
            <p className="text-[10px] text-gray-500 mt-1 px-1">
              {mockMode ? "Demonstration mode with pre-baked responses." : "Queries are dynamically sent to localhost:8000."}
            </p>
            <button
              onClick={() => {
                localStorage.removeItem('stac_chat_messages');
                localStorage.removeItem('stac_query_history');
                localStorage.removeItem('stac_cached_results');
                localStorage.removeItem('stac_selected_result');
                setMessages([
                  {
                    sender: 'system',
                    text: 'Welcome to the Stack Overflow Warehouse AI Data Analyst. Ask me any analytical question using natural language (e.g., salaries, technology popularity, AI sentiments).',
                    timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
                  }
                ]);
                setQueryHistory([]);
                setCachedResults({});
                setSelectedResult(null);
              }}
              className="w-full text-center text-xs mt-3 bg-red-500/10 hover:bg-red-500/20 border border-red-500/20 hover:border-red-500/40 rounded-xl py-2 text-red-400 hover:text-red-300 transition-all font-semibold cursor-pointer"
            >
              Clear Cache & Reset History
            </button>
          </div>

          {/* Quick Prompts */}
          <div>
            <span className="text-xs font-semibold text-gray-400 uppercase tracking-wider block mb-2 text-glow-blue">Quick SQL Queries</span>
            <div className="space-y-2">
              {MOCK_PROMPTS.map((promptText, i) => (
                <button
                  key={i}
                  onClick={() => {
                    setActiveTab('chat');
                    triggerSearch(promptText);
                  }}
                  className="w-full text-left text-xs bg-[#171923]/60 hover:bg-[#1f2130]/80 border border-[#1e2030] hover:border-blue-500/40 p-3.5 text-gray-300 hover:text-white transition-all transform hover:translate-x-1 hover:cyber-glow-blue duration-300 line-clamp-2 cyber-corners cursor-pointer"
                >
                  {promptText}
                </button>
              ))}
            </div>
          </div>


        </div>

        {/* History Logger */}
        {queryHistory.length > 0 && (
          <div className="p-4 border-t border-[#1e2030] bg-[#0c0d13] relative overflow-hidden">
            <div className="absolute inset-0 cyber-scanner pointer-events-none opacity-10" />
            <div className="flex items-center space-x-2 text-xs font-semibold text-gray-400 uppercase tracking-wider mb-2 relative z-10">
              <History className="w-3.5 h-3.5 text-blue-400" />
              <span>Query History</span>
            </div>
            <div className="space-y-1.5 max-h-32 overflow-y-auto pr-1 relative z-10 scrollbar-thin">
              {queryHistory.map((hist, idx) => (
                <button
                  key={idx}
                  onClick={() => {
                    if (cachedResults[hist]) {
                      setSelectedResult(cachedResults[hist]);
                      if (activeTab === 'chat' || activeTab === 'pre_analysed' || activeTab === 'docs') {
                        setActiveTab('chart');
                      }
                    } else {
                      triggerSearch(hist);
                    }
                  }}
                  className="w-full text-left text-[11px] text-gray-400 hover:text-white truncate bg-[#171923]/60 hover:bg-white/5 px-2.5 py-2 border border-[#1e2030] transition-all transform hover:translate-x-1 hover:cyber-glow-blue duration-300 cursor-pointer cyber-corners"
                >
                  {hist}
                </button>
              ))}
            </div>
          </div>
        )}
      </aside>

      {/* Main Workspace */}
      <main className="flex-1 flex flex-col bg-[#0a0b10]/95 backdrop-blur-md overflow-hidden relative">
        
        {/* Top Navigation */}
        <header className="h-16 border-b border-[#1e2030] bg-[#12131a]/80 backdrop-blur-md px-6 flex items-center justify-between z-10 shrink-0 shadow-lg shadow-black/10 relative neon-border">
          <div className="absolute inset-0 cyber-scanner pointer-events-none opacity-20" />
          <div className="flex items-center space-x-3 overflow-x-auto pr-4 scrollbar-none z-10">
            <button
              onClick={() => setIsSidebarOpen(true)}
              className="lg:hidden p-2 text-gray-400 hover:text-white bg-white/5 hover:bg-white/10 border border-white/5 rounded-xl mr-2 shrink-0 transition-all active:scale-95 duration-200"
            >
              <Menu className="w-5 h-5" />
            </button>
            <button
              onClick={() => setActiveTab('chat')}
              className={`flex items-center space-x-2 text-sm font-semibold px-4 py-2 transition-all whitespace-nowrap shrink-0 hover:scale-[1.02] active:scale-95 duration-200 cyber-corners cyber-click-glitch cursor-pointer ${
                activeTab === 'chat' 
                  ? 'bg-blue-500/15 text-blue-400 border border-blue-500/35 cyber-glow-blue text-glow-blue font-bold shadow-[0_0_15px_rgba(59,130,246,0.1)]' 
                  : 'text-gray-400 hover:text-white hover:bg-white/5'
              }`}
            >
              <MessageSquare className="w-4 h-4" />
              <span>AI Chat Assistant</span>
            </button>
            <button
              onClick={() => setActiveTab('data')}
              disabled={!selectedResult}
              className={`flex items-center space-x-2 text-sm font-semibold px-4 py-2 transition-all whitespace-nowrap shrink-0 hover:scale-[1.02] active:scale-95 duration-200 cyber-corners cyber-click-glitch cursor-pointer ${
                !selectedResult ? 'opacity-40 cursor-not-allowed' : ''
              } ${
                activeTab === 'data' 
                  ? 'bg-purple-500/15 text-purple-400 border border-purple-500/35 cyber-glow-purple text-glow-purple font-bold shadow-[0_0_15px_rgba(139,92,246,0.1)]' 
                  : 'text-gray-400 hover:text-white hover:bg-white/5'
              }`}
            >
              <Database className="w-4 h-4" />
              <span>SQL Data Grid</span>
            </button>
            <button
              onClick={() => setActiveTab('chart')}
              disabled={!selectedResult}
              className={`flex items-center space-x-2 text-sm font-semibold px-4 py-2 transition-all whitespace-nowrap shrink-0 hover:scale-[1.02] active:scale-95 duration-200 cyber-corners cyber-click-glitch cursor-pointer ${
                !selectedResult ? 'opacity-40 cursor-not-allowed' : ''
              } ${
                activeTab === 'chart' 
                  ? 'bg-purple-500/15 text-purple-400 border border-purple-500/35 cyber-glow-purple text-glow-purple font-bold shadow-[0_0_15px_rgba(139,92,246,0.1)]' 
                  : 'text-gray-400 hover:text-white hover:bg-white/5'
              }`}
            >
              <BarChart3 className="w-4 h-4" />
              <span>Visual Chart</span>
            </button>
            <button
              onClick={() => setActiveTab('pre_analysed')}
              className={`flex items-center space-x-2 text-sm font-semibold px-4 py-2 transition-all whitespace-nowrap shrink-0 hover:scale-[1.02] active:scale-95 duration-200 cyber-corners cyber-click-glitch cursor-pointer ${
                activeTab === 'pre_analysed' 
                  ? 'bg-teal-500/15 text-teal-400 border border-teal-500/35 cyber-glow-teal text-glow-teal font-bold shadow-[0_0_15px_rgba(20,184,166,0.1)]' 
                  : 'text-gray-400 hover:text-white hover:bg-white/5'
              }`}
            >
              <Grid className="w-4 h-4" />
              <span>Pre-Analysed Dashboard</span>
            </button>
            <button
              onClick={() => setActiveTab('docs')}
              className={`flex items-center space-x-2 text-sm font-semibold px-4 py-2 transition-all whitespace-nowrap shrink-0 hover:scale-[1.02] active:scale-95 duration-200 cyber-corners cyber-click-glitch cursor-pointer ${
                activeTab === 'docs' 
                  ? 'bg-pink-500/15 text-pink-400 border border-pink-500/35 cyber-glow-pink text-glow-pink font-bold shadow-[0_0_15px_rgba(236,72,153,0.1)]' 
                  : 'text-gray-400 hover:text-white hover:bg-white/5'
              }`}
            >
              <BookOpen className="w-4 h-4" />
              <span>Methodology & Docs</span>
            </button>
          </div>

          {selectedResult && activeTab !== 'pre_analysed' && activeTab !== 'docs' && (
            <button
              onClick={downloadCSV}
              className="flex items-center space-x-1.5 text-xs text-gray-300 hover:text-white bg-white/5 hover:bg-white/10 px-3 py-1.5 rounded-lg border border-white/5 transition-all hover:scale-105 active:scale-95 duration-200 shrink-0 z-10 hover:cyber-glow-blue"
            >
              <Download className="w-3.5 h-3.5" />
              <span>Export CSV</span>
            </button>
          )}
        </header>

        {/* Workspace Body */}
        <div className="flex-1 relative flex flex-col overflow-hidden">
          
          {/* Tab Content Wrapper */}
          <div className="flex-1 relative min-h-0">
            
            {/* Tab 1: Chat Assistant */}
            {activeTab === 'chat' && (
              <div className="absolute inset-0 flex flex-col bg-[#0a0b10]/40">
                
                 {/* Message Panel */}
                <div ref={chatContainerRef} className="flex-1 overflow-y-auto px-8 py-6 space-y-6 scrollbar-thin">
                  {messages.map((msg, idx) => (
                    <div 
                      key={idx}
                      className={`flex flex-col max-w-[80%] transform transition-all duration-300 translate-y-2 animate-in fade-in slide-in-from-bottom-2 ${
                        msg.sender === 'user' ? 'ml-auto items-end' : 'mr-auto items-start'
                      }`}
                    >
                      <div className="flex items-center space-x-2 mb-1.5 text-xs text-gray-500">
                        {msg.sender === 'ai' && <Sparkles className="w-3.5 h-3.5 text-blue-400 animate-pulse" />}
                        <span className="font-semibold text-gray-400">
                          {msg.sender === 'user' ? 'You' : msg.sender === 'system' ? 'System' : 'Survey Analyst'}
                        </span>
                        <span>•</span>
                        <span>{msg.timestamp}</span>
                      </div>

                      <div className={`p-4 rounded-2xl text-sm leading-relaxed border transition-shadow duration-300 ${
                        msg.sender === 'user' 
                          ? 'bg-gradient-to-br from-blue-600 to-blue-700 text-white border-blue-500 shadow-md shadow-blue-600/10 rounded-tr-none hover:shadow-blue-500/20' 
                          : msg.sender === 'system'
                          ? 'bg-white/2 text-gray-400 border-white/5'
                          : 'bg-[#12131a]/90 backdrop-blur-md text-gray-300 border-[#1e2030] rounded-tl-none shadow-sm hover:shadow-[0_0_15px_rgba(59,130,246,0.05)]'
                      }`}>
                        {msg.sender === 'ai' && idx === messages.length - 1 ? (
                          <span className="caret-blink">{msg.text}</span>
                        ) : (
                          msg.text
                        )}
                      </div>
                    </div>
                  ))}
                  
                  {isLoading && (
                    <div className="flex flex-col max-w-[80%] mr-auto items-start">
                      <div className="flex items-center space-x-2 mb-1.5 text-xs text-gray-500">
                        <Cpu className="w-3.5 h-3.5 text-blue-400 animate-spin" />
                        <span className="font-semibold text-blue-400 text-glow-blue animate-pulse">AI Neural Query Agent Processing...</span>
                      </div>
                      <div className="p-5 bg-[#12131a]/95 backdrop-blur-md text-gray-400 border border-blue-500/25 rounded-2xl rounded-tl-none shadow-[0_0_15px_rgba(59,130,246,0.06)] flex flex-col space-y-3.5">
                        <div className="text-xs font-mono text-gray-300">
                          Reading metadata indices, validating view dependencies, and compiling optimized T-SQL query...
                        </div>
                        <div className="flex items-center space-x-1.5 h-6">
                          <span className="w-1 bg-blue-500 rounded data-wave-bar h-full origin-bottom" style={{ animationDelay: '0.1s' }} />
                          <span className="w-1 bg-purple-500 rounded data-wave-bar h-full origin-bottom" style={{ animationDelay: '0.3s' }} />
                          <span className="w-1 bg-pink-500 rounded data-wave-bar h-full origin-bottom" style={{ animationDelay: '0.5s' }} />
                          <span className="w-1 bg-teal-500 rounded data-wave-bar h-full origin-bottom" style={{ animationDelay: '0.2s' }} />
                          <span className="w-1 bg-blue-400 rounded data-wave-bar h-full origin-bottom" style={{ animationDelay: '0.4s' }} />
                        </div>
                      </div>
                    </div>
                  )}
                </div>

                {/* Chat Input Container */}
                <div className="p-6 border-t border-[#1e2030] bg-[#12131a]/80 backdrop-blur-md">
                  <form 
                    onSubmit={(e) => {
                      e.preventDefault();
                      triggerSearch(input);
                    }}
                    className="flex items-center space-x-3 max-w-4xl mx-auto relative bg-[#0a0b10] border border-[#1e2030] px-4.5 py-3 shadow-inner group focus-within:border-blue-500/50 transition-all duration-300 cyber-corners"
                  >
                    <input
                      type="text"
                      value={input}
                      onChange={(e) => setInput(e.target.value)}
                      placeholder="Ask standard developer queries (e.g. 'Show average yearly compensation by developer type')"
                      className="flex-1 bg-transparent text-sm text-white placeholder-gray-500 focus:outline-none pr-10"
                    />
                    <button
                      type="submit"
                      className="p-1.5 bg-blue-500 hover:bg-blue-600 text-white shadow-md shadow-blue-500/10 hover:scale-105 active:scale-95 transition-all duration-200 shrink-0 cyber-corners cursor-pointer"
                    >
                      <Send className="w-4 h-4" />
                    </button>
                  </form>
                </div>

              </div>
            )}

            {/* Tab 2: SQL Data Grid */}
            {activeTab === 'data' && selectedResult && (
              <div className="absolute inset-0 p-6 flex flex-col overflow-hidden bg-[#0a0b10]/40">
                <div className="flex-1 border border-[#1e2030] rounded-2xl bg-[#12131a]/80 backdrop-blur-md overflow-hidden flex flex-col shadow-inner">
                  
                  {/* Query Selector Header */}
                  <div className="px-4.5 py-3 border-b border-[#1e2030] flex items-center justify-between bg-[#191b24]/50">
                    <span className="text-xs font-bold text-white uppercase tracking-wider">SQL Data Grid</span>
                    {Object.keys(cachedResults).length > 1 && (
                      <div className="flex items-center space-x-2">
                        <span className="text-[10px] text-gray-400 font-semibold uppercase tracking-wider">Select Cache:</span>
                        <select
                          value={selectedResult.query || ''}
                          onChange={(e) => {
                            const result = cachedResults[e.target.value];
                            if (result) setSelectedResult(result);
                          }}
                          className="bg-[#171923] border border-white/10 text-xs text-gray-300 hover:text-white rounded-xl px-3 py-1 focus:outline-none focus:border-blue-500/50 transition-all max-w-[200px] md:max-w-[300px] truncate cursor-pointer"
                        >
                          {Object.keys(cachedResults).map((queryText, idx) => (
                            <option key={idx} value={queryText}>
                              {queryText}
                            </option>
                          ))}
                        </select>
                      </div>
                    )}
                  </div>

                  {/* Scrollable Table View */}
                  <div className="flex-1 overflow-auto">
                    <table className="w-full text-left border-collapse text-xs text-gray-300">
                      <thead>
                        <tr className="bg-[#171923]/90 border-b border-[#1e2030] text-gray-400 font-semibold uppercase tracking-wider">
                          {selectedResult.columns.map((col, idx) => (
                            <th key={idx} className="p-3.5 font-mono text-[11px]">{col}</th>
                          ))}
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-white/5 font-mono text-[11px]">
                        {selectedResult.rows.map((row, rowIdx) => (
                          <tr key={rowIdx} className="hover:bg-white/2 transition-colors">
                            {selectedResult.columns.map((col, colIdx) => (
                              <td key={colIdx} className="p-3.5 text-gray-300 max-w-xs truncate">
                                {typeof row[col] === 'number' 
                                  ? row[col].toLocaleString() 
                                  : String(row[col])}
                              </td>
                            ))}
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>

                  {/* Footer Record Count */}
                  <div className="h-10 border-t border-[#1e2030] px-4.5 flex items-center justify-between text-xs text-gray-500 bg-[#0f1017]">
                    <span>Total Records: {selectedResult.rows.length}</span>
                    <span className="flex items-center space-x-1.5">
                      <Database className="w-3.5 h-3.5 text-blue-400" />
                      <span>Snowflake Fact View</span>
                    </span>
                  </div>

                </div>
              </div>
            )}

            {/* Tab 3: Visual Chart */}
            {activeTab === 'chart' && selectedResult && (
              <div className="absolute inset-0 p-6 flex flex-col overflow-hidden bg-[#0a0b10]/40">
                <div className="flex-1 border border-[#1e2030] rounded-2xl bg-[#12131a]/80 backdrop-blur-md p-6 flex flex-col shadow-inner">
                  
                  {/* Title and Controls */}
                  <div className="flex items-center justify-between mb-6">
                    <div>
                      <h3 className="text-md font-bold text-white">Query Insights</h3>
                      <p className="text-xs text-gray-400">Active visualization: {selectedResult.xAxis} vs {selectedResult.yAxis}</p>
                    </div>
                    <div className="flex flex-wrap items-center gap-2">
                      {Object.keys(cachedResults).length > 1 && (
                        <div className="flex items-center space-x-1.5">
                          <span className="text-[10px] font-semibold text-gray-400 uppercase tracking-wider hidden sm:inline">History:</span>
                          <select
                            value={selectedResult.query || ''}
                            onChange={(e) => {
                              const result = cachedResults[e.target.value];
                              if (result) setSelectedResult(result);
                            }}
                            className="bg-[#171923] border border-white/10 text-xs text-gray-300 hover:text-white rounded-xl px-2.5 py-1.5 focus:outline-none focus:border-blue-500/50 transition-all max-w-[120px] sm:max-w-[200px] truncate cursor-pointer"
                          >
                            {Object.keys(cachedResults).map((queryText, idx) => (
                              <option key={idx} value={queryText}>
                                {queryText}
                              </option>
                            ))}
                          </select>
                        </div>
                      )}
                      
                      <button
                        onClick={downloadChartImage}
                        className="flex items-center space-x-1.5 px-3 py-1.5 bg-white/5 border border-white/5 hover:border-blue-500/35 hover:bg-white/10 text-xs text-gray-300 hover:text-white rounded-xl transition-all duration-200 cursor-pointer"
                      >
                        <Download className="w-3.5 h-3.5" />
                        <span>Download PNG</span>
                      </button>
                      <div className="px-3 py-1.5 bg-blue-500/10 text-blue-400 text-xs font-semibold rounded-xl border border-blue-500/20">
                        {selectedResult.chartType.toUpperCase()} CHART
                      </div>
                    </div>
                  </div>

                  {/* Recharts Container */}
                  <div className="flex-1 w-full min-h-0 relative">
                    {(() => {
                      const isThreeDimensional = selectedResult.columns.length === 3;
                      const chartData = selectedResult.rows.map(row => {
                        if (isThreeDimensional) {
                          const xVal = row[selectedResult.xAxis];
                          const splitCol = selectedResult.columns.find(col => col !== selectedResult.xAxis && col !== selectedResult.yAxis);
                          const splitVal = splitCol ? row[splitCol] : '';
                          return {
                            ...row,
                            displayLabel: splitVal ? `${xVal} (${splitVal})` : String(xVal)
                          };
                        }
                        return {
                          ...row,
                          displayLabel: String(row[selectedResult.xAxis])
                        };
                      });
                      const xAxisKey = 'displayLabel';

                      return (
                        <ResponsiveContainer width="100%" height="100%">
                          {selectedResult.chartType === 'line' ? (
                            <LineChart data={chartData} margin={{ top: 10, right: 30, left: 10, bottom: 25 }}>
                              <defs>
                                <filter id="cyber-glow-blue" x="-20%" y="-20%" width="140%" height="140%">
                                  <feGaussianBlur stdDeviation="4" result="blur" />
                                  <feMerge>
                                    <feMergeNode in="blur" />
                                    <feMergeNode in="SourceGraphic" />
                                  </feMerge>
                                </filter>
                              </defs>
                              <CartesianGrid strokeDasharray="3 3" stroke="#1e2030" />
                              <XAxis dataKey={xAxisKey} stroke="#6b7280" style={{ fontSize: 10 }} dy={10} />
                              <YAxis stroke="#6b7280" style={{ fontSize: 11 }} />
                              <Tooltip contentStyle={{ backgroundColor: '#12131a', borderColor: '#1e2030', color: '#f3f4f6' }} />
                              <Legend />
                              <Line type="monotone" dataKey={selectedResult.yAxis} stroke="#3b82f6" strokeWidth={3.5} filter="url(#cyber-glow-blue)" activeDot={{ r: 8 }} />
                            </LineChart>
                          ) : (
                            <BarChart data={chartData} margin={{ top: 10, right: 30, left: 10, bottom: 25 }}>
                              <defs>
                                <filter id="cyber-glow-purple" x="-20%" y="-20%" width="140%" height="140%">
                                  <feGaussianBlur stdDeviation="3" result="blur" />
                                  <feMerge>
                                    <feMergeNode in="blur" />
                                    <feMergeNode in="SourceGraphic" />
                                  </feMerge>
                                </filter>
                              </defs>
                              <CartesianGrid strokeDasharray="3 3" stroke="#1e2030" />
                              <XAxis dataKey={xAxisKey} stroke="#6b7280" style={{ fontSize: 10 }} dy={10} />
                              <YAxis stroke="#6b7280" style={{ fontSize: 11 }} />
                              <Tooltip contentStyle={{ backgroundColor: '#12131a', borderColor: '#1e2030', color: '#f3f4f6' }} />
                              <Legend />
                              <Bar dataKey={selectedResult.yAxis} fill="#8b5cf6" filter="url(#cyber-glow-purple)" radius={[4, 4, 0, 0]} />
                            </BarChart>
                          )}
                        </ResponsiveContainer>
                      );
                    })()}
                  </div>

                </div>
              </div>
            )}

            {/* Tab 4: Pre-Analysed Dashboard */}
            {activeTab === 'pre_analysed' && (
              <div className="absolute inset-0 flex flex-col lg:flex-row bg-[#0a0b10]/40 overflow-hidden">
                
                {/* Category sub-navigation */}
                <div className="w-full lg:w-60 bg-[#12131a]/60 border-b lg:border-b-0 lg:border-r border-[#1e2030] flex flex-row lg:flex-col p-3 lg:p-4 space-y-0 lg:space-y-1.5 space-x-2 lg:space-x-0 shrink-0 overflow-x-auto lg:overflow-y-auto scrollbar-none">
                  <span className="text-[10px] font-semibold text-gray-500 uppercase tracking-widest hidden lg:block px-2.5 mb-2">Notebook Chapters</span>
                  {PRE_ANALYSED_CATEGORIES.map(category => (
                    <button
                      key={category.id}
                      onClick={() => setActiveCategory(category.id)}
                      className={`text-xs font-semibold px-3 py-2 lg:py-2.5 rounded-xl transition-all truncate flex items-center justify-between shrink-0 whitespace-nowrap lg:w-full transform lg:hover:translate-x-1 duration-200 ${
                        activeCategory === category.id
                          ? 'bg-teal-500/10 text-teal-400 border border-teal-500/20'
                          : 'text-gray-400 hover:text-white hover:bg-white/5'
                      }`}
                    >
                      <span>{category.name}</span>
                      <ChevronRight className="w-3.5 h-3.5 opacity-60 hidden lg:block" />
                    </button>
                  ))}
                </div>

                {/* Main Images Grid */}
                <div className="flex-1 p-6 overflow-y-auto bg-[#0a0b10]/10">
                  <div className="mb-6">
                    <h2 className="text-lg font-bold text-white tracking-wide">{currentCategoryObj.name}</h2>
                    <p className="text-xs text-gray-400">Jupyter analysis outputs and visualizations from the Exploratory Data Analysis module.</p>
                  </div>

                  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    {currentCategoryObj.charts.map(chart => (
                      <div 
                        key={chart.id}
                        className="group bg-[#12131a]/80 backdrop-blur-md border border-[#1e2030] hover:border-teal-500/30 overflow-hidden flex flex-col cursor-pointer transition-all duration-300 cyber-corners cyber-3d-card cyber-click-glitch"
                        onClick={() => setSelectedImageModal(chart)}
                      >
                        {/* Image Thumbnail */}
                        <div className="relative aspect-video bg-[#0f1016] border-b border-[#1e2030] overflow-hidden flex items-center justify-center">
                          <img 
                            src={chart.path} 
                            alt={chart.title}
                            className="object-contain w-full h-full group-hover:scale-105 transition-transform duration-500"
                          />
                          <div className="absolute inset-0 bg-[#0a0b10]/60 opacity-0 group-hover:opacity-100 flex items-center justify-center transition-opacity duration-300">
                            <div className="flex items-center space-x-1.5 text-xs text-teal-400 bg-teal-500/10 border border-teal-500/20 px-3 py-1.5 rounded-xl font-semibold transform translate-y-2 group-hover:translate-y-0 transition-transform duration-300">
                              <Eye className="w-4 h-4" />
                              <span>View Full Chart</span>
                            </div>
                          </div>
                        </div>

                        {/* Card Details */}
                        <div className="p-4 flex-1 flex flex-col justify-between">
                          <div>
                            <h4 className="text-xs font-bold text-white group-hover:text-teal-400 transition-colors line-clamp-1">
                              {chart.title}
                            </h4>
                            <p className="text-[11px] text-gray-400 mt-1 line-clamp-2">
                              {chart.desc}
                            </p>
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>

              </div>
            )}

            {/* Tab 5: Methodology & Docs */}
            {activeTab === 'docs' && (
              <div className="absolute inset-0 flex flex-col lg:flex-row bg-[#0a0b10]/40 overflow-hidden">
                
                {/* Doc sub-navigation */}
                <div className="w-full lg:w-64 bg-[#12131a]/60 border-b lg:border-b-0 lg:border-r border-[#1e2030] flex flex-row lg:flex-col p-3 lg:p-4 space-y-0 lg:space-y-1.5 space-x-2 lg:space-x-0 shrink-0 overflow-x-auto lg:overflow-y-auto scrollbar-none">
                  <span className="text-[10px] font-semibold text-gray-500 uppercase tracking-widest hidden lg:block px-2.5 mb-2">Documentation Menu</span>
                  <button
                    onClick={() => setActiveDocSection('architecture')}
                    className={`text-xs font-semibold px-3 py-2 lg:py-2.5 transition-all flex items-center space-x-2.5 shrink-0 whitespace-nowrap lg:w-full transform lg:hover:translate-x-1 duration-200 cyber-corners cyber-click-glitch cursor-pointer ${
                      activeDocSection === 'architecture'
                        ? 'bg-pink-500/10 text-pink-400 border border-pink-500/20'
                        : 'text-gray-400 hover:text-white hover:bg-white/5'
                    }`}
                  >
                    <Layers className="w-3.5 h-3.5" />
                    <span>Pipeline Architecture</span>
                  </button>
                  <button
                    onClick={() => setActiveDocSection('dataflow')}
                    className={`text-xs font-semibold px-3 py-2 lg:py-2.5 transition-all flex items-center space-x-2.5 shrink-0 whitespace-nowrap lg:w-full transform lg:hover:translate-x-1 duration-200 cyber-corners cyber-click-glitch cursor-pointer ${
                      activeDocSection === 'dataflow'
                        ? 'bg-pink-500/10 text-pink-400 border border-pink-500/20'
                        : 'text-gray-400 hover:text-white hover:bg-white/5'
                    }`}
                  >
                    <Database className="w-3.5 h-3.5" />
                    <span>Warehouse Data Flow</span>
                  </button>
                  <button
                    onClick={() => setActiveDocSection('snowflake_details')}
                    className={`text-xs font-semibold px-3 py-2 lg:py-2.5 transition-all flex items-center space-x-2.5 shrink-0 whitespace-nowrap lg:w-full transform lg:hover:translate-x-1 duration-200 cyber-corners cyber-click-glitch cursor-pointer ${
                      activeDocSection === 'snowflake_details'
                        ? 'bg-pink-500/10 text-pink-400 border border-pink-500/20'
                        : 'text-gray-400 hover:text-white hover:bg-white/5'
                    }`}
                  >
                    <Database className="w-3.5 h-3.5" />
                    <span>Snowflake Views</span>
                  </button>
                  <button
                    onClick={() => setActiveDocSection('cicd')}
                    className={`text-xs font-semibold px-3 py-2 lg:py-2.5 transition-all flex items-center space-x-2.5 shrink-0 whitespace-nowrap lg:w-full transform lg:hover:translate-x-1 duration-200 cyber-corners cyber-click-glitch cursor-pointer ${
                      activeDocSection === 'cicd'
                        ? 'bg-pink-500/10 text-pink-400 border border-pink-500/20'
                        : 'text-gray-400 hover:text-white hover:bg-white/5'
                    }`}
                  >
                    <GitBranch className="w-3.5 h-3.5" />
                    <span>CI/CD & DAGs</span>
                  </button>
                </div>

                {/* Doc details viewer */}
                <div className="flex-1 p-8 overflow-y-auto bg-[#0a0b10]/10 text-gray-300 space-y-6">
                  
                  {/* 1. Architecture details */}
                  {activeDocSection === 'architecture' && (
                    <div className="max-w-4xl space-y-6 animate-in fade-in slide-in-from-bottom-2 duration-300">
                      <div>
                        <h2 className="text-xl font-bold text-white tracking-wide flex items-center space-x-2.5">
                          <Layers className="w-5 h-5 text-pink-400 animate-pulse" />
                          <span>Medallion Pipeline Architecture</span>
                        </h2>
                        <p className="text-xs text-gray-400 mt-1">Overall pipeline topology: from source survey databases to final gold analytics.</p>
                      </div>

                      {/* Architecture Diagram Image */}
                      <div className="bg-[#12131a]/70 p-4 border border-[#1e2030] rounded-2xl flex flex-col items-center shadow-lg group">
                        <img 
                          src="/images/Architecture DIagram.png" 
                          alt="Architecture Diagram" 
                          className="rounded-xl border border-white/5 max-h-96 object-contain w-full group-hover:scale-[1.01] transition-transform duration-300"
                        />
                        <span className="text-[10px] text-gray-500 font-mono mt-3">Figure 1.0: Medallion Architecture Data Pipeline Topology</span>
                      </div>

                      <div className="p-6 bg-[#12131a] border border-[#1e2030] rounded-2xl space-y-4">
                        <h3 className="text-sm font-bold text-white">Ingestion to Stage Flow</h3>

                        <div className="space-y-3.5 text-xs leading-relaxed text-gray-300">
                          <p>
                            Our Data Engineering pipeline uses a <strong>Medallion Data Architecture</strong> pattern in Microsoft SQL Server to govern raw surveys into structured models:
                          </p>
                          <ul className="list-disc list-inside space-y-2.5 pl-2 text-gray-400">
                            <li><strong className="text-amber-400">Bronze Layer:</strong> Directly ingests yearly developer survey CSVs using optimized T-SQL bulk ingestion commands (`BULK INSERT`). Columns are ingested as string schemas to guarantee stability and prevent datatype parsing errors during high-volume transfers.</li>
                            <li><strong className="text-teal-400">Silver Layer:</strong> Runs modular cleaning Python pipelines implemented in Jupyter notebooks (e.g. `05_cleaning_YYYY.ipynb`). These cleanups handle invalid string entries, perform categorical bin mappings, standardize schema columns, and output clean tables.</li>
                            <li><strong className="text-pink-400">Gold Layer:</strong> Aggregates and consolidates five years of survey datasets into a single physical table (`Gold.Fact_Survey`) mapped to 35 bridge tables. A key optimization is the utilization of a surrogate hash key `ResponseKey` (generated via SHA2_256 over Year + ResponseID) to prevent Descartes inflation.</li>
                          </ul>
                        </div>
                      </div>
                    </div>
                  )}

                  {/* 2. Data Flow details */}
                  {activeDocSection === 'dataflow' && (
                    <div className="max-w-4xl space-y-6 animate-in fade-in slide-in-from-bottom-2 duration-300">
                      <div>
                        <h2 className="text-xl font-bold text-white tracking-wide flex items-center space-x-2.5">
                          <Database className="w-5 h-5 text-pink-400 animate-pulse" />
                          <span>Warehouse Data Flow</span>
                        </h2>
                        <p className="text-xs text-gray-400 mt-1">Detailed flow map from files to consumers (Power BI, ML models, MCP clients).</p>
                      </div>

                      {/* Data Flow Diagram Image */}
                      <div className="bg-[#12131a]/70 p-4 border border-[#1e2030] rounded-2xl flex flex-col items-center shadow-lg group">
                        <img 
                          src="/images/Data Flow DIagram.png" 
                          alt="Data Flow Diagram" 
                          className="rounded-xl border border-white/5 max-h-96 object-contain w-full group-hover:scale-[1.01] transition-transform duration-300"
                        />
                        <span className="text-[10px] text-gray-500 font-mono mt-3">Figure 2.0: SQL Server Warehouse Data Refinement Cycles</span>
                      </div>

                      <div className="p-6 bg-[#12131a] border border-[#1e2030] rounded-2xl space-y-4">
                        <div className="p-4 bg-[#0c0d13] rounded-xl border border-white/5 space-y-3 text-xs">
                          <h4 className="font-semibold text-white">Consolidated Processing Steps:</h4>
                          <div className="space-y-2 text-gray-400">
                            <div className="flex items-center space-x-2">
                              <span className="w-5 h-5 rounded-full bg-blue-500/10 border border-blue-500/20 text-blue-400 flex items-center justify-center font-mono font-bold text-[10px]">1</span>
                              <span><strong>Extract:</strong> Read CSV file schemas dynamically.</span>
                            </div>
                            <div className="flex items-center space-x-2">
                              <span className="w-5 h-5 rounded-full bg-blue-500/10 border border-blue-500/20 text-blue-400 flex items-center justify-center font-mono font-bold text-[10px]">2</span>
                              <span><strong>Transform:</strong> Execute cleaning scripts to normalize category attributes.</span>
                            </div>
                            <div className="flex items-center space-x-2">
                              <span className="w-5 h-5 rounded-full bg-blue-500/10 border border-blue-500/20 text-blue-400 flex items-center justify-center font-mono font-bold text-[10px]">3</span>
                              <span><strong>Load Fact:</strong> Insert rows into `Gold.Fact_Survey` using SQL server MERGE/UPSERT script blocks.</span>
                            </div>
                            <div className="flex items-center space-x-2">
                              <span className="w-5 h-5 rounded-full bg-blue-500/10 border border-blue-500/20 text-blue-400 flex items-center justify-center font-mono font-bold text-[10px]">4</span>
                              <span><strong>Build Views:</strong> Expose Snowflake view layer directly for BI tool ingestion and LLM execution.</span>
                            </div>
                          </div>
                        </div>

                        <p className="text-xs text-gray-300 leading-relaxed">
                          Data moves systematically from yearly survey files into analytical endpoints. Staging raw CSV content in the Bronze SQL schema avoids data corruption during imports. By executing cleanups in python modules (`data_type_converter.py`, `normalizer.py`, and `mapping_categorical.py`) and loading them into SQL refined schemas, we keep database logic clean and optimized. 
                        </p>
                      </div>
                    </div>
                  )}

                  {/* 3. Snowflake Details */}
                  {activeDocSection === 'snowflake_details' && (
                    <div className="max-w-4xl space-y-6 animate-in fade-in slide-in-from-bottom-2 duration-300">
                      <div>
                        <h2 className="text-xl font-bold text-white tracking-wide flex items-center space-x-2.5">
                          <Database className="w-5 h-5 text-pink-400 animate-pulse" />
                          <span>Snowflake Views Schema Layout</span>
                        </h2>
                        <p className="text-xs text-gray-400 mt-1">Full structural mapping of core database fact, dimension, hub, and bridge views.</p>
                      </div>

                      {/* ER Diagram Image */}
                      <div className="bg-[#12131a]/70 p-4 border border-[#1e2030] rounded-2xl flex flex-col items-center shadow-lg group">
                        <img 
                          src="/images/Er Diagram.png" 
                          alt="ER Schema Diagram" 
                          className="rounded-xl border border-white/5 max-h-[500px] object-contain w-full group-hover:scale-[1.01] transition-transform duration-300"
                        />
                        <span className="text-[10px] text-gray-500 font-mono mt-3">Figure 3.0: Snowflake Schema Views Relational ER Diagram</span>
                      </div>

                      <div className="space-y-4">
                        {/* Fact table view details */}
                        <div className="bg-[#12131a] border border-[#1e2030] rounded-2xl overflow-hidden">
                          <button 
                            onClick={() => setExpandedSchemaTable(expandedSchemaTable === 'fact' ? null : 'fact')}
                            className="w-full flex items-center justify-between p-4 bg-[#191b24] hover:bg-[#1f212d] transition-all text-left"
                          >
                            <span className="text-xs font-bold text-white font-mono">Fact View: Snowflake.Fact_Survey_Core</span>
                            <ChevronDown className={`w-4 h-4 text-gray-400 transform transition-transform ${
                              expandedSchemaTable === 'fact' ? 'rotate-180' : ''
                            }`} />
                          </button>
                          {expandedSchemaTable === 'fact' && (
                            <div className="p-4 bg-[#0f1016] text-xs font-mono text-gray-400 divide-y divide-white/5">
                              <div className="py-1.5 flex justify-between"><span className="text-blue-400">ResponseKey (PK)</span><span>VARCHAR(64) - Hashed Surr Key</span></div>
                              <div className="py-1.5 flex justify-between"><span>SurveyYear</span><span>INT</span></div>
                              <div className="py-1.5 flex justify-between"><span>ResponseId</span><span>BIGINT</span></div>
                              <div className="py-1.5 flex justify-between"><span className="text-purple-400">Dim_DemographicsID (FK)</span><span>VARCHAR(64)</span></div>
                              <div className="py-1.5 flex justify-between"><span className="text-purple-400">Dim_EmploymentID (FK)</span><span>VARCHAR(64)</span></div>
                              <div className="py-1.5 flex justify-between"><span className="text-purple-400">Dim_CompensationID (FK)</span><span>VARCHAR(64)</span></div>
                              <div className="py-1.5 flex justify-between"><span className="text-purple-400">Dim_AICentralID (FK)</span><span>VARCHAR(64)</span></div>
                              <div className="py-1.5 flex justify-between"><span className="text-purple-400">Dim_TechCentralID (FK)</span><span>VARCHAR(64)</span></div>
                              <div className="py-1.5 flex justify-between"><span>YearsCode</span><span>BIGINT - Total coding exp</span></div>
                              <div className="py-1.5 flex justify-between"><span>YearsCodePro</span><span>BIGINT - Professional coding exp</span></div>
                            </div>
                          )}
                        </div>

                        {/* Dimension Hub details */}
                        <div className="bg-[#12131a] border border-[#1e2030] rounded-2xl overflow-hidden">
                          <button 
                            onClick={() => setExpandedSchemaTable(expandedSchemaTable === 'dims' ? null : 'dims')}
                            className="w-full flex items-center justify-between p-4 bg-[#191b24] hover:bg-[#1f212d] transition-all text-left"
                          >
                            <span className="text-xs font-bold text-white font-mono">9 Core Star Dimensions</span>
                            <ChevronDown className={`w-4 h-4 text-gray-400 transform transition-transform ${
                              expandedSchemaTable === 'dims' ? 'rotate-180' : ''
                            }`} />
                          </button>
                          {expandedSchemaTable === 'dims' && (
                            <div className="p-4 bg-[#0f1016] text-xs space-y-4">
                              <div>
                                <h5 className="font-semibold text-white font-mono text-[11px] mb-1.5">Dim_Demographics:</h5>
                                <p className="text-[11px] text-gray-400">Columns: Dim_DemographicsID, Country, AgeCode, Gender_Clean, Ethnicity_Clean, Sexuality_Clean, TransGender, Accessibility_Status, Mental_Health_Status, USA_State</p>
                              </div>
                              <div>
                                <h5 className="font-semibold text-white font-mono text-[11px] mb-1.5">Dim_Employment:</h5>
                                <p className="text-[11px] text-gray-400">Columns: Dim_EmploymentID, Current_Profession, EmploymentAddl, Industry, Organization_Size, ICorPM, WorkExp, RemoteWork</p>
                              </div>
                              <div>
                                <h5 className="font-semibold text-white font-mono text-[11px] mb-1.5">Dim_Compensation:</h5>
                                <p className="text-[11px] text-gray-400">Columns: Dim_CompensationID, CompTotal, Compensation_Frequency, ConvertedCompYearly, Currency_Code</p>
                              </div>
                            </div>
                          )}
                        </div>

                        {/* Snowflake Hubs details */}
                        <div className="bg-[#12131a] border border-[#1e2030] rounded-2xl overflow-hidden">
                          <button 
                            onClick={() => setExpandedSchemaTable(expandedSchemaTable === 'hubs' ? null : 'hubs')}
                            className="w-full flex items-center justify-between p-4 bg-[#191b24] hover:bg-[#1f212d] transition-all text-left"
                          >
                            <span className="text-xs font-bold text-white font-mono">Central Hubs & Nested Dimensions</span>
                            <ChevronDown className={`w-4 h-4 text-gray-400 transform transition-transform ${
                              expandedSchemaTable === 'hubs' ? 'rotate-180' : ''
                            }`} />
                          </button>
                          {expandedSchemaTable === 'hubs' && (
                            <div className="p-4 bg-[#0f1016] text-xs space-y-4 text-gray-400 leading-normal">
                              <p>
                                To keep queries normalized and limit column counts in the core fact table, we utilize <strong>Dim_AICentral (AI Hub)</strong> and <strong>Dim_TechCentral (Tech Hub)</strong> as central routing views.
                              </p>
                              <ul className="list-disc list-inside space-y-2 text-gray-400 text-[11px]">
                                <li><strong>Dim_AICentral</strong> maps fact keys to sub-tables containing detailed tool metrics: `Dim_AIAgents`, `Dim_AINext`, `Dim_AIModels`, `Dim_AITools`, and `Dim_AIOpinions`.</li>
                                <li><strong>Dim_TechCentral</strong> maps keys to `Dim_TechDatabases`, `Dim_TechPlatforms`, `Dim_TechLanguagesWeb`, `Dim_TechMiscTools`, `Dim_TechEndorse`, and `Dim_TechOppose`.</li>
                              </ul>
                            </div>
                          )}
                        </div>

                      </div>
                    </div>
                  )}

                  {/* 4. CI/CD Details */}
                  {activeDocSection === 'cicd' && (
                    <div className="max-w-4xl space-y-6 animate-in fade-in slide-in-from-bottom-2 duration-300">
                      <div>
                        <h2 className="text-xl font-bold text-white tracking-wide flex items-center space-x-2.5">
                          <GitBranch className="w-5 h-5 text-pink-400 animate-pulse" />
                          <span>CI/CD & DAG Orchestration</span>
                        </h2>
                        <p className="text-xs text-gray-400 mt-1">Deployment pipelines and Airflow schedule logic.</p>
                      </div>

                      {/* CI/CD Diagram Image */}
                      <div className="bg-[#12131a]/70 p-4 border border-[#1e2030] rounded-2xl flex flex-col items-center shadow-lg group">
                        <img 
                          src="/images/Ci CD.png" 
                          alt="CI CD Diagram" 
                          className="rounded-xl border border-white/5 max-h-96 object-contain w-full group-hover:scale-[1.01] transition-transform duration-300"
                        />
                        <span className="text-[10px] text-gray-500 font-mono mt-3">Figure 4.0: Continuous Integration & Airflow Orchestration Workflow</span>
                      </div>

                      <div className="p-6 bg-[#12131a] border border-[#1e2030] rounded-2xl space-y-4">
                        <h3 className="text-sm font-bold text-white">Airflow Pipeline Schedule</h3>
                        
                        <div className="space-y-4 text-xs text-gray-300">
                          <p>
                            Our pipeline runs on an **Airflow DAG schedule** to automate data refreshing:
                          </p>
                          
                          <div className="grid grid-cols-1 md:grid-cols-5 gap-3 text-center text-[10px] font-semibold text-gray-400">
                            <div className="p-3.5 bg-[#0c0d13] rounded-xl border border-white/5">
                              <div className="text-pink-400 font-bold mb-1">TASK 1</div>
                              Fetch Raw CSV from source staging
                            </div>
                            <div className="p-3.5 bg-[#0c0d13] rounded-xl border border-white/5">
                              <div className="text-pink-400 font-bold mb-1">TASK 2</div>
                              Execute 05_cleaning notebooks
                            </div>
                            <div className="p-3.5 bg-[#0c0d13] rounded-xl border border-white/5">
                              <div className="text-pink-400 font-bold mb-1">TASK 3</div>
                              Run bridge table array explosions
                            </div>
                            <div className="p-3.5 bg-[#0c0d13] rounded-xl border border-white/5">
                              <div className="text-pink-400 font-bold mb-1">TASK 4</div>
                              Load Silver refined data to SQL Server
                            </div>
                            <div className="p-3.5 bg-[#0c0d13] rounded-xl border border-white/5">
                              <div className="text-pink-400 font-bold mb-1">TASK 5</div>
                              Refresh Gold Schema & Views
                            </div>
                          </div>

                          <p className="leading-relaxed mt-2 text-gray-400">
                            The Airflow pipeline automates yearly processing, executing Papermill commands to trigger Jupyter Notebooks cleanups, and calling upsert SQL merge blocks to insert data into physical Gold schemas.
                          </p>
                        </div>
                      </div>
                    </div>
                  )}

                </div>
              </div>
            )}

          </div>          {/* Premium Fashionable Tech Runway Footer */}
          <footer className="hidden lg:block w-full bg-[#0c0d13]/90 border-t border-[#1e2030] py-6 px-8 z-10 shrink-0 select-none relative overflow-hidden">
            <div className="absolute inset-0 cyber-scanner pointer-events-none opacity-30" />
            <div className="max-w-7xl mx-auto flex flex-col lg:flex-row items-center justify-between gap-6 relative z-10">
              
              {/* Left Brand Details */}
              <div className="flex flex-col items-center lg:items-start space-y-1 text-center lg:text-left">
                <div className="flex items-center space-x-2">
                  <BrainCircuit className="w-4 h-4 text-blue-400" />
                  <span className="text-xs font-black tracking-[0.2em] text-white uppercase text-glow-blue">STAC WAREHOUSE ENGINE</span>
                </div>
                <span className="text-[10px] text-gray-500 font-semibold uppercase tracking-wider">
                  Multi-Year Stack Overflow Data Pipeline & AI Integration • © 2026
                </span>
              </div>

              {/* Center Stack Badges */}
              <div className="flex flex-wrap items-center justify-center gap-2">
                <div className="flex items-center space-x-1.5 text-[10px] font-bold font-mono bg-blue-500/10 border border-blue-500/20 text-blue-400 px-3 py-1.5 rounded-xl hover:cyber-glow-blue transition-all duration-300 cursor-help" title="AMD Instinct™ ROCm Hardware Acceleration">
                  <Cpu className="w-3.5 h-3.5 animate-pulse" />
                  <span>ROCm 6.1</span>
                </div>
                <div className="flex items-center space-x-1.5 text-[10px] font-bold font-mono bg-purple-500/10 border border-purple-500/20 text-purple-400 px-3 py-1.5 rounded-xl hover:cyber-glow-purple transition-all duration-300 cursor-help" title="Llama 3.1 70B via Fireworks AI Inference">
                  <Flame className="w-3.5 h-3.5 animate-pulse" />
                  <span>Fireworks AI</span>
                </div>
                <div className="flex items-center space-x-1.5 text-[10px] font-bold font-mono bg-pink-500/10 border border-pink-500/20 text-pink-400 px-3 py-1.5 rounded-xl hover:cyber-glow-pink transition-all duration-300 cursor-help" title="Microsoft SQL Server Bronze/Silver/Gold Storage">
                  <Database className="w-3.5 h-3.5 animate-pulse" />
                  <span>SQL Server</span>
                </div>
                <div className="flex items-center space-x-1.5 text-[10px] font-bold font-mono bg-cyan-500/10 border border-cyan-500/20 text-cyan-400 px-3 py-1.5 rounded-xl hover:cyber-glow-blue transition-all duration-300 cursor-help" title="Vite + React Single Page App Development">
                  <Layers3 className="w-3.5 h-3.5 animate-pulse" />
                  <span>React / Vite</span>
                </div>
                <div className="flex items-center space-x-1.5 text-[10px] font-bold font-mono bg-teal-500/10 border border-teal-500/20 text-teal-400 px-3 py-1.5 rounded-xl hover:cyber-glow-teal transition-all duration-300 cursor-help" title="Tailwind CSS v4 Utility Theme Configuration">
                  <CheckCircle2 className="w-3.5 h-3.5 animate-pulse" />
                  <span>Tailwind v4</span>
                </div>
                <div className="flex items-center space-x-1.5 text-[10px] font-bold font-mono bg-amber-500/10 border border-amber-500/20 text-amber-400 px-3 py-1.5 rounded-xl hover:cyber-glow-purple transition-all duration-300 cursor-help" title="Apache Airflow DAG Ingestion & Papermill execution">
                  <GitBranch className="w-3.5 h-3.5 animate-pulse" />
                  <span>Airflow DAGs</span>
                </div>
              </div>

              {/* Right Pipeline Credits */}
              <div className="text-[10px] text-gray-500 font-medium font-mono text-center lg:text-right uppercase tracking-wider space-y-1">
                <div>INGEST: Bronze Bulk Load</div>
                <div>PROCESS: Jupyter Hub + Miniconda</div>
                <div>SERVE: FastAPI MCP Server</div>
              </div>

            </div>
          </footer>

        </div>

      </main>

      {/* Image Modal Lightbox */}
      {selectedImageModal && (
        <div 
          className="fixed inset-0 bg-black/80 backdrop-blur-sm z-50 flex items-center justify-center p-8 transition-all"
          onClick={() => setSelectedImageModal(null)}
        >
          <div 
            className="max-w-5xl w-full bg-[#12131a] rounded-3xl border border-[#1e2030] overflow-hidden flex flex-col shadow-2xl animate-in fade-in zoom-in duration-200"
            onClick={e => e.stopPropagation()}
          >
            {/* Modal Header */}
            <div className="px-6 py-4.5 border-b border-[#1e2030] flex items-center justify-between bg-[#191b24]">
              <div>
                <h3 className="text-sm font-bold text-white">{selectedImageModal.title}</h3>
                <p className="text-[11px] text-gray-400 mt-0.5">{selectedImageModal.desc}</p>
              </div>
              <button 
                onClick={() => setSelectedImageModal(null)}
                className="text-xs font-bold text-gray-400 hover:text-white px-3 py-1.5 rounded-xl bg-white/5 border border-white/5 hover:bg-white/10 transition-all"
              >
                Close (ESC)
              </button>
            </div>

            {/* Modal Image View */}
            <div className="p-8 bg-[#0a0b10] flex items-center justify-center max-h-[70vh]">
              <img 
                src={selectedImageModal.path} 
                alt={selectedImageModal.title} 
                className="object-contain max-w-full max-h-[60vh] rounded-lg shadow-inner border border-white/5"
              />
            </div>

            {/* Modal Footer Info */}
            <div className="px-6 py-3.5 border-t border-[#1e2030] bg-[#191b24] text-[10px] text-gray-500 font-mono flex items-center justify-between">
              <span>Stack Overflow Survey Analysis</span>
              <span>Pre-Analysed Visuals</span>
            </div>
          </div>
        </div>
      )}

    </div>
  );
}
