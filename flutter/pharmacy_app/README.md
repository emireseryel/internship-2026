# 📍 Pharmacies on Duty (Nöbetçi Eczane Uygulaması)

[TR] Bu proje, Türkiye genelindeki 81 il için güncel nöbetçi eczane bilgilerini canlı olarak listeleyen, temiz kod (Clean Code) prensiplerine ve katmanlı mimariye (Layered Architecture) uygun olarak geliştirilmiş bir **Flutter** uygulamasıdır.

[EN] This project is a **Flutter** application developed in accordance with Clean Code principles and Layered Architecture, listing live and up-to-date pharmacy on duty information for all 81 provinces across Turkey.

## 🚀 Özellikler / Features

### [TR] Türkçe
* **Canlı Veri Entegrasyonu:** CollectAPI üzerinden güncel nöbetçi eczane verileri anlık olarak çekilir.
* **81 İl Seçimi:** Kullanıcılar dinamik bir açılır menü (Dropdown) üzerinden şehir seçimi yaparak hızlıca arama gerçekleştirebilir.
* **Çoklu Dil Desteği (Localization):** `easy_localization` paketi kullanılarak Türkçe ve İngilizce dil destekleri dinamik olarak entegre edilmiştir. Uygulama, cihazın sistem diline göre otomatik şekillenir.
* **Güvenlik & Hassas Veri Yönetimi:** API Key gibi hassas bilgiler kaynak kodda açık bırakılmamış, `.env` (Environment Variables) mimarisiyle güvenli bir şekilde gizlenmiştir.

### [EN] English
* **Live Data Integration:** Up-to-date pharmacy on duty data is fetched instantly via CollectAPI.
* **81 Provinces Selection:** Users can quickly search by selecting a city through a dynamic dropdown menu.
* **Multi-language Support (Localization):** Turkish and English language options are dynamically integrated using the `easy_localization` package. The app adapts automatically to the device's system language.
* **Security & Sensitive Data Management:** Sensitive information such as the API Key is not left exposed in the source code; it is securely hidden using the `.env` (Environment Variables) architecture.

## 📂 Proje Yapısı / Project Structure

[TR] Proje, genişletilebilir ve bakımı kolay bir yapıda olması için mantıksal katmanlara ayrılmıştır:
[EN] The project is divided into logical layers to ensure scalability and ease of maintenance:

```text
lib/
│
├── models/         # JSON nesne eşlemeleri / JSON object mappings
├── services/       # HTTP istekleri ve API yönetimi / HTTP requests and API management
├── views/          # UI bileşenleri ve ekranlar / UI components and screens
└── main.dart       # Uygulama başlangıç noktası / Application entry point