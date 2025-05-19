# 📺 YouTube Trending Analytics

Analyze global YouTube trending videos to uncover insights on viewer engagement, sentiment in titles and tags, regional trends, and genre popularity.

## 📌 Overview

This project explores a multi-country YouTube trending dataset to:

- Identify top trending video categories
- Perform sentiment analysis on video titles and tags using VADER NLP
- Rank categories by views using SQL
- Visualize time-series trends and regional differences with Power BI
- Create a professional dashboard for storytelling and insights

## 🧰 Tools & Technologies

- Python (pandas, seaborn, matplotlib)
- Natural Language Toolkit (VADER Sentiment)
- SQL (PostgreSQL)
- Power BI (Data visualization & dashboarding)
- Jupyter Notebook (.ipynb)
- Dataset: CSV from Kaggle

## 📁 Dataset

- Source: [YouTube Trending Videos Dataset (Kaggle)](https://www.kaggle.com/datasets/thedevastator/youtube-trending-videos-dataset)
- Description: Trending video data from multiple countries including title, category, views, likes, tags, publish time, and more.


## 📊 Power BI Dashboard Pages

1. 📌 Global Overview – KPIs, top categories, trending durations  
2. 🌍 Country Comparison – Views, likes, and category breakdown by country  
3. 💬 Sentiment Analysis – VADER-based compound scores on titles and tags  
4. 👤 Channel Insights – Top creators, upload frequency, and engagement  

---

## 💬 Sentiment Analysis

We used the VADER sentiment model to calculate emotional tone in:

- 🎯 Video Titles → `title_compound`  
- 🏷️ Video Tags → `tags_compound`

These were added as new columns in the dataset to analyze how sentiment correlates with views and likes.

---

## 📈 Key Insights

- ✅ Videos with positive titles and tags generally receive more engagement  
- 🎵 Music and Entertainment dominate the trending categories  
- 🌐 Regional differences in category preferences and trending durations  
- 👥 Creators with consistent uploads and emotional language perform better  

---

## 📄 How to Use

1. Clone the repository  
2. Run `sentiment_analysis.ipynb` to preprocess and analyze sentiment  
3. Load the output CSV in Power BI using the provided `.pbix` file  
4. Explore the dashboard for insights across countries, categories, and sentiments  

---

## ✅ Deliverables

- ☑ Power BI Dashboard  
- ☑ Sentiment Analysis (VADER NLP)  
- ☑ SQL Category Rankings  
- ☑ Data Storytelling Presentation (PPTX)  
- ☑ Project Summary Document (DOCX)
  
---

## 📂 Project Structure

```bash
├── sentiment_analysis.ipynb     # Python code for cleaning and sentiment analysis
├── yout.sql                     # SQL queries for category ranking and aggregation
├── YouTube_Trending.pbix        # Power BI dashboard (4 pages)
├── youtube_with_sentiment.csv   # Enriched dataset with sentiment scores
├── Youtube_Trending_Storytelling_Presentation.pptx  # Final presentation
└── YouTube_Trending_Project_Overview.docx           # Project overview document
