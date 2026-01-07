# SQL Server Data Warehouse (Bronze / Silver / Gold)

End-to-end SQL Server DWH project that loads CSV-based CRM/ERP extracts into **Bronze (raw)**, cleans them into **Silver**, then serves **Gold** business-ready **views** for BI/reporting. :contentReference[oaicite:0]{index=0}

## Architecture
Sources (CRM, ERP CSV files) → **Bronze tables** → **Silver tables** → **Gold views** → BI / ad-hoc SQL. :contentReference[oaicite:1]{index=1}

## Layers
- **Bronze (Tables):** raw as-is, **Full Load (Truncate & Insert)**, no transformations. :contentReference[oaicite:2]{index=2}
- **Silver (Tables):** cleaned/standardized, **Full Load (Truncate & Insert)**. :contentReference[oaicite:3]{index=3}
- **Gold (Views):** business-ready (integration + logic), **no load** (views only). :contentReference[oaicite:4]{index=4}

## Data Flow (main objects)
Bronze/Silver tables (same names by design):
- CRM: `crm_sales_details`, `crm_cust_info`, `crm_prd_info`
- ERP: `erp_cust_az12`, `erp_loc_a101`, `erp_px_cat_g1v2` :contentReference[oaicite:5]{index=5}

Gold (star schema):
- `gold.dim_customers`
- `gold.dim_products`
- `gold.fact_sales` :contentReference[oaicite:6]{index=6}

## Gold Model Notes
- `fact_sales` links to `dim_customers` via `customer_key` and to `dim_products` via `product_key`. :contentReference[oaicite:7]{index=7}
- `sales_amount` is derived (Sales = Quantity * Price). :contentReference[oaicite:8]{index=8}

## Naming Conventions
- snake_case, English, no reserved words. :contentReference[oaicite:9]{index=9}
- Bronze/Silver: `<sourcesystem>_<entity>` (keep source names). :contentReference[oaicite:10]{index=10}
- Gold: `dim_*`, `fact_*`, `agg_*`; surrogate keys end with `_key`; technical columns start with `dwh_`. :contentReference[oaicite:11]{index=11}
- Load stored procedures: `load_bronze`, `load_silver` (and optional `load_gold`). :contentReference[oaicite:12]{index=12}

## How to Run
1) Execute `load_bronze` (creates/loads Bronze)  
2) Execute `load_silver` (builds Silver from Bronze)  
3) Query Gold views: `gold.dim_customers`, `gold.dim_products`, `gold.fact_sales` :contentReference[oaicite:13]{index=13}
