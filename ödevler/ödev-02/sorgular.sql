-- 1. Her robotun adı, operatör adı ve operatörün telefonu (INNER JOIN)
SELECT r.name AS robot_adi, o.name AS operator_adi, o.phone AS operator_telefonu
FROM robots r
INNER JOIN operators o ON r.operator_id = o.id;
-- Yorum: Sadece bir operatöre atanmış olan robotlar ve ilgili operatör bilgileri listelendi (operatörü NULL olan robotlar dışarıda kaldı).

-- 2. Aynı liste, ama bütün robotlar görünsün (LEFT JOIN)
SELECT r.name AS robot_adi, o.name AS operator_adi, o.phone AS operator_telefonu
FROM robots r
LEFT JOIN operators o ON r.operator_id = o.id;
-- Yorum: 1. sorgudan farklı olarak operatörü atanmamış (operator_id değeri NULL olan) robotlar da operatör bilgileri boş (NULL) olacak şekilde listeye dahil edildi.

-- 3. Hiç görev almamış robotların adı ve modeli
SELECT r.name AS robot_adi, r.model
FROM robots r
LEFT JOIN missions m ON r.id = m.robot_id
WHERE m.id IS NULL;
-- Yorum: missions tablosunda eşleşen kaydı bulunmayan (hiç göreve çıkmamış) robotların adı ve modeli listelendi.

-- 4. Görevi olan robotların toplam batarya seviyesi (JOIN vs JOIN'siz karşılaştırma)
-- 4a) JOIN ile (Fan-out hatası oluşur):
SELECT SUM(r.battery_level) AS yanlis_toplam_batarya
FROM robots r
INNER JOIN missions m ON r.id = m.robot_id;

-- 4b) JOIN kullanmadan doğru hesaplama:
SELECT SUM(battery_level) AS dogru_toplam_batarya
FROM robots
WHERE id IN (SELECT DISTINCT robot_id FROM missions WHERE robot_id IS NOT NULL);
-- Yorum: JOIN ile yapılan sorguda birden fazla görevi olan robotların batarya seviyesi görev sayısı kadar tekrar toplandığı (fan-out) için toplam değer gerçek değerden yüksek çıktı.

-- 5. Robot başına görev sayısı, hiç görevi olmayanlar 0 görünsün
SELECT r.name AS robot_adi, COUNT(*) AS satir_sayisi, COUNT(m.id) AS gercek_gorev_sayisi
FROM robots r
LEFT JOIN missions m ON r.id = m.robot_id
GROUP BY r.id, r.name;
-- Yorum: Görevi olmayan robotlar için LEFT JOIN sonrası oluşan NULL satırı COUNT(*) 1 olarak sayarken, COUNT(m.id) NULL değerleri saymadığı için doğru şekilde 0 döndürdü.
