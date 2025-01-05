import 'package:flutter/material.dart';

import '../../../core/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            title: Text('${product.title}'),
            subtitle: Text('${product.description}'),
            leading: CircleAvatar(
              child: Image.network(
                product.images![0],
                height: 100,
                width: 100,
              ),
            ),
          )),
    );
  }
}
