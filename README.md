# IBM HR Employee Attrition Analysis

## 📌 Project Overview
This project analyzes employee attrition using the IBM HR Analytics Employee Attrition dataset. The goal is to identify key factors associated with employee turnover and provide actionable insights to help HR teams improve employee retention.

## 🎯 Objectives
- Analyze overall employee attrition rates.
- Identify high-attrition departments and job roles.
- Investigate the impact of overtime, salary, and work-life balance.
- Explore relationships between employee characteristics and attrition.
- Build a Logistic Regression model to predict employee attrition.
- Provide data-driven recommendations for employee retention.

## 📊 Dataset
- **Dataset:** IBM HR Analytics Employee Attrition & Performance
- **Records:** 1,470 employees
- **Features:** 35 columns

## 🛠️ Tools & Technologies
- Python
- Pandas and NumPy
- Matplotlib and Seaborn
- Scikit-learn
- Jupyter Notebook / Google Colab

## 🔍 Project Workflow
1. **Data Exploration:** Examined dataset structure, data types, missing values, and duplicates.
2. **Data Cleaning:** Removed constant and irrelevant columns and created a binary attrition flag.
3. **Exploratory Data Analysis:** Analyzed employee demographics, departments, job roles, monthly income, overtime, and work-life balance.
4. **Data Visualization:** Created charts to identify attrition patterns and relationships.
5. **Machine Learning:** Trained a Logistic Regression model and evaluated it using accuracy, classification reports, and a confusion matrix.

## 💡 Key Findings
- Approximately **16% of employees** left the organization.
- Sales Representatives had the highest attrition rate among job roles.
- Employees who left generally had lower monthly incomes.
- Overtime and work-life balance showed potential associations with attrition.
- The Logistic Regression model had low recall for employees who left, highlighting the challenge of predicting the minority class.

## 📈 Business Recommendations
- Review compensation and career growth opportunities for high-attrition roles.
- Monitor overtime and workload distribution.
- Improve work-life balance and employee engagement.
- Use additional evaluation metrics and class-imbalance techniques to improve attrition prediction.

## 🚀 How to Run
1. Clone or download this repository.
2. Install the required libraries:

   ```bash
   pip install pandas numpy matplotlib seaborn scikit-learn
   ```

3. Place `HR_Employee_Attrition.csv` in the appropriate working directory.
4. Open `HR_project(2).ipynb` in Jupyter Notebook or Google Colab.
5. Run the notebook cells sequentially.

## 📁 Project Structure

```text
IBM-HR-Attrition-Analysis/
├── HR_project(2).ipynb
├── HR_Employee_Attrition.csv
└── README.md
```

## 🏁 Conclusion
This project demonstrates how Python-based data analysis and machine learning can help uncover employee attrition patterns. The findings provide a starting point for HR teams to develop targeted retention strategies, while the predictive model highlights opportunities for further improvement.

---
**Skills Demonstrated:** Data Cleaning, Exploratory Data Analysis, Data Visualization, Feature Engineering, Classification, Model Evaluation, and Business Insight Generation.
