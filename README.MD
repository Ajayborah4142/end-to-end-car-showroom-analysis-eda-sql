# 🚗 Car Showroom Data Analysis using SQL  

## 📊 Project Overview
This project analyzes a **car showroom database** to uncover insights about **sales performance, customer behavior, inventory management, and profitability**.  
The analysis was performed entirely using **MySQL**, applying **joins, subqueries, window functions, and aggregate analysis** to generate 30 key business insights.

---

## 🧩 Database Structure

**Database:** `Car_ShowRoom`

| Table | Description |
|--------|--------------|
| **cars** | Contains details of each car model — brand, model, year, price, engine type, stock, etc. |
| **customers** | Customer demographics and contact information. |
| **sales** | Sales transactions linking customers and cars, including date, price, payment method, and salesperson. |

---

## 🗂️ Data Loading
Data was imported from local CSV files using the `LOAD DATA LOCAL INFILE` command.

```sql
LOAD DATA LOCAL INFILE 'C:/Users/.../Cars.csv' INTO TABLE cars;
LOAD DATA LOCAL INFILE 'C:/Users/.../Customers.csv' INTO TABLE customers;
LOAD DATA LOCAL INFILE 'C:/Users/.../Sales.csv' INTO TABLE sales;
```

---

## 📈 1. Sales Performance & Revenue Insights

| # | Analysis Question | Key Finding |
|---|-------------------|-------------|
| 1️⃣ | **Total revenue generated** | 💰 **$1,146,524,572.66** total sales revenue |
| 2️⃣ | **Top Brand & Model** | 🚗 **Toyota Camry – $73.6M** |
| 3️⃣ | **Best Month & Year for Sales** | 📅 **October 2011 – 93 cars sold** |
| 4️⃣ | **Average Sale Price** | 💵 **$57,421.35** |
| 5️⃣ | **Top 5 Salespersons** | 🏆 Monica Potter, Kevin Webster, Samuel Rodriguez, etc. |
| 6️⃣ | **Top 5 Sold Models** | 🔥 Sunny (1326), Model X (1296), Camry (1266), GLA (1173), Qashqai (1093) |
| 7️⃣ | **Most Preferred Payment Method** | 💳 Installment (3395) |
| 8️⃣ | **Average Quantity per Sale** | 🧾 1.99 cars/transaction |
| 9️⃣ | **Cars Sold vs Stock** | 📦 19,979 sold vs 99,903 in stock |
| 🔟 | **Most vs Least Sold Color** | 🎨 Black (3918) vs Silver (2821) |

---

## 👥 2. Customer Insights & Segmentation

| # | Analysis Question | Key Finding |
|---|-------------------|-------------|
| 11️⃣ | **Average Age of Buyers** | 👤 44.33 years |
| 12️⃣ | **Top City by Sales** | 🏙️ Port Christopher – $2.8M revenue |
| 13️⃣ | **Repeat Customers** | 🔁 9,924 repeat customers |
| 14️⃣ | **Gender vs Car Price** | ⚖️ Both genders buy equally priced cars |
| 15️⃣ | **Top Age Group** | 📊 25–40 years |
| 16️⃣ | **Highest Spending Customers** | 💎 1,986 high-value customers |
| 17️⃣ | **Highest Avg Purchase City** | 🏘️ 1,851 unique cities analyzed |
| 18️⃣ | **New vs Returning Customers** | 🆕 90 new vs 🔁 1910 returning customers |
| 19️⃣ | **Most Preferred Engine Type** | ⚙️ 2,681 purchases for top engine type |
| 20️⃣ | **Transmission Preference (Age)** | 👴 Older: Manual (3135), 👶 Younger: Manual (2008) |

---

## 🏭 3. Inventory & Stock Management

| # | Analysis Question | Key Finding |
|---|-------------------|-------------|
| 21️⃣ | **Low Stock (<5 units)** | ⚠️ 117 low-stock models |
| 22️⃣ | **Unsold Cars (Zero Sales)** | ✅ None — all cars sold at least once |
| 23️⃣ | **Total Inventory Value** | 💰 $291,920,325.69 |
| 24️⃣ | **Avg Time to Sell (Years)** | ⏱️ -4.11 years (newer models sold faster) |
| 25️⃣ | **Fastest Turnover Models** | ⚡ Nissan Altima, Qashqai, Tesla Model S |
| 26️⃣ | **Stockout Trends** | 🎯 Frequent for Tesla (Red), Hyundai (Gray), BMW (White) |

---

## 💹 4. Profitability & Growth Insights

| # | Analysis Question | Key Finding |
|---|-------------------|-------------|
| 27️⃣ | **Highest Profit Margin Model** | 💸 BMW 5 Series – Avg Margin $10,536 |
| 28️⃣ | **Monthly Sales Trend** | 📆 366 months of data analyzed |
| 29️⃣ | **Most Consistent Salesperson** | 👔 9,997 salesperson-month records analyzed |
| 30️⃣ | **Top 3 Growth Strategies** | 🚀 See below |

---

## 🧠 Top 3 Data-Driven Strategies to Boost Sales

1️⃣ **Target High-Value Customers**  
   Focus marketing on top spenders (over $700K–$1M). Offer loyalty programs and exclusive deals.  

2️⃣ **Restock & Promote Fast-Selling Models**  
   Keep inventory of bestsellers (Sunny, Camry, Model X) consistent to prevent missed sales.  

3️⃣ **Promote Low-Performing Brands**  
   Brands like Hyundai and Toyota have large stock but low sales — discount offers and financing could help.  

---

## 🧰 Tools & Technologies

| Category | Tools / Concepts |
|-----------|------------------|
| **Database** | MySQL |
| **Data Loading** | `LOAD DATA LOCAL INFILE` |
| **SQL Techniques** | Joins, Subqueries, Aggregations, Window Functions |
| **Data Types Used** | VARCHAR, INT, FLOAT, DATE |
| **Analysis Focus Areas** | Sales, Customers, Inventory, Profitability |

---

## 📂 Project Files

| File | Description |
|------|--------------|
| `Car_ShowRoom.sql` | Full SQL script: schema creation, data load, and queries |
| `Cars.csv` | Car dataset |
| `Customers.csv` | Customer dataset |
| `Sales.csv` | Sales transaction dataset |
| `README.md` | Documentation file |

---

## 🏁 Key Business Takeaways

- The showroom generated **over $1.14B in total revenue**.  
- **Toyota Camry** and **Sunny** are the top-selling models.  
- **Returning customers** drive the majority of sales.  
- **Installments** are the preferred payment option.  
- **Black cars** dominate the market.  
- **Nissan & Tesla** models sell fastest.  
- **BMW 5 Series** delivers the **highest profit margin**.  

---

## 💡 Future Enhancements

- Build interactive dashboards with **Power BI / Tableau**.  
- Extend analysis with **Python (Pandas, Matplotlib)**.  
- Include **cost and profit tracking**.  
- Apply **machine learning** for sales forecasting.  

---

## 👨‍💻 Author

**Ajay Borah**  
📧 Email: [Your Email Here]  
💼 GitHub: [https://github.com/yourusername](https://github.com/yourusername)  
🧠 Passionate about SQL, data analytics, and business insights.  

---

⭐ *If you find this project useful, don’t forget to star the repository!*