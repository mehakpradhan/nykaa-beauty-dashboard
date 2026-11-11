"""
Nykaa Beauty Product Analysis - Data Cleaning
Reads the raw file, cleans it with pandas and saves nykaa_clean.csv

Keep this script in the same folder as the data file.
"""
import pandas as pd

RAW_FILE = "nykaa_final_data (1).xlsx"   # change the name if your file is different

df = pd.read_excel(RAW_FILE)             # for a .csv file use pd.read_csv(RAW_FILE)
print("Shape:", df.shape)
print(df.isnull().sum())

# 1. Fix text columns (NARS and nars are the same brand)
for col in ["brand", "product_name", "category"]:
    df[col] = df[col].str.strip().str.lower()

# 2. Remove duplicate rows
df = df.drop_duplicates()

# 3. Fill missing ratings with the median
df["rating"] = df["rating"].fillna(df["rating"].median())

# 4. Recalculate revenue (reviews are used as a sales proxy)
df["revenue"] = (df["price"] * df["reviews"]).round(2)

# 5. Quick checks
print("Total reviews :", df["reviews"].sum())
print("Average price :", round(df["price"].mean(), 2))
print("Unique brands :", df["brand"].nunique())

df.to_csv("nykaa_clean.csv", index=False)
print("nykaa_clean.csv saved")
