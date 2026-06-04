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
  ArrowRight
} from 'lucide-react';
import { 
  BarChart, Bar, LineChart, Line, AreaChart, Area, 
  XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer 
} from 'recharts';

// Schema metadata directory
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
    sql: "SELECT \n  d.Current_Profession AS DevType,\n  ROUND(AVG(c.ConvertedCompYearly), 2) AS AverageSalary\nFROM Snowflake.Fact_Survey_Core f\nJOIN Dim_Employment d ON f.Dim_EmploymentID = d.Dim_EmploymentID\nJOIN Dim_Compensation c ON f.Dim_CompensationID = c.Dim_CompensationID\nWHERE c.ConvertedCompYearly IS NOT NULL\nGROUP BY d.Current_Profession\nORDER BY AverageSalary DESC;",
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
    sql: "SELECT \n  d.Country,\n  d.RemoteWork AS WorkType,\n  ROUND(AVG(c.ConvertedCompYearly), 2) AS AverageSalary\nFROM Snowflake.Fact_Survey_Core f\nJOIN Dim_Demographics d ON f.Dim_DemographicsID = d.Dim_DemographicsID\nJOIN Dim_Employment e ON f.Dim_EmploymentID = e.Dim_EmploymentID\nJOIN Dim_Compensation c ON f.Dim_CompensationID = c.Dim_CompensationID\nWHERE d.Country IN ('United States', 'Germany', 'United Kingdom', 'India')\n  AND d.RemoteWork IS NOT NULL AND c.ConvertedCompYearly IS NOT NULL\nGROUP BY d.Country, d.RemoteWork\nORDER BY d.Country, AverageSalary DESC;",
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
  const [messages, setMessages] = useState([
    {
      sender: 'system',
      text: 'Welcome to the Stack Overflow Warehouse AI Data Analyst. Ask me any analytical question using natural language (e.g., salaries, technology popularity, AI sentiments).',
      timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
    }
  ]);
  const [input, setInput] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [queryHistory, setQueryHistory] = useState([]);
  const [activeTab, setActiveTab] = useState('chat'); // chat, data, chart, pre_analysed
  const [selectedResult, setSelectedResult] = useState(null);
  const [mockMode, setMockMode] = useState(true);
  const [expandedSql, setExpandedSql] = useState({});
  
  // Pre-analyzed dashboard states
  const [activeCategory, setActiveCategory] = useState('demographics');
  const [selectedImageModal, setSelectedImageModal] = useState(null);

  const chatEndRef = useRef(null);

  useEffect(() => {
    chatEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages]);

  const triggerSearch = async (queryText) => {
    if (!queryText.trim()) return;
    
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
        setSelectedResult(mockResponse);
        setQueryHistory(prev => {
          if (!prev.includes(queryText)) return [queryText, ...prev];
          return prev;
        });

        setMessages(prev => [...prev, {
          sender: 'ai',
          text: `I executed an optimized query on the **Snowflake views** schema. Renders can be viewed in the **SQL Data** and **Visual Chart** tabs.`,
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
          setSelectedResult(data);
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

  const currentCategoryObj = PRE_ANALYSED_CATEGORIES.find(cat => cat.id === activeCategory);

  return (
    <div className="flex h-screen bg-[#0a0b10] text-gray-200 overflow-hidden font-sans">
      
      {/* Left Panel: Sidebar Directory & History */}
      <aside className="w-80 bg-[#12131a] border-r border-[#1e2030] flex flex-col z-10 shrink-0">
        <div className="p-5 border-b border-[#1e2030] flex items-center space-x-3">
          <div className="w-10 h-10 rounded-xl bg-gradient-to-tr from-blue-500 to-purple-600 flex items-center justify-center shadow-lg shadow-blue-500/20">
            <BrainCircuit className="w-6 h-6 text-white" />
          </div>
          <div>
            <h1 className="text-md font-bold text-white tracking-wide">AI Data Analyst</h1>
            <p className="text-xs text-gray-400">Stack Overflow Warehouse</p>
          </div>
        </div>

        {/* Directory & Schema Inspector */}
        <div className="flex-1 overflow-y-auto px-4 py-4 space-y-6">
          
          {/* Connection Settings */}
          <div>
            <span className="text-xs font-semibold text-gray-400 uppercase tracking-wider block mb-3">API Server Integration</span>
            <div className="p-3 bg-[#171923] rounded-xl border border-white/5 flex items-center justify-between">
              <span className="text-xs text-gray-300">Offline Mock Mode</span>
              <button 
                onClick={() => setMockMode(!mockMode)}
                className="focus:outline-none transition-colors"
              >
                {mockMode ? (
                  <ToggleRight className="w-10 h-6 text-blue-500" />
                ) : (
                  <ToggleLeft className="w-10 h-6 text-gray-500" />
                )}
              </button>
            </div>
            <p className="text-[10px] text-gray-500 mt-1 px-1">
              {mockMode ? "Demonstration mode with pre-baked responses." : "Queries are dynamically sent to localhost:8000."}
            </p>
          </div>

          {/* Quick Prompts */}
          <div>
            <span className="text-xs font-semibold text-gray-400 uppercase tracking-wider block mb-2">Quick SQL Queries</span>
            <div className="space-y-2">
              {MOCK_PROMPTS.map((promptText, i) => (
                <button
                  key={i}
                  onClick={() => {
                    setActiveTab('chat');
                    triggerSearch(promptText);
                  }}
                  className="w-full text-left text-xs bg-[#171923] hover:bg-white/5 border border-white/5 hover:border-white/10 rounded-xl p-3 text-gray-300 hover:text-white transition-all line-clamp-2"
                >
                  {promptText}
                </button>
              ))}
            </div>
          </div>

          {/* Schema Directories */}
          <div>
            <div className="flex items-center space-x-2 mb-2">
              <Database className="w-4 h-4 text-purple-400" />
              <span className="text-xs font-semibold text-gray-400 uppercase tracking-wider">Snowflake Views</span>
            </div>
            <div className="space-y-1.5 max-h-56 overflow-y-auto pr-1">
              {MOCK_SCHEMAS.views.map((schema, idx) => (
                <div 
                  key={idx}
                  className="p-2 bg-white/2 hover:bg-white/5 rounded-lg border border-white/5 cursor-help transition-all group"
                  title={schema.description}
                >
                  <div className="text-[11px] font-mono text-gray-300 group-hover:text-blue-400 transition-colors truncate">
                    {schema.name}
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* History Logger */}
        {queryHistory.length > 0 && (
          <div className="p-4 border-t border-[#1e2030] bg-[#0c0d13]">
            <div className="flex items-center space-x-2 text-xs font-semibold text-gray-400 uppercase tracking-wider mb-2">
              <History className="w-3.5 h-3.5" />
              <span>Query History</span>
            </div>
            <div className="space-y-1.5 max-h-32 overflow-y-auto pr-1">
              {queryHistory.map((hist, idx) => (
                <button
                  key={idx}
                  onClick={() => triggerSearch(hist)}
                  className="w-full text-left text-[11px] text-gray-400 hover:text-white truncate bg-[#171923] hover:bg-white/5 rounded px-2.5 py-1.5 border border-white/5 transition-all"
                >
                  {hist}
                </button>
              ))}
            </div>
          </div>
        )}
      </aside>

      {/* Main Workspace */}
      <main className="flex-1 flex flex-col bg-[#0a0b10] overflow-hidden relative">
        
        {/* Top Navigation */}
        <header className="h-16 border-b border-[#1e2030] bg-[#12131a]/80 backdrop-blur-md px-6 flex items-center justify-between z-10 shrink-0">
          <div className="flex items-center space-x-3 overflow-x-auto pr-4 scrollbar-none">
            <button
              onClick={() => setActiveTab('chat')}
              className={`flex items-center space-x-2 text-sm font-semibold px-4 py-2 rounded-xl transition-all whitespace-nowrap shrink-0 ${
                activeTab === 'chat' 
                  ? 'bg-blue-500/10 text-blue-400 border border-blue-500/20 shadow-inner' 
                  : 'text-gray-400 hover:text-white hover:bg-white/5'
              }`}
            >
              <MessageSquare className="w-4 h-4" />
              <span>AI Chat Assistant</span>
            </button>
            <button
              onClick={() => setActiveTab('data')}
              disabled={!selectedResult}
              className={`flex items-center space-x-2 text-sm font-semibold px-4 py-2 rounded-xl transition-all whitespace-nowrap shrink-0 ${
                !selectedResult ? 'opacity-40 cursor-not-allowed' : ''
              } ${
                activeTab === 'data' 
                  ? 'bg-purple-500/10 text-purple-400 border border-purple-500/20 shadow-inner' 
                  : 'text-gray-400 hover:text-white hover:bg-white/5'
              }`}
            >
              <Database className="w-4 h-4" />
              <span>SQL Data Grid</span>
            </button>
            <button
              onClick={() => setActiveTab('chart')}
              disabled={!selectedResult}
              className={`flex items-center space-x-2 text-sm font-semibold px-4 py-2 rounded-xl transition-all whitespace-nowrap shrink-0 ${
                !selectedResult ? 'opacity-40 cursor-not-allowed' : ''
              } ${
                activeTab === 'chart' 
                  ? 'bg-purple-500/10 text-purple-400 border border-purple-500/20 shadow-inner' 
                  : 'text-gray-400 hover:text-white hover:bg-white/5'
              }`}
            >
              <BarChart3 className="w-4 h-4" />
              <span>Visual Chart</span>
            </button>
            <button
              onClick={() => setActiveTab('pre_analysed')}
              className={`flex items-center space-x-2 text-sm font-semibold px-4 py-2 rounded-xl transition-all whitespace-nowrap shrink-0 ${
                activeTab === 'pre_analysed' 
                  ? 'bg-teal-500/10 text-teal-400 border border-teal-500/20 shadow-inner' 
                  : 'text-gray-400 hover:text-white hover:bg-white/5'
              }`}
            >
              <Grid className="w-4 h-4" />
              <span>Pre-Analysed Dashboard</span>
            </button>
          </div>

          {selectedResult && activeTab !== 'pre_analysed' && (
            <button
              onClick={downloadCSV}
              className="flex items-center space-x-1.5 text-xs text-gray-300 hover:text-white bg-white/5 hover:bg-white/10 px-3 py-1.5 rounded-lg border border-white/5 transition-all shrink-0"
            >
              <Download className="w-3.5 h-3.5" />
              <span>Export CSV</span>
            </button>
          )}
        </header>

        {/* Workspace Body */}
        <div className="flex-1 overflow-hidden relative">
          
          {/* Tab 1: Chat Assistant */}
          {activeTab === 'chat' && (
            <div className="absolute inset-0 flex flex-col bg-[#0a0b10]">
              
              {/* Message Panel */}
              <div className="flex-1 overflow-y-auto px-8 py-6 space-y-6">
                {messages.map((msg, idx) => (
                  <div 
                    key={idx}
                    className={`flex flex-col max-w-[80%] ${
                      msg.sender === 'user' ? 'ml-auto items-end' : 'mr-auto items-start'
                    }`}
                  >
                    <div className="flex items-center space-x-2 mb-1.5 text-xs text-gray-500">
                      {msg.sender === 'ai' && <Sparkles className="w-3.5 h-3.5 text-blue-400" />}
                      <span className="font-semibold text-gray-400">
                        {msg.sender === 'user' ? 'You' : msg.sender === 'system' ? 'System' : 'Survey Analyst'}
                      </span>
                      <span>•</span>
                      <span>{msg.timestamp}</span>
                    </div>

                    <div className={`p-4 rounded-2xl text-sm leading-relaxed border ${
                      msg.sender === 'user' 
                        ? 'bg-blue-600 text-white border-blue-500 shadow-lg shadow-blue-600/10 rounded-tr-none' 
                        : msg.sender === 'system'
                        ? 'bg-white/2 text-gray-400 border-white/5'
                        : 'bg-[#12131a] text-gray-300 border-[#1e2030] rounded-tl-none shadow-md'
                    }`}>
                      {msg.text}

                      {/* Display Staged SQL script */}
                      {msg.sql && (
                        <div className="mt-3.5 rounded-xl border border-white/5 overflow-hidden">
                          <button
                            onClick={() => toggleSqlExpand(idx)}
                            className="w-full flex items-center justify-between bg-[#191b24] hover:bg-[#1f212d] px-3.5 py-2 text-xs font-mono text-blue-400 transition-all border-b border-white/5"
                          >
                            <span className="flex items-center space-x-2">
                              <Terminal className="w-3.5 h-3.5" />
                              <span>Generated SQL Query</span>
                            </span>
                            <ChevronRight className={`w-3.5 h-3.5 transform transition-transform ${
                              expandedSql[idx] ? 'rotate-90' : ''
                            }`} />
                          </button>
                          {expandedSql[idx] && (
                            <pre className="bg-[#0f1016] p-4 text-xs font-mono text-gray-300 overflow-x-auto select-all leading-normal">
                              {msg.sql}
                            </pre>
                          )}
                        </div>
                      )}
                    </div>
                  </div>
                ))}
                
                {isLoading && (
                  <div className="flex flex-col max-w-[80%] mr-auto items-start">
                    <div className="flex items-center space-x-2 mb-1.5 text-xs text-gray-500">
                      <RefreshCw className="w-3.5 h-3.5 text-blue-400 animate-spin" />
                      <span className="font-semibold text-gray-400 animate-pulse">Analyst is writing query...</span>
                    </div>
                    <div className="p-4 bg-[#12131a] text-gray-500 border border-[#1e2030] rounded-2xl rounded-tl-none animate-pulse">
                      Analyzing table layouts, indices, and views to fetch correct records...
                    </div>
                  </div>
                )}
                
                <div ref={chatEndRef} />
              </div>

              {/* Chat Input Container */}
              <div className="p-6 border-t border-[#1e2030] bg-[#12131a]/80 backdrop-blur-md">
                <form 
                  onSubmit={(e) => {
                    e.preventDefault();
                    triggerSearch(input);
                  }}
                  className="flex items-center space-x-3 max-w-4xl mx-auto relative bg-[#0a0b10] border border-[#1e2030] rounded-2xl px-4.5 py-3 shadow-inner group focus-within:border-blue-500/50 transition-all"
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
                    className="p-1.5 bg-blue-500 hover:bg-blue-600 text-white rounded-xl shadow-md shadow-blue-500/10 hover:scale-105 active:scale-95 transition-all shrink-0"
                  >
                    <Send className="w-4 h-4" />
                  </button>
                </form>
              </div>

            </div>
          )}

          {/* Tab 2: SQL Data Grid */}
          {activeTab === 'data' && selectedResult && (
            <div className="absolute inset-0 p-6 flex flex-col overflow-hidden bg-[#0a0b10]">
              <div className="flex-1 border border-[#1e2030] rounded-2xl bg-[#12131a] overflow-hidden flex flex-col">
                
                {/* Scrollable Table View */}
                <div className="flex-1 overflow-auto">
                  <table className="w-full text-left border-collapse text-xs text-gray-300">
                    <thead>
                      <tr className="bg-[#171923] border-b border-[#1e2030] text-gray-400 font-semibold uppercase tracking-wider">
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
            <div className="absolute inset-0 p-6 flex flex-col overflow-hidden bg-[#0a0b10]">
              <div className="flex-1 border border-[#1e2030] rounded-2xl bg-[#12131a] p-6 flex flex-col">
                
                {/* Title and Controls */}
                <div className="flex items-center justify-between mb-6">
                  <div>
                    <h3 className="text-md font-bold text-white">Query Insights</h3>
                    <p className="text-xs text-gray-400">Active visualization: {selectedResult.xAxis} vs {selectedResult.yAxis}</p>
                  </div>
                  <div className="flex items-center space-x-2 bg-white/5 p-1 rounded-xl border border-white/5">
                    <div className="px-3 py-1 bg-blue-500/10 text-blue-400 text-xs font-semibold rounded-lg border border-blue-500/20">
                      {selectedResult.chartType.toUpperCase()} CHART
                    </div>
                  </div>
                </div>

                {/* Recharts Container */}
                <div className="flex-1 w-full min-h-[300px]">
                  <ResponsiveContainer width="100%" height="100%">
                    {selectedResult.chartType === 'line' ? (
                      <LineChart data={selectedResult.rows} margin={{ top: 10, right: 30, left: 10, bottom: 5 }}>
                        <CartesianGrid strokeDasharray="3 3" stroke="#1e2030" />
                        <XAxis dataKey={selectedResult.xAxis} stroke="#6b7280" style={{ fontSize: 11 }} />
                        <YAxis stroke="#6b7280" style={{ fontSize: 11 }} />
                        <Tooltip contentStyle={{ backgroundColor: '#12131a', borderColor: '#1e2030', color: '#f3f4f6' }} />
                        <Legend />
                        <Line type="monotone" dataKey={selectedResult.yAxis} stroke="#3b82f6" strokeWidth={2.5} activeDot={{ r: 8 }} />
                      </LineChart>
                    ) : (
                      <BarChart data={selectedResult.rows} margin={{ top: 10, right: 30, left: 10, bottom: 5 }}>
                        <CartesianGrid strokeDasharray="3 3" stroke="#1e2030" />
                        <XAxis dataKey={selectedResult.xAxis} stroke="#6b7280" style={{ fontSize: 11 }} />
                        <YAxis stroke="#6b7280" style={{ fontSize: 11 }} />
                        <Tooltip contentStyle={{ backgroundColor: '#12131a', borderColor: '#1e2030', color: '#f3f4f6' }} />
                        <Legend />
                        <Bar dataKey={selectedResult.yAxis} fill="#8b5cf6" radius={[4, 4, 0, 0]} />
                      </BarChart>
                    )}
                  </ResponsiveContainer>
                </div>

              </div>
            </div>
          )}

          {/* Tab 4: Pre-Analysed Dashboard */}
          {activeTab === 'pre_analysed' && (
            <div className="absolute inset-0 flex bg-[#0a0b10] overflow-hidden">
              
              {/* Category sub-navigation */}
              <div className="w-60 bg-[#12131a]/60 border-r border-[#1e2030] flex flex-col p-4 space-y-1.5 shrink-0 overflow-y-auto">
                <span className="text-[10px] font-semibold text-gray-500 uppercase tracking-widest block px-2.5 mb-2">Notebook Chapters</span>
                {PRE_ANALYSED_CATEGORIES.map(category => (
                  <button
                    key={category.id}
                    onClick={() => setActiveCategory(category.id)}
                    className={`w-full text-left text-xs font-semibold px-3 py-2.5 rounded-xl transition-all truncate flex items-center justify-between ${
                      activeCategory === category.id
                        ? 'bg-teal-500/10 text-teal-400 border border-teal-500/20'
                        : 'text-gray-400 hover:text-white hover:bg-white/5'
                    }`}
                  >
                    <span>{category.name}</span>
                    <ChevronRight className="w-3.5 h-3.5 opacity-60" />
                  </button>
                ))}
              </div>

              {/* Main Images Grid */}
              <div className="flex-1 p-6 overflow-y-auto bg-[#0a0b10]">
                <div className="mb-6">
                  <h2 className="text-lg font-bold text-white tracking-wide">{currentCategoryObj.name}</h2>
                  <p className="text-xs text-gray-400">Jupyter analysis outputs and visualizations from the Exploratory Data Analysis module.</p>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                  {currentCategoryObj.charts.map(chart => (
                    <div 
                      key={chart.id}
                      className="group bg-[#12131a] rounded-2xl border border-[#1e2030] hover:border-teal-500/30 overflow-hidden flex flex-col cursor-pointer transition-all hover:scale-[1.01] hover:shadow-lg hover:shadow-teal-500/5"
                      onClick={() => setSelectedImageModal(chart)}
                    >
                      {/* Image Thumbnail */}
                      <div className="relative aspect-video bg-[#0f1016] border-b border-[#1e2030] overflow-hidden flex items-center justify-center">
                        <img 
                          src={chart.path} 
                          alt={chart.title}
                          className="object-contain w-full h-full group-hover:scale-105 transition-transform duration-300"
                        />
                        <div className="absolute inset-0 bg-[#0a0b10]/60 opacity-0 group-hover:opacity-100 flex items-center justify-center transition-opacity duration-200">
                          <div className="flex items-center space-x-1.5 text-xs text-teal-400 bg-teal-500/10 border border-teal-500/20 px-3 py-1.5 rounded-xl font-semibold">
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
                        <div className="flex items-center text-[10px] text-gray-500 mt-3 font-mono">
                          <span>{chart.path.split('/').pop()}</span>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              </div>

            </div>
          )}

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
              <span>Source Path: Exploratory Data Analysis/images/{selectedImageModal.path.split('/').pop()}</span>
              <span>Stack Overflow Survey Analysis</span>
            </div>
          </div>
        </div>
      )}

    </div>
  );
}
