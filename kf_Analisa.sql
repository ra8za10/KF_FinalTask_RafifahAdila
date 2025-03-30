CREATE TABLE RAKAMIN.kf_analisa AS
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
WHEN ft.price <= 50000 THEN 10
WHEN ft.price > 50000 AND ft.price <= 100000 THEN 15
WHEN ft.price > 100000 AND ft.price <= 300000 THEN 20
WHEN ft.price> 300000 AND ft.price <= 500000 THEN 25
ELSE 30
END AS persentase_gross_laba,
#rumus net sales adalah harga x diskon
ft.price * (1-ft.discount_percentage/100) AS nett_sales, 
#rumis nett profit adlh harga x diskon x gross laba
ft.price * (1-ft.discount_percentage/100) *
CASE
WHEN ft.price <= 50000 THEN 0.10
WHEN ft.price > 56000 AND ft.price <= 100000 THEN 0.15
WHEN ft.price > 180008 AND ft.price <= 300000 THEN 0.20
WHEN ft.price> 300000 AND ft.price <= 500000 THEN 0.25
ELSE 0.38
END AS nett_profit,
ft.rating AS rating_transaksi

FROM test-final-455207.RAKAMIN.kf_final_transaction AS ft
JOIN test-final-455207.RAKAMIN.kf_kantor_cabang AS kc
ON ft.branch_id = kc.branch_id
JOIN test-final-455207.RAKAMIN.kf_product AS p
ON ft.product_id = p.product_id;
