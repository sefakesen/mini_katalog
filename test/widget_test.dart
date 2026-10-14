import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog/main.dart';
import 'package:mini_katalog/models/product.dart';
import 'package:mini_katalog/state/cart_state.dart';

void main() {
  group('Mini Katalog Birim ve Durum Testleri', () {
    test('Product modeli fromJson ve toJson doğrulaması', () {
      final json = {
        'id': 101,
        'name': 'Test Kulaklık',
        'tagline': 'Muhteşem Ses',
        'description': 'Yüksek çözünürlüklü ses deneyimi.',
        'price': '\$199',
        'currency': 'USD',
        'image': 'https://wantapi.com/assets/images/airpods.png',
        'specs': {'battery': '30 saat', 'driver': '40mm'},
      };

      final product = Product.fromJson(json);

      expect(product.id, 101);
      expect(product.name, 'Test Kulaklık');
      expect(product.numericPrice, 199.0);
      expect(product.localAssetPath, 'assets/images/airpods.png');
      expect(product.specs['battery'], '30 saat');

      final serialized = product.toJson();
      expect(serialized['id'], 101);
      expect(serialized['name'], 'Test Kulaklık');
    });

    test('CartController ürün ekleme, çıkarma ve hesaplama testi', () {
      final cart = CartController();
      const product1 = Product(
        id: 1,
        name: 'iPhone 15 Pro',
        tagline: 'Titanium',
        description: 'Güçlü telefon',
        price: '\$999',
        currency: 'USD',
        image: 'iphone.png',
        specs: {},
      );

      const product2 = Product(
        id: 20,
        name: 'HomePod Mini',
        tagline: 'Color-pop',
        description: 'Akıllı hoparlör',
        price: '\$99',
        currency: 'USD',
        image: 'homepod_mini.png',
        specs: {},
      );

      expect(cart.totalCount, 0);
      expect(cart.totalPrice, 0.0);

      cart.addToCart(product1);
      expect(cart.totalCount, 1);
      expect(cart.totalPrice, 999.0);
      expect(cart.isInCart(product1), true);

      cart.addToCart(product1);
      expect(cart.totalCount, 2);
      expect(cart.items.first.quantity, 2);
      expect(cart.totalPrice, 1998.0);

      cart.addToCart(product2);
      expect(cart.totalCount, 3);
      expect(cart.totalPrice, 2097.0);
      expect(cart.formattedTotalPrice, '\$2097');

      cart.removeSingleItem(product1);
      expect(cart.totalCount, 2);
      expect(cart.getQuantity(product1), 1);

      cart.removeFromCart(product1);
      expect(cart.totalCount, 1);
      expect(cart.isInCart(product1), false);

      cart.clearCart();
      expect(cart.totalCount, 0);
      expect(cart.items.isEmpty, true);
    });
  });

  group('Mini Katalog Arayüz Duman Testi', () {
    testWidgets('Ana ekran başarıyla yüklenir ve temel bileşenleri gösterir',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MiniKatalogApp());
      await tester.pumpAndSettle();

      expect(find.text('Discover'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
    });
  });
}
