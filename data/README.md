```markdown
# Veri Kartı (Data Card)

## 1. Toprak Nemi Sensör Verisi
* **Kaynak:** Kaggle (soil moisture dataset)
* **Lisans:** Açık Lisans (Unknown/Public Domain)
* **İndirme Tarihi:** 5 Kasım 2026
* **Satır/Sütun Sayısı:** [CSV'deki satır sayısını yazın, örn: 1500 satır, 12 sütun]
* **Temizleme Adımları:** 100'ü aşan hatalı nem değerleri tespit edilmiş ve veri aktarımı öncesi SQL tarafında ele alınması planlanmıştır.

## 2. Hava Durumu Verisi
* **Kaynak:** Open-Meteo (Historical Weather API)
* **Lisans:** Ticari olmayan açık kullanım
* **İndirme Tarihi:** 5 Kasım 2026
* **Satır/Sütun Sayısı:** [Örn: 744 satır, 3 sütun]
* **Özellikler:** İstanbul ili, 1 Mart 2020 - 31 Mart 2020 saatlik sıcaklık (Temperature 2m) ve yağış (Precipitation) verisi.

## 3. LLM Çağrı Kayıtları (Sentetik Veri)
* **Kaynak:** ChatGPT / Gemini ile üretilmiştir.
* **Üretim Gerekçesi:** Senaryo 23 gereği, maliyet ve gecikme analizi yapabilmek için sensör verisine uygun çağrı kayıtlarına ihtiyaç duyulmuştur. Asgari veri şartının %70'i (sensör ve hava) gerçek kaynaklardan sağlanmış olup, eksik olan bu tablo dil modeliyle sentetik olarak üretilmiştir[cite: 7].
```
