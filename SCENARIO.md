# Senaryo 23: Tarım — IoT sensör ağı × LLM çağrı kayıtları ve maliyet

## Problem

Sensör verisi eksik olduğunda üretilen tarımsal öneriler daha pahalı mı, daha yavaş mı, yoksa daha kısa mı? Alan bazında sensör okumalarını LLM çağrı kayıtlarıyla eşleştirerek eksik veri düzeyinin token kullanımı, gecikme, maliyet ve çıktı uzunluğu ile ilişkisini inceleyin.

## Tablolar

### `fields`

| Sütun | Açıklama |
|---|---|
| `id` | Tarla kimliği (birincil anahtar) |
| `region` | Tarla bölgesi |
| `soil_type` | Toprak türü |

### `sensor_okumalari`

| Sütun | Açıklama |
|---|---|
| `id` | Sensör okuması kimliği (birincil anahtar) |
| `field_id` | Tarla kimliği (`fields.id` ile ilişkili) |
| `humidity_pct` | Nem yüzdesi; `NULL` ise ölçüm eksik |
| `temp_c` | Sıcaklık (°C); `NULL` ise ölçüm eksik |
| `read_at` | Okuma zamanı |

### `recommendation_calls`

| Sütun | Açıklama |
|---|---|
| `id` | LLM çağrısı kimliği (birincil anahtar) |
| `field_id` | Tarla kimliği (`fields.id` ile ilişkili) |
| `model_name` | Kullanılan model |
| `input_tokens` | Girdi token sayısı |
| `output_tokens` | Çıktı token sayısı |
| `latency_ms` | Çağrı gecikmesi (ms) |
| `cost_usd` | Çağrı maliyeti (USD) |
| `called_at` | Çağrı zamanı |

## Analiz yaklaşımı

Her LLM çağrısı için `called_at` zamanına en yakın sensör okumasını aynı `field_id` üzerinden eşleştirin. Okumanın geçerliliği için veri tazeliği eşiği belirleyin ve bunu analiz boyunca sabit tutun. Hem nem hem sıcaklık mevcutsa sensör durumu **tam**, alanlardan biri eksikse **kısmi**, ikisi de eksikse **eksik** olarak sınıflandırılabilir. Eşleşen okuması olmayan çağrıları ayrıca raporlayın.

Sensör durumu ve model bazında çağrı sayısını, ortalama/medyan `cost_usd`, `latency_ms`, `output_tokens` ve `input_tokens` değerlerini karşılaştırın. Çıktı token sayısını öneri uzunluğu için yaklaşık ölçüt olarak kullanın. Uç değerleri ve örneklem büyüklüklerini de gösterin; sonuçları nedensellik değil ilişki olarak yorumlayın.

## Beklenen çıktı

- Sensör durumu ve model bazında özet metrik tablosu.
- Tam veriye kıyasla eksik veride maliyet, gecikme ve çıktı uzunluğu farkları.
- Veri tazeliği eşiği, eşleştirme yöntemi ve sınırlılıkların kısa açıklaması.
