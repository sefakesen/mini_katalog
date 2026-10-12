import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/cart_state.dart';
import '../widgets/cart_icon_button.dart';
import '../widgets/product_image.dart';
import '../widgets/spec_chip.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product? product;

  const ProductDetailScreen({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    final effectiveProduct = product ??
        (ModalRoute.of(context)?.settings.arguments as Product?);

    if (effectiveProduct == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Ürün Bulunamadı')),
        body: const Center(child: Text('Görüntülenecek ürün bilgisi bulunamadı.')),
      );
    }

    final cart = CartScope.of(context);
    final inCart = cart.isInCart(effectiveProduct);
    final quantity = cart.getQuantity(effectiveProduct);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 90,
        leading: TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF111827),
            padding: const EdgeInsets.only(left: 12),
          ),
          icon: const Icon(Icons.arrow_back_ios_new, size: 16),
          label: const Text(
            'Back',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: CartIconButton(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Büyük Ürün Görseli (Hero Animasyonlu & Hafif gri zeminli)
              Center(
                child: Container(
                  width: double.infinity,
                  height: 280,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Hero(
                    tag: 'product_image_${effectiveProduct.id}',
                    child: ProductImage(
                      product: effectiveProduct,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Ürün İsmi
              Text(
                effectiveProduct.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),

              // Slogan / Tagline
              Text(
                effectiveProduct.tagline,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 22),

              // Açıklama Başlığı (Description)
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),

              // Açıklama Metni
              Text(
                effectiveProduct.description,
                style: const TextStyle(
                  fontSize: 13.5,
                  height: 1.5,
                  color: Color(0xFF4B5563),
                ),
              ),
              const SizedBox(height: 24),

              // Teknik Özellikler Başlığı (Specifications)
              if (effectiveProduct.specs.isNotEmpty) ...[
                const Text(
                  'Specifications',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 12),

                // Özellik Kutucukları (Spec Chips)
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: effectiveProduct.specs.entries.map((entry) {
                    return SpecChip(
                      label: entry.key,
                      value: entry.value,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 28),
              ],
            ],
          ),
        ),
      ),

      // Alt Buton Alanı (Fiyat + Sepete Ekle)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.03),
              blurRadius: 10,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Fiyat Bilgisi
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                  Text(
                    effectiveProduct.price,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),

              // Sepete Ekle / Adet Güncelle Butonu
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF111827),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      cart.addToCart(effectiveProduct);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${effectiveProduct.name} sepete eklendi!'),
                          action: SnackBarAction(
                            label: 'Sepete Git',
                            textColor: Colors.amberAccent,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartScreen(),
                                ),
                              );
                            },
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Text(
                      inCart ? 'Add Another ($quantity)' : 'Add to Cart',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
