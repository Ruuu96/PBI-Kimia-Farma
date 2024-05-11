CREATE TABLE Kimia_Farma.Tabel_Analisa AS
SELECT 
  ft.transaction_id, 
  ft.date, 
  ft.branch_id, 
  kc.branch_name, 
  kc.kota, 
  kc.provinsi, 
  kc.rating AS rating_cabang,
  ft.customer_name, 
  ft.product_id, 
  p.product_name, 
  p.price AS actual_price, 
  ft.discount_percentage,
  CASE
    WHEN (1-ft.discount_percentage)*ft.price <= 50000 THEN 0.10
    WHEN (1-ft.discount_percentage)*ft.price > 50000 AND (1-ft.discount_percentage)*ft.price <= 100000 THEN 0.15
    WHEN (1-ft.discount_percentage)*ft.price > 100000 AND (1-ft.discount_percentage)*ft.price <= 300000 THEN 0.20
    WHEN (1-ft.discount_percentage)*ft.price > 300000 AND (1-ft.discount_percentage)*ft.price <= 500000 THEN 0.25
    ELSE 0.3
  END AS persentase_gross_laba,
  (1-ft.discount_percentage)*ft.price AS nett_sales,
  (1-ft.discount_percentage)*ft.price*(
  CASE
    WHEN (1-ft.discount_percentage)*ft.price <= 50000 THEN 0.10
    WHEN (1-ft.discount_percentage)*ft.price > 50000 AND (1-ft.discount_percentage)*ft.price <= 100000 THEN 0.15
    WHEN (1-ft.discount_percentage)*ft.price > 100000 AND (1-ft.discount_percentage)*ft.price <= 300000 THEN 0.20
    WHEN (1-ft.discount_percentage)*ft.price > 300000 AND (1-ft.discount_percentage)*ft.price <= 500000 THEN 0.25
    ELSE 0.3
  END) AS nett_profit,
  ft.rating AS rating_transaksi
FROM Kimia_Farma.kf_final_transaction AS ft
JOIN Kimia_Farma.kf_kantor_cabang AS kc ON ft.branch_id = kc.branch_id
JOIN Kimia_Farma.kf_product AS p ON ft.product_id = p.product_id;
