# Mini Katalog Uygulaması

Flutter ile geliştirilmiş, teknolojik cihazların listelendiği, filtrelendiği ve sepet işlemlerinin gerçekleştirildiği modern bir mini katalog mobil uygulaması.

**Geliştirici:** Sefa Kesen  
**Flutter Sürümü:** 3.47.1 (Channel stable)  
**Dart Sürümü:** 3.13.1  

---

## Özellikler

- **Ürün Keşfi (Discover):** 
  - Kategori banner'ı ve ürün kartlarını içeren 2 sütunlu ızgara (GridView) görünümü.
  - Arama kutusu ile ürün adı, slogan ve açıklamaya göre anlık filtreleme.
  - Sepetteki ürün adedini gösteren dinamik rozetli (badge) sepet butonu.
- **Ürün Detay Sayfası:**
  - Hero animasyonlu büyük ürün görseli.
  - Ürün açıklaması ve teknik özellik kartları (boyut, ses, renk, çip vb.).
  - Sepete ekleme ve kullanıcı bildirimi (SnackBar).
- **Sepet Yönetimi:**
  - Sepete eklenen ürünlerin listelenmesi (`ListView`).
  - Ürün adedi artırma/azaltma ve sepetten çıkarma.
  - Toplam tutar hesaplaması ve sipariş oluşturma (Checkout) akışı.
  - Boş sepet durumu için özel bilgilendirme ekranı.
- **Saf Flutter Mimarisi:**
  - Harici 3. parti paket kullanılmadan yerleşik `ChangeNotifier` ve `InheritedNotifier` ile durum (state) yönetimi.
  - Çevrimdışı çalışabilen yerel veri modeli ve görseller.

---

## Ekran Görüntüleri

| Keşfet (Discover) | Ürün Detayı | Sepet (Dolu) | Sepet (Boş) |
|:---:|:---:|:---:|:---:|
| <img src="screenshots/ana_ekran.png" width="220" /> | <img src="screenshots/urun_detay.png" width="220" /> | <img src="screenshots/sepet_dolu.png" width="220" /> | <img src="screenshots/sepet_bos.png" width="220" /> |

---

## Proje Yapısı

```text
lib/
├── models/
│   ├── product.dart          # Ürün veri modeli (fromJson / toJson)
│   └── cart_item.dart        # Sepet öğesi modeli
├── screens/
│   ├── home_screen.dart      # Ana sayfa ve arama vitrini
│   ├── product_detail_screen.dart # Ürün detay ekranı
│   └── cart_screen.dart      # Sepet ekranı (dolu / boş)
├── services/
│   └── product_service.dart  # Veri yükleme servisi
├── state/
│   └── cart_state.dart       # Sepet kontrolcüsü (CartController & CartScope)
├── widgets/
│   ├── banner_card.dart      # Kampanya banner bileşeni
│   ├── cart_icon_button.dart # Rozetli sepet ikonu
│   ├── product_card.dart     # Ürün kartı
│   ├── product_image.dart    # Görsel yükleme bileşeni
│   └── spec_chip.dart        # Teknik özellik kutucuğu
└── main.dart                 # Uygulama başlangıç noktası ve tema
```

---

## Kurulum ve Çalıştırma

Projeyi yerel ortamınızda çalıştırmak için aşağıdaki adımları takip edebilirsiniz:

1. **Bağımlılıkları Yükleyin:**
   ```bash
   flutter pub get
   ```

2. **Testleri ve Kod Analizini Çalıştırın:**
   ```bash
   flutter analyze
   flutter test
   ```

3. **Uygulamayı Başlatın:**
   ```bash
   # Android emülatör veya bağlı telefon üzerinde çalıştırmak için:
   flutter run
   ```
