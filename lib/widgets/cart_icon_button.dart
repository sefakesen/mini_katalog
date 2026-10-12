import 'package:flutter/material.dart';
import '../screens/cart_screen.dart';
import '../state/cart_state.dart';

class CartIconButton extends StatelessWidget {
  final Color? iconColor;

  const CartIconButton({super.key, this.iconColor});

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final count = cart.totalCount;

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: Icon(
            Icons.shopping_bag_outlined,
            color: iconColor ?? Colors.black87,
            size: 26,
          ),
          tooltip: 'Sepet ($count)',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          },
        ),
        if (count > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Center(
                child: Text(
                  count > 99 ? '99+' : count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
