# Sales Data Analysis (SQL)

A beginner friendly sales analysis project built with SQLite. **This is illustrative sample data for learning SQL; it is not actual business data.** The records reproduce the practice dataset and results shown in the project screenshots.

## Files

- `schema.sql` creates the relational tables.
- `insert_data.sql` inserts 8 customers, 8 products, and 15 sales transactions (28 total units).
- `analysis_queries.sql` contains 22 analysis queries.

## Setup

With SQLite 3 installed, run these commands from the repository folder:

```sh
sqlite3 sales_analysis.db < schema.sql
sqlite3 sales_analysis.db < insert_data.sql
sqlite3 sales_analysis.db < analysis_queries.sql
```

The last command runs every query in order. To explore individually, open `sales_analysis.db` in a SQLite viewer and run a selected query from `analysis_queries.sql`.

## Tables

| Table | Contents | Key columns |
|---|---|---|
| `customers` | 8 sample customers and their cities | `customer_id`, `customer_name`, `city` |
| `products` | 8 sample products, category, unit price | `product_id`, `product_name`, `category`, `price` |
| `sales` | 15 dated transactions | `sale_id`, `customer_id`, `product_id`, `quantity`, `sale_date` |

The `sales` table references customers and products by ID. Revenue is calculated as `quantity * price`. Dates are stored as ISO `YYYY-MM-DD` text so SQLite date functions can read them.

## Analysis questions

The queries explore:

- Overall order count, units sold, revenue, and average transaction value
- Product and category performance and revenue share
- Revenue by city and month
- Customer spend, above average spend, and repeat purchases
- Unsold products and transaction values above a threshold
- Top and second-highest products using `LIMIT` and `OFFSET`
- Monthly revenue classification with `CASE`
- Cumulative revenue with a window function

## Verified findings

The aggregate results match the supplied screenshots and final summary. The final sales row (sale 1015, Arjun buying 2 Water Bottles) is reconstructed from the reported totals and product counts; its exact date was not visible, so `2026-02-20` is an illustrative date within February.

- 15 transactions, 28 units sold, and 8 unique customers
- Total revenue: **₹166,500**; average transaction value: **₹11,100**
- Monthly revenue: **January 2026 ₹148,600** and **February 2026 ₹17,900**
- Aarav spent ₹60,000; Arjun spent ₹56,000; all 7 customers other than Meera made 2 purchases, and Meera made 1
- Laptop generated ₹110,000 (66.07% of revenue), Office Chair ₹19,500, and Desk ₹18,000
- Hyderabad generated ₹70,600 and Bangalore ₹70,500 in city revenue
- Electronics generated ₹126,000 in category revenue

## Technologies

- SQLite 3
- SQL: `SELECT`, `WHERE`, `ORDER BY`, aggregates, `GROUP BY`/`HAVING`, `INNER JOIN`/`LEFT JOIN`, subqueries, `CASE`, `strftime`, `LIMIT`/`OFFSET`, and window functions

## Upload to GitHub

1. Create a new empty GitHub repository, for example `sales-data-analysis`.
2. Add `README.md`, `schema.sql`, `insert_data.sql`, and `analysis_queries.sql` through GitHub's web upload interface, or use Git locally to commit and push the four files.
3. Confirm the README appears on the repository page.

The files are prepared locally; nothing has been published to GitHub.

