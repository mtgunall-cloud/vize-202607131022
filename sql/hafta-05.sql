-- 1. Tarla başına öneri sayısı ve toplam maliyet (GROUP BY, SUM)
-- Bu sorgu, her bir tarla için kaç kez sulama önerisi üretildiğini ve bu çağrıların LLM'e toplam ne kadar maliyet oluşturduğunu gösterir.
SELECT 
	field_id, 
	COUNT(id) AS recommendation_count, 
	SUM(cost_usd) AS total_cost 
FROM recommendation_calls 
GROUP BY field_id;


-- 2. Sensör okuması olmayan öneri çağrılarının sayısı (COUNT(*) ile COUNT(humidity_pct) farkı)
-- Bu sorgu, sensörden nem verisi gelmediği halde sistemin LLM'e kaç kere çağrı attığını bulmamızı sağlar.
SELECT 
	COUNT(*) AS total_calls,
	COUNT(s.humidity_pct) AS calls_with_reading,
	(COUNT(*) - COUNT(s.humidity_pct)) AS calls_without_reading
FROM recommendation_calls r
LEFT JOIN sensor_okumalari s ON r.field_id = s.field_id AND r.called_at = s.read_at;


-- 3. Ortalama maliyeti yüksek olan bölgeler (HAVING)
-- Bu sorgu, LLM çağrılarında ortalama maliyeti 0.05 USD'nin üzerinde olan, yani en pahalı yanıtların üretildiği bölgeleri listeler.
SELECT 
	f.region, 
	AVG(r.cost_usd) AS avg_cost
FROM recommendation_calls r
JOIN fields f ON r.field_id = f.id
GROUP BY f.region
HAVING AVG(r.cost_usd) > 0.05;


-- 4. Sensör durumuna göre "data present, data missing" etiketi (CASE WHEN) ve gecikme karşılaştırması
-- Bu sorgu, sensör verisi eksik olduğunda LLM'in yanıt gecikmesinin (latency) artıp artmadığını görmek için verileri iki etiketle ayırır.
SELECT 
	CASE 
		WHEN s.humidity_pct IS NOT NULL THEN 'data present'
		ELSE 'data missing'
	END AS sensor_status,
	AVG(r.latency_ms) AS avg_latency
FROM recommendation_calls r
LEFT JOIN sensor_okumalari s ON r.field_id = s.field_id AND r.called_at = s.read_at
GROUP BY 
	CASE
		WHEN s.humidity_pct IS NOT NULL THEN 'data present'
		ELSE 'data missing'
	END;
