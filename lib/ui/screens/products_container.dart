import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_project/ui/screens/re_usable_widgets/product_card.dart';

import '../../core/providers/product/product_provider.dart';
import '../app_routes/route_path.dart';

class ProductsContainer extends ConsumerStatefulWidget {
  const ProductsContainer({super.key});

  @override
  ConsumerState<ProductsContainer> createState() => _DashboardContainerState();
}

class _DashboardContainerState extends ConsumerState<ProductsContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final productsFuture = ref.watch(productsProvider.future);
    final mediaQuerySize = MediaQuery.sizeOf(context);
    return Container(
      color: Colors.grey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: mediaQuerySize.width,
              height: mediaQuerySize.height * 0.3,
              child: Column(
                children: [Text(appLocalizations.myReservedSection)],
              ),
            ),
            Container(
              width: mediaQuerySize.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: FutureBuilder(
                    future: productsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No products founds'),
                        );
                      }
                      final products = snapshot.data!;
                      return Column(
                        children: products
                            .map(
                              (product) => Padding(
                                padding: const EdgeInsets.all(10),
                                child: GestureDetector(
                                  onTap: () {
                                    if (context.mounted) {
                                      context.push(RoutePath.productDetailsView,
                                          extra: {
                                            'prodId': product.id.toString()
                                          });
                                    }
                                  },
                                  child: ProductCard(product: product),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
