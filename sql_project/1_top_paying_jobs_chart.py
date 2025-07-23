import pandas as pd
import matplotlib.pyplot as plt

# Wczytanie danych
df = pd.read_csv("1_top_paying_jobs.csv")

# Top 10 stanowisk o najwyższej średniej pensji
top_jobs = (
    df.groupby("job_title")["salary_year_avg"]
    .mean()
    .sort_values(ascending=False)
    .head(10)
)

# Top 10 firm o najwyższej średniej pensji
top_companies = (
    df.groupby("company_name")["salary_year_avg"]
    .mean()
    .sort_values(ascending=False)
    .head(10)
)

# Ustawienia wykresu
plt.style.use("seaborn-vignette")
fig, axes = plt.subplots(nrows=1, ncols=2, figsize=(16, 6))

# Wykres 1: Stanowiska
top_jobs.sort_values().plot(kind='barh', ax=axes[0], color='skyblue')
axes[0].set_title("💼 Top 10 Highest-Paying Job Titles")
axes[0].set_xlabel("Average Salary (USD)")
axes[0].set_ylabel("Job Title")

# Wykres 2: Firmy
top_companies.sort_values().plot(kind='barh', ax=axes[1], color='lightgreen')
axes[1].set_title("🏢 Top 10 Companies by Avg Salary")
axes[1].set_xlabel("Average Salary (USD)")
axes[1].set_ylabel("Company")

# Wyświetlenie wykresów
plt.tight_layout()
plt.show()
