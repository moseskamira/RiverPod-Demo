import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:riverpod_project/core/models/local_product_model.dart';

import '../../../core/providers/product/product_hive_provider.dart';
import '../../utils/reusable_functions.dart';

class CartProductCard extends ConsumerWidget {
  final LocalProductModel item;
  final int index;

  const CartProductCard({
    super.key,
    required this.index,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Slidable(
        key: ValueKey(item.id),
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {},
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.favorite_border,
              label: 'Favorite',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                ref.read(productHiveProvider.notifier).deleteCartItem(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${item.title} removed')),
                );
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          child: ListTile(
            contentPadding: const EdgeInsets.all(12.0),
            leading: CachedNetworkImage(
              imageUrl: item.thumbnail ?? '',
              height: 60,
              width: 60,
              fit: BoxFit.cover,
              placeholder: (_, __) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
            ),
            title: Text(
              item.title ?? 'No Title',
              style:
                  ReUsableFunctions.appStyle(16, Colors.black, FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.description ?? 'No description',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item.category?.toUpperCase() ?? '',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
