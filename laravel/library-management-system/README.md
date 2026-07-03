# 📚 Library Management System (Kütüphane Otomasyon Sistemi)

An automated library system where you can manage books, authors, members, and loaning workflows. Developed with **Laravel 12** and **Laravel Breeze (Auth)**.

*Bu proje, bir kütüphanenin kitap yönetimini, üye takibini ve ödünç alma/iade etme süreçlerini otomatize etmek amacıyla Laravel 12 ve Laravel Breeze kullanılarak geliştirilmiş bir web otomasyonudur.*

---

## 🇺🇸 Project Features & Acceptance Criteria

*   **Dynamic Dashboard:** Real-time counters showing total books, authors, members, active loans, and overdue books on a sleek, centralized control panel.
*   **Book & Author Management (CRUD):** Creating, listing, updating, and deleting books and their respective authors.
*   **Member Management (CRUD):** Managing registered library members' profiles and communication details.
*   **Business Rules for Loaning:**
    *   **Stock Control:** If a book's available copy count drops to 0, the system blocks loan attempts and shows an error message.
    *   **Loan Limit:** A member can hold a maximum of 3 active loans. The 4th loan attempt is automatically blocked.
    *   **Duplicate Loan Prevention:** A member cannot loan the exact same book twice simultaneously before returning the first one.
*   **Visual Highlights (Overdue):** Books that have passed their return deadlines are highlighted in **red (`table-danger`)** in the tracking table.
*   **Global Navigation:** A fixed **"Dashboard"** button is placed at the bottom right corner of all index pages to ensure single-click access back to the main panel.

---

## 🇹🇷 Proje Özellikleri & Kabul Kriterleri

*   **Dinamik Dashboard:** Toplam kitap, yazar, üye, aktif ödünç verilen ve süresi geçmiş kitap sayılarını anlık gösteren şık kontrol paneli.
*   **Kitap & Yazar Yönetimi (CRUD):** Kitapların ve yazarların sisteme eklenmesi, listelenmesi, güncellenmesi ve silinmesi.
*   **Üye Yönetimi (CRUD):** Kayıtlı üyelerin profil ve iletişim bilgilerinin yönetimi.
*   **Ödünç Verme İş Kuralları:**
    *   **Stok Kontrolü:** Müsait kopyası (stoku) 0 olan bir kitap ödünç verilmeye çalışıldığında sistem işlemi engeller ve hata fırlatır.
    *   **Kitap Limiti:** Bir üyenin üzerinde aynı anda en fazla 3 aktif kitap olabilir. 4. kitabı almaya çalıştığında sistem tarafından engellenir.
    *   **Aynı Kitabı Tekrar Alma Engeli:** Bir üye, elinde bulunan ve henüz iade etmediği bir kitabın aynısını ikinci kez ödünç alamaz.
*   **Görsel Vurgulama (Gecikenler):** Teslim tarihi geçtiği halde iade edilmeyen kitaplar, tabloda otomatik olarak **kırmızı** renkle gösterilir.
*   **Küresel Navigasyon:** Tüm listeleme sayfalarının sağ alt köşesine eklenen sabit **"Dashboard"** butonu sayesinde tek tıkla ana panele geri dönülebilir.

---

## 🛠️ Tech Stack / Kullanılan Teknolojiler

*   **Backend:** PHP 8.2+ / Laravel 12.x
*   **Authentication:** Laravel Breeze
*   **Database:** MySQL
*   **Frontend:** Bootstrap 5 & Blade Templates