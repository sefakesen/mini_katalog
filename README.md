# Mini Katalog

Flutter ile geliştirilmiş mini katalog ve sepet mobil uygulaması.

**Geliştirici:** Sefa Kesen

---

## Ekran Görüntüleri

| Keşfet | Ürün Detayı | Sepet (Dolu) | Sepet (Boş) |
|:---:|:---:|:---:|:---:|
| <img src="screenshots/ana_ekran.png" width="220" /> | <img src="screenshots/urun_detay.png" width="220" /> | <img src="screenshots/sepet_dolu.png" width="220" /> | <img src="screenshots/sepet_bos.png" width="220" /> |

---

## Özellikler

- **Ürün Keşfi & Arama:** 2 sütunlu ızgara (GridView) üzerinde ürünleri listeleme ve arama çubuğu ile ürün filtreleme.
- **Ürün Detay Sayfası:** Hero animasyonu ile ürün görseli, teknik özellik kartları ve sepete ekleme işlemi.
- **Sepet Yönetimi:** Sepete eklenen ürünleri listeleme, adet artırma/azaltma, sepeti temizleme ve sipariş tamamlama (Checkout) adımı.
- **Durum Yönetimi:** `ChangeNotifier` ve `InheritedNotifier` kullanılarak sepet rozeti (badge) ve toplam tutar yönetimi.

---

## Proje Yapısı

```text
lib/
├── models/
│   ├── product.dart
│   └── cart_item.dart
├── screens/
│   ├── home_screen.dart
│   ├── product_detail_screen.dart
│   └── cart_screen.dart
├── services/
│   └── product_service.dart
├── state/
│   └── cart_state.dart
├── widgets/
│   ├── banner_card.dart
│   ├── cart_icon_button.dart
│   ├── product_card.dart
│   ├── product_image.dart
│   └── spec_chip.dart
└── main.dart
```

---

## Çalıştırma

Bağımlılıkları yüklemek ve projeyi çalıştırmak için:

```bash
flutter pub get
flutter run
```

Testleri çalıştırmak için:

```bash
flutter test
```
