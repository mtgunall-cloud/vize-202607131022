# Ödev Raporu

> Bu rapor yazdırılıp derste elden teslim edilir. Aynı dosya reponda `odevler/odev-02/rapor.md` olarak da durur.

**Ödev no:** Ödev 02   **Hafta:** 07   **Tarih:** 27 / 11 / 2026

**Ad Soyad:** Muhammet Günal   **Öğrenci No:** 202607131022

**Program:** [x] Yapay Zeka Operatörlüğü [ ] Robotik ve Yapay Zeka

**Kullandığım veritabanı:** [ ] `llm_ops` [x] `robot_fleet`

**PR bağlantısı:** https://github.com/[kullanici-adin]/[repo-adin]/pull/[PR-numarasi]

**Commit sayısı:** 3

---

### 1. Fan-out

4. soruda `robots` ve `missions` tabloları `INNER JOIN` ile birleştirildiğinde, birden fazla göreve sahip robotların satırları görev sayısı kadar çoğaldığı (fan-out) için `SUM(r.battery_level)` sorgusu aynı robotun batarya değerini her görev satırında tekrar toplayarak gerçek toplamdan çok daha yüksek bir sonuç üretti. Bu birleştirmede 1 görevi olan robot 1 kez sayılırken, birden fazla göreve çıkmış her robot sahip olduğu görev adedi kadar tekrar toplama dahil edildi ve hiç görevi olmayan robotlar ise `INNER JOIN` nedeniyle hesaplama dışında kaldı. Gerçek bir lojistik veya finans raporunda bu bire-çok (1-N) birleştirme kaynaklı tekrarlı toplama hatası; depo kapasitesinin, toplam enerji rezervinin veya cirosunun olduğundan katbekat fazla görünmesine yol açarak hatalı kaynak planlamasına ve yanlış bütçe kararlarına neden olur.

---

### 2. En zor karar

Kendi projemin ERD'sini oluştururken en çok üzerinde düşündüğüm tek karar, tarlalar (`TARLALAR`) ile ekilen ürünler (`URUNLER`) arasındaki çoktan-çoğa (M-N) ilişkiyi nasıl modelleyeceğimdi. Bir tarlaya farklı dönemlerde birden fazla ürün ekilebilmesi ve bir ürünün farklı tarlalarda yetiştirilebilmesi nedeniyle iki tabloyu doğrudan birbirine bağlamak yerine araya **`EKIM_KAYITLARI`** adında bir ara tablo (köprü tablo) ekleme veya tüm geçmişi tek bir geniş tabloda tutma seçenekleri arasında kaldım. Tek tabloda tutmanın veri tekrarına (redundancy) ve güncelleme anomalilerine yol açacağını öngördüğüm için ilişkiyi ara tabloyla bölüp tekil bir birincil anahtar (`kayit_id` PK) tanımladım; böylece hem normalizasyon kurallarına (2NF/3NF) uydum hem de her ekim olayına ait tarih ve yağış verilerini temiz biçimde saklayabildim.

---

### 5. Yapay zeka kullanım beyanı

[ ] Bu ödevde yapay zeka aracı kullanmadım.

[x] Kullandım, aşağıda belirttim:

| Soru no | Araç | Ne sordum (özet) | Cevabı nasıl doğruladım |
| :--- | :--- | :--- | :--- |
| 1-5 (SQL) | Gemini | `INNER JOIN`, `LEFT JOIN`, `IS NULL` ve fan-out etkisini önleyen alt sorgu yapılarını sordum. | Sorguları `robot_fleet` tablolarıyla karşılaştırıp satır sayıları ve `NULL` davranışlarını kontrol ettim. |
| 2.1-2.3 (ERD) | Gemini | Mermaid `erDiagram` sözdizimi ve M-N ara tablo normalizasyon yapısını sordum. | GitHub Preview ekranında diyagramın hatasız çizildiğini ve PK/FK ilişkilerini doğruladım. |

---

### 6. Öz değerlendirme

| Ölçüt | 4 Tam | 3 İyi | 2 Gelişmeli | 1 Yetersiz |
| :--- | :---: | :---: | :---: | :---: |
| **A, Doğruluk** | [x] | [ ] | [ ] | [ ] |
| **B, SQL kalitesi** | [x] | [ ] | [ ] | [ ] |
| **C, Yorum ve analiz** | [ ] | [x] | [ ] | [ ] |
| **D, Git ve PR disiplini** | [x] | [ ] | [ ] | [ ] |
| **E, Dürüstlük ve beyan** | [x] | [ ] | [ ] | [ ] |

**Bir dahaki ödevde daha iyi yapacağım şey:** Sorguları teslim saatinden önce yerel ortamda `psql` ile çalıştırıp kesin satır sayılarını not alarak ilerlemek.

---

### 7. Bana sorun

**Anlamadığın, merak ettiğin ya da derste tekrar görmek istediğin bir konu:** Çoklu `JOIN` işlemlerinde oluşan fan-out etkisini önlemek için alt sorgu (`IN` / `EXISTS`) yerine `CTE` (`WITH` blokları) kullanımını gerçek veri örnekleriyle tekrar görebilir miyiz?

**İmza:** Muhammet
