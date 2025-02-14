import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_project/core/providers/product/product_hive_provider.dart';
import 'package:riverpod_project/ui/screens/re_usable_widgets/cart_product_card.dart';

import '../utils/reusable_functions.dart';

class CartContainer extends ConsumerWidget {
  const CartContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProvider = ref.watch(productHiveProvider);

    if (cartProvider.status == CartStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (cartProvider.status == CartStatus.error) {
      return Center(
        child: Text(
          cartProvider.errorMessage ?? 'Failed to load cart items',
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    }

    if (cartProvider.status == CartStatus.empty) {
      return const Center(
        child: Text(
          'Your cart is empty',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );
    }

    final cartItems = cartProvider.cartItems;

    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.75,
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return CartProductCard(item: item, index: index);
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Proceeding to checkout...')),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 40,
                width: MediaQuery.sizeOf(context).width * 0.5,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Proceed To Cart',
                    style: ReUsableFunctions.appStyle(
                      14,
                      Colors.white,
                      FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
